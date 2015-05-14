Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0114.outbound.protection.outlook.com [157.56.110.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A39841A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 06:10:21 +1000 (AEST)
Message-ID: <1431634199.3868.195.camel@freescale.com>
Subject: Re: Specifying the MTD partitions in a device tree
From: Scott Wood <scottwood@freescale.com>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Date: Thu, 14 May 2015 15:09:59 -0500
In-Reply-To: <20150514054858.GA4608@ime.usp.br>
References: <20150514054858.GA4608@ime.usp.br>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: debian-arm@lists.debian.org, debian-powerpc@lists.debian.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-14 at 02:48 -0300, Rogério Brito wrote:
> Hi.
> 
> I am sending this message to Debian/powerpc, Debian/arm lists because and
> linuxppc-dev.  While the issue that I'm having is with a powerpc machine,
> the arm people may also be of valuable help with device trees, since they
> have to deal with them seemingly all the time.
> 
> Anyway, the problem that I have is as follows: I have a Kurobox HG (powerpc)
> NAS that Riku Voipio donated me a few years ago.
> 
> Everything worked fine and I was able to get Debian (since kernel 2.6.20 or
> similar) running up to with kernels 2.6.28 (if my memory serves me well).
> With kernel 2.6.29, the partitions of the MTD device that this machine has
> were not displayed anymore (only one big device was presented to the user).
> 
> In a recent exchange [0] with Scott Wood from the linuxppc-dev, I was
> finally able to partition the MTD flash device with the original layout of
> the device by passing an `mtdparts` option to the kernel.
> 
> [0]: http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/80215
> 
> 
> It seems, though, that the proper way to fix this issue for good is to
> include such description in the DTS files for the particular board (in fact,
> at least 2---but potentially 4---boards are affected by this).

Why is that the "proper way"?  It might make sense for certain
fixed-purpose devices where partitioning is an unchanging part of the
platform, but for general purpose hardware, it's user configuration
which doesn't belong in the device tree.  The fact that your dts patch
says "my (rbrito) U-Boot currently uses:" reinforces this.

> I tried a few experiments with writing a patch to the existing dts files,
> but I wasn't successful, since I am not sure about a good amount of the
> things and I would appreciate some assistance here.
> 
> In particular, I don't know if I filled all the fields correctly and, also,
> I don't know where I should "graft" the description of the flash chip in the
> rest of the device tree.

The flash chip itself, OTOH, should go in the device tree.

> Can anybody help here? I am sending a verbosely and dirty patch (not yet
> suitable for inclusion in the main kernel tree) that I created (and which
> didn't work) with as much information that I know about the system, but I
> can surely collect more information.

It would be easier to comment on it if it weren't an attachement.

You appear to be adding the chip to the soc10x node, but this won't work
without adding to the ranges property of that node -- and it doesn't
belong there anyway, since it's not part of the SoC.  Put it directly
under the root node, and make sure your platform code has "cfi-flash" in
of_bus_ids[].

You shouldn't need vendor-id, device-id, or erase-size -- this should be
automatically probed.  Those properties are meant for non-CFI devices.

-Scott
