Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8ADC0DDF33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 02:26:51 +1100 (EST)
Date: Tue, 20 Mar 2007 18:26:41 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Thomas Maenner <tmaenner@aehr.com>
Subject: Re: ELDK4.1, TQM860L, Kernel 2.6.19
Message-ID: <20070320182641.4795df59@vitb.ru.mvista.com>
In-Reply-To: <200703192121.01939.tmaenner@aehr.com>
References: <200703192121.01939.tmaenner@aehr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 19 Mar 2007 21:21:01 -0700
Thomas Maenner <tmaenner@aehr.com> wrote:

> Hi,
> 
> I've downloaded ELDK4.1 and tried to compile the included kernel 2.6.19.2 
> with:
> make mrproper
> make TQM860L_defconfig
> make
> (No other changes)
> 
> At the end of the compile I get:
> ---snip---
>   UIMAGE  arch/ppc/boot/images/uImage
> Image Name:   Linux-2.6.19.2
> Created:      Mon Mar 19 15:50:14 2007
> Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> Data Size:    979098 Bytes = 956.15 kB = 0.93 MB
> Load Address: 0x00000000
> Entry Point:  0x00000000
>   Image: arch/ppc/boot/images/uImage is ready
>   AS      arch/ppc/boot/simple/head.o
>   AS      arch/ppc/boot/simple/relocate.o
>   CC      arch/ppc/boot/simple/misc-embedded.o
>   CC      arch/ppc/boot/simple/embed_config.o
> arch/ppc/boot/simple/embed_config.c:31: warning: 'bdinfo' defined but not used
> arch/ppc/boot/simple/embed_config.c:44: warning: 'def_enet_addr' defined but 
> not used
>   CC      arch/ppc/boot/simple/m8xx_tty.o
> arch/ppc/boot/simple/m8xx_tty.c:32: error: static declaration of 'cpmp' 
> follows non-static declaration
> include/asm/commproc.h:74: error: previous declaration of 'cpmp' was here
> make[2]: *** [arch/ppc/boot/simple/m8xx_tty.o] Error 1
> make[1]: *** [simple] Error 2
> make: *** [zImage] Error 2
> -------
> 
> Just in order to get it to compile, I took out static in 
> arch/ppc/boot/simple/m8xx_tty.c:
> line 32: cpm8xx_t        *cpmp = (cpm8xx_t *)&(((immap_t 
> *)IMAP_ADDR)->im_cpm);
> 
> BTW, same thing happens if TQM823 config is used.
> 
> I'm probably doing something wrong here... ;)
> 

Well, after make foo_defconfig I usually do make uImage since with u-boot equipped boards full
zImage is not required. 
-- 
Sincerely, 
Vitaly
