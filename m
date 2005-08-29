Return-Path: <carl.ljungmark@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 85F2F68179
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 21:14:06 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 2A234FB8A2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 12:52:57 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 0D472FB8A2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 12:52:57 +0200 (CEST)
Received: from clj.sysgo.com (clj.sysgo.com [172.24.1.170])
	by donald.sysgo.com (Postfix) with ESMTP id 0BD6218B713
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 12:52:56 +0200 (CEST)
Date: Mon, 29 Aug 2005 12:52:55 +0200
To: linuxppc-embedded@ozlabs.org
From: "Carl Ljungmark" <carl.ljungmark@sysgo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Message-ID: <op.sv9m6hio0c7u6q@clj.sysgo.com>
Subject: serial line on mpc5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!
I have 2.6.12 up and running on my mpc5200, but are experiencing a proble=
m =20
with the
serial line.
PSC1+3 are both registered as uarts during boot

Serial: MPC52xx PSC driver
ttyS0 at MMIO 0xf0002000 (irq =3D 39) is a MPC52xx PSC
ttyS2 at MMIO 0xf0002400 (irq =3D 41) is a MPC52xx PSC

, but I don't get the 2nd line to work.

# cat /proc/tty/driver/mpc52xx_psc_uart
shows
serinfo:1.0 driver revision:
0: uart:MPC52xx PSC mmio:0xF0002000 irq:39 tx:3546 rx:112 =20
RTS|CTS|DTR|DSR|CD
2: uart:MPC52xx PSC mmio:0xF0002400 irq:41 tx:0 rx:0 CTS|DSR|CD
#

(IRQ 41 isn't shown under /proc/interrupts - and no entry under =20
/proc/irq/41, but
the irq 41 count IS increased when writing to the port - as shown under =20
/proc/stat)

under 2.4.31 both serial lines work, so it's not hardware. In 2.4 the =20
serial lines show up as /dev/tts/{0,1}, whereas in 2.6 they show up as =20
/dev/tts/{0,2}.

Does anyone know what the problem might be?

thanks in advance..
/carl
