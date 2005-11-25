Return-Path: <aris@mandriva.com>
Received: from oops.ghostprotocols.net
	(cm-net-cwb-C8B031EF.dynamic.brdterra.com.br [200.176.49.239])
	by ozlabs.org (Postfix) with ESMTP id 9679368836
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Nov 2005 00:27:17 +1100 (EST)
Date: Fri, 25 Nov 2005 11:03:03 -0200
From: Aristeu Sergio Rozanski Filho <aris@mandriva.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051125130303.GB2799@oops.ghostprotocols.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DKU6Jbt7q3WqK7+M"
Subject: [PATCH] cpm_uart: fix xchar sending
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
	while using SCC as uart and as serial console at same time I got this:

[  138.214258] Oops: kernel access of bad area, sig: 11 [#1]
[  138.218832] PREEMPT
[  138.221021] NIP: C0105C48 LR: C0105E60 SP: C03D5D10 REGS: c03d5c60 TRAP: 0300    Not tainted
[  138.229280] MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
[  138.234713] DAR: 00000000, DSISR: C0000000
[  138.238745] TASK = c0349420[693] 'sh' THREAD: c03d4000
[  138.243754] Last syscall: 6
[  138.246402] GPR00: FEFFFFFF C03D5D10 C0349420 C01FB094 00000011 00000000 C1ECFBBC C01F24B0
[  138.254602] GPR08: FF002820 00000000 FF0028C0 00000000 19133615 A0CBCD5E 02000300 00000000
[  138.262804] GPR16: 00000000 01FF9E4C 00000000 7FA9A770 00000000 00000000 1003E2A8 00000000
[  138.271003] GPR24: 100562F4 7F9B6EF4 C0210000 C02A5338 C01FB094 00000000 C01FB094 C1F14574
[  138.279376] NIP [c0105c48] cpm_uart_tx_pump+0x4c/0x22c
[  138.284419] LR [c0105e60] cpm_uart_start_tx+0x38/0xb0
[  138.289361] Call trace:
[  138.291762]  [c0105e60] cpm_uart_start_tx+0x38/0xb0
[  138.296547]  [c010277c] uart_send_xchar+0x88/0x118
[  138.301244]  [c01029a0] uart_unthrottle+0x6c/0x138
[  138.305942]  [c00ece10] check_unthrottle+0x60/0x64
[  138.310641]  [c00ecec4] reset_buffer_flags+0xb0/0x138
[  138.315595]  [c00ecf64] n_tty_flush_buffer+0x18/0x78
[  138.320465]  [c00e81b0] tty_ldisc_flush+0x64/0x7c
[  138.325078]  [c010410c] uart_close+0xf0/0x2c8
[  138.329348]  [c00e9c48] release_dev+0x724/0x8d4
[  138.333790]  [c00e9e18] tty_release+0x20/0x3c
[  138.338061]  [c006e544] __fput+0x178/0x1e0
[  138.342076]  [c006c43c] filp_close+0x54/0xac
[  138.346261]  [c0002d90] ret_from_syscall+0x0/0x44
[  138.352386] note: sh[693] exited with preempt_count 2

a easy way to reproduce it is log into the system using ssh and do:
	cat >/dev/ttyCPM0
then, switch to minicom and write some stuff on it back to ssh, a control C
produce the oops

this happens because uart_close calls uart_shutdown which frees xmit.buf,
currently used by xchar sending in cpm_uart_tx_pump(), which seems wrong.

the attached patch fixes the oops and also fixes xchar sending.

Comments?

--
Aristeu


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpm_uart-fix_xchar_sending.patch"

Index: stable/drivers/serial/cpm_uart/cpm_uart_core.c
===================================================================
--- stable.orig/drivers/serial/cpm_uart/cpm_uart_core.c	2005-11-25 10:44:14.000000000 -0200
+++ stable/drivers/serial/cpm_uart/cpm_uart_core.c	2005-11-25 10:44:26.000000000 -0200
@@ -605,7 +605,7 @@
 
 		p = cpm2cpu_addr(bdp->cbd_bufaddr);
 
-		*p++ = xmit->buf[xmit->tail];
+		*p++ = port->x_char;
 		bdp->cbd_datlen = 1;
 		bdp->cbd_sc |= BD_SC_READY;
 		/* Get next BD. */

--DKU6Jbt7q3WqK7+M--
