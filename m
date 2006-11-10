Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0C3AB67D19
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 23:11:33 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 99DC798396
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 12:53:13 +0100 (CET)
Received: from dial062077236015.pool.invitel.hu
	(dial062077236015.pool.invitel.hu [62.77.236.15])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 9855B9351D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 12:53:12 +0100 (CET)
Subject: Compile Error using SMC1 on a MPC8272 for 2.6.19-rc4
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 10 Nov 2006 12:53:14 +0100
Message-Id: <1163159594.6319.56.camel@Zeus.EmbLux>
Mime-Version: 1.0
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I tried to compile the Linux Kernel 2.6.19-rc5 with a MPC8272 CPU and a
console on SMC1, and get the following Compile Error:

  CC      drivers/serial/cpm_uart/cpm_uart_cpm2.o
drivers/serial/cpm_uart/cpm_uart_cpm2.c: In function
'cpm_uart_init_portdesc':
drivers/serial/cpm_uart/cpm_uart_cpm2.c:364: warning: assignment makes
integer from pointer without a cast
drivers/serial/cpm_uart/cpm_uart_cpm2.c:368: error: invalid type
argument of 'unary *'
make[3]: *** [drivers/serial/cpm_uart/cpm_uart_cpm2.o] Error 1
make[2]: *** [drivers/serial/cpm_uart] Error 2
make[1]: *** [drivers/serial] Error 2
make: *** [drivers] Error 2

The following Code solves the problem:

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 0599030..bb0a6c1 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -349,7 +349,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
 int cpm_uart_init_portdesc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
-	u32 addr;
+	u32 *addr;
 #endif
 	pr_debug("CPM uart[-]:init portdesc\n");
 


thanks
Heiko
