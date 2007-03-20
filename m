Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (loki.aehr.com [207.168.29.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22369DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 15:51:59 +1100 (EST)
From: Thomas Maenner <tmaenner@aehr.com>
To: linuxppc-embedded@ozlabs.org
Subject: ELDK4.1, TQM860L, Kernel 2.6.19
Date: Mon, 19 Mar 2007 21:21:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703192121.01939.tmaenner@aehr.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I've downloaded ELDK4.1 and tried to compile the included kernel 2.6.19.2 
with:
make mrproper
make TQM860L_defconfig
make
(No other changes)

At the end of the compile I get:
---snip---
  UIMAGE  arch/ppc/boot/images/uImage
Image Name:   Linux-2.6.19.2
Created:      Mon Mar 19 15:50:14 2007
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    979098 Bytes = 956.15 kB = 0.93 MB
Load Address: 0x00000000
Entry Point:  0x00000000
  Image: arch/ppc/boot/images/uImage is ready
  AS      arch/ppc/boot/simple/head.o
  AS      arch/ppc/boot/simple/relocate.o
  CC      arch/ppc/boot/simple/misc-embedded.o
  CC      arch/ppc/boot/simple/embed_config.o
arch/ppc/boot/simple/embed_config.c:31: warning: 'bdinfo' defined but not used
arch/ppc/boot/simple/embed_config.c:44: warning: 'def_enet_addr' defined but 
not used
  CC      arch/ppc/boot/simple/m8xx_tty.o
arch/ppc/boot/simple/m8xx_tty.c:32: error: static declaration of 'cpmp' 
follows non-static declaration
include/asm/commproc.h:74: error: previous declaration of 'cpmp' was here
make[2]: *** [arch/ppc/boot/simple/m8xx_tty.o] Error 1
make[1]: *** [simple] Error 2
make: *** [zImage] Error 2
-------

Just in order to get it to compile, I took out static in 
arch/ppc/boot/simple/m8xx_tty.c:
line 32: cpm8xx_t        *cpmp = (cpm8xx_t *)&(((immap_t 
*)IMAP_ADDR)->im_cpm);

BTW, same thing happens if TQM823 config is used.

I'm probably doing something wrong here... ;)

Thanks for your help
Tom
-- 
Thomas Maenner
E-Mail: mailto:tmaenner@aehr.com
