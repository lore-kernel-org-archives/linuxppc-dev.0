Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id E86A8B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Jun 2010 22:55:02 +1000 (EST)
Message-ID: <4C2355A3.8000708@mlbassoc.com>
Date: Thu, 24 Jun 2010 06:54:59 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Continuing UCC UART woes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I thought I had this working, but it seems to only work for UCC3.
Sadly, I can't get it to work on UCC4/UCC5/UCC8 at all.

Starting with UCC4, I have:
             /* ttyQE0 (UCC4) */
             serial_qe0: serial@3200 {
                 device_type = "serial";
                 compatible = "ucc_uart";
                 cell-index = <4>;
                 reg = <0x3200 0x200>;
                 interrupts = <35>;
                 interrupt-parent = <&qeic>;
                 port-number = <0>;
                 rx-clock-name = "brg9";
                 tx-clock-name = "brg10";
                 soft-uart;
             };

With this setup, I can receive characters from the device, but
no characters ever go out.  Same behaviour as before - the output
descriptors get filled, but no action seems to be taken, no interrupts,
etc.  Except randomly there will be output!  For example, if I
connect to the port with minicom, what I type is received by /dev/ttyQE2.
On some rare occasions, what I type is also echoed back, but when
this happens, it's only the first couple of characters, then nothing.

I verified that the CMXUCR registers are being set per the DTS
as well as the BRG registers.  They all look correct:

   ucc_set_qe_mux_rxtx - CMX: 0x000a0000

   root@ppc_target:~ stty </dev/ttyQE0 38400
   qe_setbrg - BRG: fddfd660 = 0x000106b6, CLK = 132000000, RATE = 9600, MULTIPLIER = 16
   qe_setbrg - BRG: fddfd664 = 0x000106b5, CLK = 132000000, RATE = 9600, MULTIPLIER = 1
   qe_setbrg - BRG: fddfd660 = 0x000101aa, CLK = 132000000, RATE = 38400, MULTIPLIER = 16
   qe_setbrg - BRG: fddfd664 = 0x00011ada, CLK = 132000000, RATE = 38400, MULTIPLIER = 1

I've also tried this on UCC5 & UCC8 which show the identical
behaviour - input works, output does not.  I've tried running
with only a single soft UART (UCC4) as well as having all three
configured.  No changes seen.

At this point, I'm using the stock driver from 2.6.33.3

One thing I noticed is that the firmware patch seems quite old.
I got the firmware package from http://opensource.freescale.com/firmware/
We were also told (by FreeScale) to look at https://www.freescale.com/webapp/Download?colCode=QERAMPKG

Looking at these two packages, it's unclear that they match.  Certainly
the dates are very different:

[gthomas@hermes 8358]$ ls -l fsl_qe_ucode QERAMPKG
fsl_qe_ucode:
total 16
-rw-rw-r-- 1 gthomas gthomas 5940 2007-12-10 14:39 fsl_qe_ucode_uart_8360_21.bin
-rw-r--r-- 1 gthomas gthomas 7892 2007-11-30 10:14 license.txt

QERAMPKG:
total 972
-rw-rw-r-- 1 gthomas gthomas 132915 2009-04-07 14:04 SlowProtocols_8323rev11.c
-rw-rw-r-- 1 gthomas gthomas 455446 2009-09-16 15:44 Soft_UART_Microcode_Rel_0_1_2.pdf
-rw-rw-r-- 1 gthomas gthomas  29379 2009-09-16 15:49 Soft_UART_mpc8360_r2.0.h
-rw-rw-r-- 1 gthomas gthomas  29379 2009-09-16 15:14 Soft_UART_mpc8360_r2.1.h
-rw-rw-r-- 1 gthomas gthomas  29379 2009-09-16 15:14 Soft_UART_mpc8568_r1.1.h
-rw-rw-r-- 1 gthomas gthomas 105457 2009-09-16 16:00 SWUART_8360rev20.c
-rw-rw-r-- 1 gthomas gthomas  34689 2009-09-16 15:32 SWUART_8360rev20.srx
-rw-rw-r-- 1 gthomas gthomas 105318 2009-09-16 15:59 SWUART_8360rev21.c
-rw-rw-r-- 1 gthomas gthomas  34689 2009-09-16 15:14 SWUART_8360rev21.srx

Any ideas what I'm doing wrong?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
