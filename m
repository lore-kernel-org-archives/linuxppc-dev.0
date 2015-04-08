Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED5A71A0B7D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 11:27:17 +1000 (AEST)
Message-ID: <1428456423.22867.501.camel@freescale.com>
Subject: )
From: Scott Wood <scottwood@freescale.com>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Date: Tue, 7 Apr 2015 20:27:03 -0500
In-Reply-To: <20150408011300.GA6395@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
 <1428446044.22867.475.camel@freescale.com>
 <20150407235812.GA3443@ime.usp.br>
 <1428451332.22867.490.camel@freescale.com>
 <20150408003638.GA5170@ime.usp.br>
 <1428454204.22867.497.camel@freescale.com>
 <20150408011300.GA6395@ime.usp.br>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 22:13 -0300, Rogério Brito wrote:
> Hi, Scott.
> 
> On Apr 07 2015, Scott Wood wrote:
> > On Tue, 2015-04-07 at 21:37 -0300, Rogério Brito wrote:
> > > I see. If I do some "archaeology" (read: bisect when it stopped
> > > working), would that help to discover how the flash is connected?
> > 
> > It will probably give you the address and size of the flash, which is
> > good enough to get something working.  Does your config (for the old
> > kernel) have anything with PHYSMAP in it?  I suspect it probably broke
> > with commit dcb3e137ce9be1dfc86e306182b23e3ae5e239c4 ("[MTD] physmap:
> > make physmap compat explicit").
> 
> Here is what my 2.6.27 kernel has in the section regarding physmap:
> 
> ,----
> | #
> | # Mapping drivers for chip access
> | #
> | # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> | CONFIG_MTD_PHYSMAP=y
> | CONFIG_MTD_PHYSMAP_START=0xffc00000
> | CONFIG_MTD_PHYSMAP_LEN=0x400000
> | CONFIG_MTD_PHYSMAP_BANKWIDTH=1
> | # CONFIG_MTD_PHYSMAP_OF is not set
> | # CONFIG_MTD_INTEL_VR_NOR is not set
> | # CONFIG_MTD_PLATRAM is not set
> `----
> 
> Here is what my 4.0-rc6 kernel has:
> 
> ,----
> | #
> | # Mapping drivers for chip access
> | #
> | # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> | CONFIG_MTD_PHYSMAP=y
> | CONFIG_MTD_PHYSMAP_COMPAT=y
> | CONFIG_MTD_PHYSMAP_START=0xffc00000
> | CONFIG_MTD_PHYSMAP_LEN=0x400000
> | CONFIG_MTD_PHYSMAP_BANKWIDTH=1
> | CONFIG_MTD_PHYSMAP_OF=y
> | # CONFIG_MTD_INTEL_VR_NOR is not set
> | # CONFIG_MTD_PLATRAM is not set
> `----
> 
> I may try to revert locally that patch here to see if things improve or not,
> but it will take me some time to compile it (I hope not much).

Oh right, it's the partitions that are missing, rather than the flash
device itself.  It was probably commit
13e0fe49f676607688da7475c33540ec5dac53b5 ("mtd: drop physmap_configure")
that broke your out-of-tree kernel.  Maybe you (or someone) dropped a
call to physmap_set_partitions() to stop the build error, and didn't
replace it with anything?

-Scott
