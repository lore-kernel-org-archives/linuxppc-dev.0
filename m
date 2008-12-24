Return-Path: <jpl@xiphos.ca>
Received: from smtp191.iad.emailsrvr.com (smtp191.iad.emailsrvr.com
	[207.97.245.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABC30DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Dec 2008 10:13:08 +1100 (EST)
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id CE63D1E3105
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Dec 2008 17:48:01 -0500 (EST)
Received: from xiphos.com (webmail16.webmail.iad.mlsrvr.com [192.168.1.21])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id CB5831E307A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Dec 2008 17:48:01 -0500 (EST)
Date: Wed, 24 Dec 2008 17:48:01 -0500 (EST)
Subject: virtex uImage and serial ports
From: "Joshua Lamorie" <jpl@xiphos.ca>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Message-ID: <1230158881.82162837@192.168.1.35>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gidday there,=0A=0AI am trying to get 2.6.27(ish) running on my custom Virt=
ex-II Pro platform (I call it Q5).  I already have many years of running 2.=
4.26 and booting from u-boot.=0A=0AThe problem is getting the console runni=
ng.  I have a device tree blob built and loaded into memory, and by peeking=
 at __log_buf I can see that it is reading this okay (i.e. it is correctly =
finding my interrupt controller).  However, by the time it goes to mount th=
e ramdisk as root, it complains that there is no console.=0A=0AI'm fairly c=
ertain /chosen has stdout pointing to the correct UART, and the console arg=
uments are ttyS0,115200.=0A=0AIn looking through the code however, I cannot=
 figure out how the uImage code actually initializes the serial-ports for t=
he XILINX_VIRTEX_GENERIC_BOARD.  As I understand it, the only place where s=
erial_console_init is called, is within platform_init, and this isn't calle=
d for uImage.=0A=0ASo, three questions.=0A=0A1) How is the serial driver su=
pposed to know where the platforms serial ports are?=0A=0A2) If I wanted to=
 scrap u-boot and just copy kernel/ramdisk/dtb to memory, which kernel make=
 target should I use?  dtbImage, simpleImage?=0A=0A3) What is the best, mos=
t modern image to build that should be used by u-boot?=0A=0AThanks in advan=
ce=0A=0AJoshua=0A=0Ap.s. I've been trying with kernel.org mainline, xilinx =
git and denx ELDK xenomai (2.6.24).  U-boot is built from latest git source=
.  DTS file built from XPS 9.1i with latest service packs, and turned into =
DTB with latest dtc source from git.=0A=0A=0A-- =0AXiphos Technologies=0A(5=
14) 847-9474 x227=0A(514) 848-9644 fax=0A=0Awww.xiphos.com=0A______________=
_________________________________=0AThe information transmitted is intended=
 only for the=0Aperson or entity to which it is addressed and may contain=
=0Aconfidential and/or privileged material.  If you have=0Areceived this in=
 error, please contact the sender and delete=0Athis communication and any c=
opy immediately. Thank you.=0A=0A
