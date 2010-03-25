Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20AD9B7CF6
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 03:46:28 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2PGkQqq001624
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 09:46:26 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o2PGsm8C004047
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 11:54:48 -0500 (CDT)
Message-ID: <4BAB9361.8090900@freescale.com>
Date: Thu, 25 Mar 2010 11:46:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<ed82fe3e1003250742t5affee7dudca651ab3352bc16@mail.gmail.com>
	<fa686aa41003250910n437e4e73p34645f5627d25784@mail.gmail.com>
	<4BAB90B1.9080603@freescale.com>
In-Reply-To: <4BAB90B1.9080603@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

> It would be nice to not have to provide separate copies of the firmware 
> to u-boot and Linux -- not from a space perspective, but support. 

My plan was to take the copy that U-Boot already knows about (via macros like CONFIG_SYS_QE_FW_ADDR) and have U-Boot dynamically embed that in the DTB.  That eliminates the support issue, and it allows us to continue to use the firmware that we already distribute in flash on our boards.

> It would also be nice to not require an initrd if one wants an NFS root. 

The more I think about it, the more I believe that this is how we're going to have to do it.  Whether or not Freescale can embed a non-GPL firmware into a device tree is still undecided.  It may require relicensing all of our device trees as dual bsd/gpl first.  Technically, we should probably do that anyway.

>   That's a lot more complexity than a not-strictly-necessary phandle. :-P

I agree with that.  

> And as Timur pointed out, the device tree is not just for Linux.  I 
> don't think the lack of GPL makes it a moot point, as there's still some 
> maintenance and support benefit to keeping it in one place -- especially 
> since the appropriate firmware version often depends on the specific 
> hardware revision that you have.

Our QE/Fman firmware is typically highly dependent on the specific SOC version.  So if we produce a new revision of an SOC, we typically have to release a new version of the firmware.  I can imagine a situation where our boards ship with every possible firmware in flash, and U-Boot has to find the right one.  In that case, U-Boot will embed the right one in the DTB when it boots the kernel.

This is why I'm opposed to a requirement that the firmware be in the DTS.  If that works for some other people's boards, that's great.  But it won't work for anything that Freescale ships.

>> It isn't a problem to change dtc if we've got a good use-case for
>> doing so.  I've cc'd David Gibson.  He's probably got some insight on
>> the best way to handle this without an incompatible .dtb file format
>> change.
> 
> What Segher suggested sounds like it's fundamentally a .dtb file format 
> change.

That's the impression I got, as well.

-- 
Timur Tabi
Linux kernel developer at Freescale
