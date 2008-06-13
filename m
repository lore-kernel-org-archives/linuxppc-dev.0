Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F5C5DE09A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jun 2008 01:31:22 +1000 (EST)
Message-ID: <485292C2.6030103@freescale.com>
Date: Fri, 13 Jun 2008 10:31:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Florian Boelstler <euphoria@arcor.de>
Subject: Re: Reserving small amounts of memory with mem= (MPC85xx,   2.6.15
	arch/ppc)
References: <g2ri8j$qlk$1@ger.gmane.org>	<d194b8ce0806121214w2ac2edf6n7f222eb51463a989@mail.gmail.com>
	<g2u0ae$238$1@ger.gmane.org>
In-Reply-To: <g2u0ae$238$1@ger.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Florian Boelstler wrote:
> Available system memory is only 384 MB (CAM0+CAM1+CAM2), which explains 
> why Linux "removed" the ramdisk, when it has been copied right below 
> 508M by U-Boot. Because at that time I was using initrd_high @ 1FC00000, 
> which is outside of mapped RAM.
> 
> Is there an option to map less than 64M by a CAM entry?

CAM entries can be any power of 4 between 4K and 256M.  However, the 
code currently is hardcoded to use no more than 3 entries.  It shouldn't 
be too hard to change it to use a few more (see cam_mapin_ram(), 
mmu_mapin_ram(), and adjust_total_lowmem() in 
arch/powerpc/mm/fsl_booke_mmu.c).

Alternately, do you have highmem enabled?  That will let you access the 
rest of the RAM that the CAM doesn't map, though I don't know if an 
initrd in highmem works.

-Scott
