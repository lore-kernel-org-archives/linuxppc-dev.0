Return-Path: <onramp123@yahoo.com>
Received: from n22a.bullet.mail.mud.yahoo.com (n22a.bullet.mail.mud.yahoo.com
	[68.142.207.188]) by ozlabs.org (Postfix) with SMTP id 64E0DDDDA1
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 03:15:50 +1100 (EST)
From: "Steve DeLaney" <onramp123@yahoo.com>
To: <linuxppc-dev@ozlabs.org>
Subject: mpc8349e-mitx 2.6.25 serial IRQ assigned wrong
Date: Sat, 28 Feb 2009 08:07:33 -0800
Message-ID: <015401c999be$aac03910$6b03a8c0@sdelaney2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20090227125456.GA21435@oksana.dev.rtsoft.ru>
Reply-To: onramp123@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hello all,

We completed a 2.6.25 build for MPC8349E-mITX platform, and u-booting using
the
device tree under ...boot/dts/mpc8349emitx.dts

But the standard platform device IRQs are assigned wrong under
/proc/interrupts:
16 i2c-mpc
17 i2c-mpc
20 serial

According to the device tree, and the processor data sheet, it should be
like this:
9 serial
14 i2c-mpc
15 i2c-mpc

earlier builds (pre-dating device tree) of 2.6.13 and 2.6.16 are OK.
The IRQs are assigned correctly, with serial on 9.

Oddly enough the serial port works OK even though it is assigned to IRQ 20.
We could probably live with it, but this interferes with our application
that uses PCI.
On MPC8349E-mITX, PIC IRQ 20 is intended for PCI INTA that is input
to the MPC8349E processor on IRQ4* signal.

We turned on debug output in irq.c and prom_parse.c 
Any idea what might be going wrong?  We would appreciate any 
suggestions on what to look for.

/steverino2
