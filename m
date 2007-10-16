Return-Path: <alan@akb.net>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 2A52CDDE2F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 00:19:55 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so135159anc
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:19:54 -0700 (PDT)
Message-ID: <bfa0697f0710160719r44099b19jbda55af2ef88e9f8@mail.gmail.com>
Date: Tue, 16 Oct 2007 08:19:53 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Serial init / BRG
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For some reason I'm unable to track down the right sequence to
initialize my serial ports.  (note: my console is working, but
attempts to initialize SCC1 and SCC4 fail).  My console has the luxury
of having uboot initialize it and its brg, but SCC1 / SCC4 aren't so
lucky.

  A few questions:  To use 3 brgs, should I have 1 brg entry and X reg
values or three brg entries in my device tree?  what are the third and
fourth reg values of the brg item in the device tree.  I'll  need 3
separate baud rates on the serial lines.  Should I just add code to
initialize the brg's in u-boot or figure out how to get the kernel to
do it?

boot sequence
===========
 CPM UART serial mem=e0011a80 pram=e0000000
 ttyCPM0 at MMIO 0xe0011a80 (irq = 16) is a CPM UART

 CPM UART serial mem=e0011a00 pram=e0008000
 CPM uart[1]:init_scc - sup = e0008000
 ttyCPM1 at MMIO 0xe0011a00 (irq = 40) is a CPM UART

 CPM UART serial mem=e0011a60 pram=e0008300
 CPM uart[2]:init_scc - sup = e0008300
 ttyCPM2 at MMIO 0xe0011a60 (irq = 43) is a CPM UART

BRG Values after above
=================
brgc1: 0x00000000
brgc2: 0x00000000
brgc3: 0x00000000
brgc4: 0x00000000
brgc5: 0x00000000
brgc6: 0x00000000
brgc7: 0x0001004e
brgc8: 0x00000000

Device Tree:
                       brg@119f0 {
                               compatible = "fsl,mpc8272-brg",
                                            "fsl,cpm2-brg",
                                            "fsl,cpm-brg";
                               reg = <119f0 10 115f0 10>;
                       };
                       /* Monitor port/SMC1 */
                       serial@11a80 {
                               device_type = "serial";
                               compatible = "fsl,mpc8248-smc-uart",
                                            "fsl,cpm2-smc-uart";
                               reg = <11a80 20 0 40>;
                               interrupts = <4 8>;
                               interrupt-parent = <&PIC>;
                               fsl,cpm-brg = <7>;
                               fsl,cpm-command = <1d000000>;
                       };
                       /* "Serial" port/SCC1 */
                       serial@11a00 {
                               device_type = "serial";
                               compatible = "fsl,mpc8248-scc-uart",
                                            "fsl,cpm2-scc-uart";
                               reg = <11a00 20 8000 100>;
                               interrupts = <28 8>;
                               interrupt-parent = <&PIC>;
                               fsl,cpm-brg = <1>;
                               fsl,cpm-command = <00800000>;
                       };
                       /* "Serial" port/SCC4 */
                       serial@11a60 {
                               device_type = "serial";
                               compatible = "fsl,mpc8248-scc-uart",
                                            "fsl,cpm2-scc-uart";
                               reg = <11a60 20 8300 100>;
                               interrupts = <2B 8>;
                               interrupt-parent = <&PIC>;
                               fsl,cpm-brg = <4>;
                               fsl,cpm-command = <0CE00000>;
                       };
