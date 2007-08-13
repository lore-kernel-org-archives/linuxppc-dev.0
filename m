Return-Path: <jyoung5@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40DBBDDE47
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 07:04:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7DL4ZIr001069
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 17:04:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7DL4Zre540688
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 17:04:35 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7DL4Zt8012355
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 17:04:35 -0400
Subject: Re: Sequoia 440EPx patches not working
From: Jerone Young <jyoung5@us.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <46BB41EB.5030207@ru.mvista.com>
References: <1186598710.5459.7.camel@laptop>
	<20070809165612.12100334@localhost.localdomain>
	<1186670238.5547.25.camel@laptop>  <46BB41EB.5030207@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 13 Aug 2007 16:04:35 -0500
Message-Id: <1187039075.28166.25.camel@laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I got it to load now cuImage.sequoia and loading at address 0x200000. I
had been trying to load at 0x400000...apparently this was not good. So
moving to 0x300000 it loads but stops after setting up the device tree.
So the image was clobbering something but now is not at 0x200000.
Thanks for the help.
                       Jerone

On Thu, 2007-08-09 at 20:33 +0400, Valentine Barshak wrote:
> Jerone Young wrote:
> > So did a rebase on kernel.org 2.6.23-rc2 patch (as opposed the latest
> > git). I am using Uboot version  1.2.0-gc0c292b2. This is the version
> > that came with the board. It still appears to hang during early boot on
> > my Sequoia.
> > 
> > Trying the cuImage.sequoia.bin.gz just result in Uboot giving "Bad Magic
> > Number" when trying to boot it. This is also the same for using
> > cuImage.sequoia.elf. 
> > 
> > So when I use the uImage file it will load but just hang after it's
> > loaded. I'm building it using "make uImage CROSS_COMPILE=<cross prefix>
> > ARCH=powerpc" on an x86 box.
> > 
> > I'll see what else I could possibly be doing wrong (maybe something
> > happened to the patch when I grabbed it off of gmane and the web filters
> > did something to it, I did have to fix a problem where in the
> > sequoia.dts file the web filter replace "@" with " at ". This was simple
> > enough to fix. Maybe something else when wrong. I'll see what else I can
> > look at.
> > 
> > On Thu, 2007-08-09 at 16:56 +0400, Vitaly Bordug wrote:
> >> On Wed, 08 Aug 2007 13:45:10 -0500
> >> Jerone Young wrote:
> >>
> >>> Using the Sequoia (AMCC 440EPx) patches recently submitted to the
> >>> list I am unable to boot to fully boot a uImage built with these
> >>> patches under Uboot. It appears to hang in very early boot.
> >>>
> >>>
> >>> Here is the output:
> >>> => tftp 400000
> >>> sequoia/uImage ENET Speed is 100 Mbps - FULL duplex connection
> >>> (EMAC0) Using ppc_4xx_eth0
> >>> device TFTP from server 9.53.41.24; our IP address is
> >>> 9.53.41.38 Filename
> >>> 'sequoia/uImage'. Load address:
> >>> 0x400000 Loading:
> >>> #################################################################
> >>> #################################################################
> >>> #################################################################
> >>> #######################
> >>> done Bytes transferred = 1112434 (10f972
> >>> hex) => bootm
> >>> 400000 ## Booting image at
> >>> 00400000 ... Image Name:
> >>> Linux-2.6.23-rc2 Image Type:   PowerPC Linux Kernel Image (gzip
> >>> compressed) Data Size:    1112370 Bytes =  1.1
> >>> MB Load Address:
> >>> 00000000 Entry Point:
> >>> 00000000 Verifying Checksum ...
> >>> OK Uncompressing Kernel Image ... OK 
> >>>
> >>> _______________________________________________
> >>> Linuxppc-dev mailing list
> >>> Linuxppc-dev@ozlabs.org
> >>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >> This seems to be a wrong image..
> >>
> >> Are you using "make zImage" ?
> >>
> >> The proper uImage after that command would be smth like cuImage* then...
> >>
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> Please, apply clean patches (not filtered by web filters) and
> try make ARCH=powerpc CROSS_COMPILE=<cross_prefix> zImage
> The image should be at arch/powerpc/boot/cuImage.sequoia
