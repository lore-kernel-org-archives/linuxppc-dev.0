Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B0CCB7CEF
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 04:31:58 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2OHVt6t020953
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 10:31:56 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o2OHeF09004595
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 12:40:15 -0500 (CDT)
Message-ID: <4BAA4C8A.70104@freescale.com>
Date: Wed, 24 Mar 2010 12:31:54 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
In-Reply-To: <fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
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

Grant Likely wrote:
> On Wed, Mar 24, 2010 at 11:00 AM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
>>>> Why the phandle redirection?  Why not just put the firmware blob into
>>>> a property in the QE node, or as a subnode?
>>>
>>> Because there might be multiple QE devices on a single chip, and each
>>> will need to upload the same firmware.  So instead of embedding the
>>> firmware multiple times, just embed it once, and have a pointer.
>>
>> You're messing up the binding because of a (perceived) deficiency in
>> the DTB format? 

Huh?  Who says anything about messing up?  I don't see anything "messed up" about including a blob of data with proper compatible properties, etc.

>> Or maybe just the DTS format.  Or maybe you shouldn't
>> even care about size here.  Or really, the device tree is the wrong
>> place to store firmware blobs at all.
> 
> That is a good question.  Why is it necessary to pass the blob via the
> tree? 

Because sometimes the firmware is needed before networking or serial I/O can function.  Today, we do one of two things on systems with QE (or QE-like microcontrollers):

1) U-Boot uploads the firmware, and may create a DTB node that provides some information about the firmware.

2) U-Boot uploads the firmware, but then gives Linux the physical address (in flash) of the firmware so that it can upload it again.

> So far we've avoided using firmware blobs in the flat trees.
> Or to ask in other words; what is the use case that requires passing
> via the device tree?

The Fman devices on the Freescale P4080 needs to have the firmware uploaded by the kernel before they will function.  I can't depend on having the firmware on the root file system, and we can't embed it in the kernel itself (because it's proprietary), so where else should I put it?  Today, we just leave it in flash and give the physical address to the Fman Linux driver via a command-line parameter.  But that doesn't work because then it means we have to have flash mapped to every partition that runs Linux.  

> Also, depending on firmware to correctly squirt the firmware blob into
> the dtb at boot is risky.  Even when firmware is buggy, there is
> resistance to upgrading firmware on working boards because it could
> result in a bricked board.

I'm not sure what you're getting at.  This has nothing to do with upgrading firmware.  The firmware is already in flash, I just need a better way of giving it to the kernel.  If you upgrade the firmware in flash, then U-Boot will automatically provide the new version to the kernel via the DTB.  I just don't see how upgrading is a factor.

>  In fact, every time we depend on firmware
> to modify the dtb at boot is risky, so it should only be done when
> strictly necessary (I would even say that to date we've probably been
> rather too liberal about getting u-boot to modify the device tree).

Embedding the firmware blob in the DTS is uglier than having U-Boot do it, IMHO.

> I would say that either the firmware should be loaded via the existing
> (non-dt) firmware loading mechanism, 

That, unfortunately, is not an option.

> or it should be built into the
> static dtb blob.  Don't try to add it at runtime.

Then how do I distribute the firmware blob?  It's not GPL, so it can't go into arch/powerpc/boot/dts/.  Are you suggesting I do this in the DTS:

/ {
	model = "MPC8323EMDS";
	compatible = "MPC8323EMDS", "MPC832xMDS", "MPC83xxMDS";
	#address-cells = <1>;
	#size-cells = <1>;

...

	qe_firmware:qe-firmware {
		compatible = "fsl,qe-firmware";
		fsl,firmware = <0x70 0xcd 0x00 0x00 0x01 0x46 0x45 0x63 ...>
	}
}

Most firmware is 8-12KB, so this will make for one ugly DTS.  Plus, there's the issue of distributing non-GPL firmware data inside a DTS, which is GPL.

-- 
Timur Tabi
Linux kernel developer at Freescale
