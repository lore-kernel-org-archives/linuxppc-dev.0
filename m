Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7A232DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 15:18:21 +1000 (EST)
To: =?UTF-8?q?Albrecht_Dre=C3=9F?= <albrecht.dress@arcor.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Compile new kernel for 5200B w/ ELDK
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1220375903l.5712l.0l@antares>
References: <1219770125l.5709l.0l@antares> <m2bpz8j5bw.fsf@ohwell.denx.de>
	<1220375903l.5712l.0l@antares>
Date: Wed, 03 Sep 2008 07:18:18 +0200
Sender: wd@denx.de
Message-Id: <20080903051818.BCA3F24815@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Albrecht,

In message <1220375903l.5712l.0l@antares> you wrote:
> 
> Thanks a lot for your hint, but unfortunately it doesn't solve my  
> problem:
> - downloaded 2.6.26.3 from kernel.org;
> - called "make ARCH=powerpc CROSS_COMPILE=ppc_6xx-  
> 52xx/lite5200b_defconfig";
> - called "make ARCH=powerpc CROSS_COMPILE=ppc_6xx- uImage".

Missing step: build the device tree blob.

> However, even with "console=ttyPSC0,115200 verbose panic=1" in the  
> bootargs, the kernel simply doesn't say /anything/ after decompression:
> 
> <snip>
> => bootm
> ## Booting kernel from Legacy Image at 01000000 ...
>     Image Name:   Linux-2.6.26.3
>     Created:      2008-09-02   9:11:12 UTC
>     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>     Data Size:    1341904 Bytes =  1.3 MB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
>     Uncompressing Kernel Image ... OK
> </snip>

The "bootm" command without arguments does just start the Linux kernel
image. In this form, it does NOT pass the device tree to the Linux
kernel. You must use

	=> bootm 01000000 - <dtb_addr>

instead (after downloading the DTB to the <dtb_addr> address).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A right is not what someone gives you; it's what no one can take from
you.                                                   - Ramsey Clark
