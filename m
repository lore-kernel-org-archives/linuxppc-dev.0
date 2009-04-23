Return-Path: <amarquez@edgeaccess.net>
Received: from [209.168.173.179] (unknown [209.168.173.179])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "firewall.edgeaccess.net",
	Issuer "firewall.edgeaccess.net" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E20DFDE0E0
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 10:20:39 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by firewall.edgeaccess.net (Postfix) with ESMTP id 4B7C6274053
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 19:52:54 -0400 (EDT)
Received: from mail.edgeaccess.net (unknown [192.168.10.99])
	by firewall.edgeaccess.net (Postfix) with ESMTP id 51B4027402B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 19:52:53 -0400 (EDT)
Received: from mail.edgeaccess.net (localhost.localdomain [127.0.0.1])
	by mail.edgeaccess.net (8.13.8/8.13.8) with ESMTP id n3NNPagI016138
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 19:25:37 -0400
Date: Thu, 23 Apr 2009 19:50:25 -0400
From: Andres F Marquez <amarquez@edgeaccess.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <1240530625.31311.20.camel@localhost.localdomain>
Subject: Enable Serial Management Controller (SMC) in MPC8265
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nirmala Kakkuppi <nkakkuppi@edgeaccess.net>,
	Haysam Rachid <hrachid@edgeaccess.net>
Reply-To: Andres Marquez <amarquez@edgeaccess.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

     I am working with a MPC8265 processor for which I am compiling a
Kernel using LTIB. I just came to a point in my project in which I need
an additional serial port to interface my CPU with a FPGA. Since my
UTOPIA interface is using several serial ports -pins, the only option
that I find available is to use a Serial Management Controller (SMC)
port (SMC1 or SMC2).

      I enabled SCC1 (for the console) and SMC2 through the Kernel
(2.6.25) configuration tool using LTIB. I am able to run my system and
execute minicom to try to configure the needed serial port. I have not
been able to find the tty port that refers to either one of the two SMC
ports. I have tried all the tty's that I get when I do ls /dev/tty* but
none of them seem to work. Below, I provide the list of tty's that I am
getting. ttyCPM0 is being used for the console. ttyCPM1 is the only one
that I am allowed to configure through minicom (for the rest it says
device not found). But even after configuring ttyCPM1 I don't see
anything through the serial lines.

-sh-2.05b# ls /dev/tty*
Using fallback suid method
/dev/tty      /dev/tty7     /dev/ttyP1    /dev/ttyPSC5  /dev/ttyp3
/dev/tty0     /dev/ttyAM0   /dev/ttyP2    /dev/ttyS0    /dev/ttyp4
/dev/tty1     /dev/ttyAM1   /dev/ttyP3    /dev/ttyS1    /dev/ttyp5
/dev/tty2     /dev/ttyAM2   /dev/ttyPSC0  /dev/ttyS2    /dev/ttyp6
/dev/tty3     /dev/ttyAM3   /dev/ttyPSC1  /dev/ttyS3    /dev/ttyp7
/dev/tty4     /dev/ttyCPM0  /dev/ttyPSC2  /dev/ttyp0    /dev/ttyp8
/dev/tty5     /dev/ttyCPM1  /dev/ttyPSC3  /dev/ttyp1    /dev/ttyp9
/dev/tty6     /dev/ttyP0    /dev/ttyPSC4  /dev/ttyp2
-sh-2.05b# 

   I am not sure how to know which one of them belongs to the SMC serial
controllers. 

     After doing some research online, I added an entry in my
mpc8272ads.dts file for the smc serial controller. Below, I provide the
entries for the serial ports (one SCC1 and one SMC2):

                        serial@11a00 {
                                device_type = "serial";
                                compatible = "fsl,mpc8280-scc-uart",
                                             "fsl,cpm2-scc-uart";
                                reg = <11a00 20 8000 100>;
                                interrupts = <28 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <2>;
                                fsl,cpm-command = <00800000>;
                        };

                        serial@11a92 {
                                device_type = "serial";
                                compatible = "fsl,mpc8280-smc-uart",
                                                "fsl,cpm2-smc-uart";
                                reg = <11a92 20 88fc 2>;
                                interrupts = <5 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <2>;
                                fsl,cpm-command = <21200000>;
                        };

     I am kind of confused about what I could be missing in order to use
the SMC. I don't even need it to be UART. I just need a serial interface
for a FPGA which I am programming. One thing in which I was successful
was in configuring in uboot the console to run in the SMC2 port -instead
of the default which is SCC1 (I was able to boot uboot and the kernel
through the SMC2 serial port -using NFS). However, I need in my system
both enable (SCC1 and SMC2). I have not been able to do that. I am not
sure if it is possible or not. I have made a lot of changes in the .dts
file but have not been successful. For some reason in uboot, it seems
like the configurations for SCC1 and SMC2 are exclusive. They depend on
where the console is configured (SCC1 or SMC2). Either one can be
configured, but not both at the same time (at least based on uboot
configuration definitions. They are within if's and elif's...). As I
said before, both of them are able to run the console.

Thank you in advance for any help.

Bye.


ANDRES
