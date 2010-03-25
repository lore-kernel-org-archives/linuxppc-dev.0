Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6940B7CEE
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 03:35:01 +1100 (EST)
Message-ID: <4BAB90B1.9080603@freescale.com>
Date: Thu, 25 Mar 2010 11:34:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<ed82fe3e1003250742t5affee7dudca651ab3352bc16@mail.gmail.com>
	<fa686aa41003250910n437e4e73p34645f5627d25784@mail.gmail.com>
In-Reply-To: <fa686aa41003250910n437e4e73p34645f5627d25784@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> [cc'd David Gibson]
> 
> On Thu, Mar 25, 2010 at 8:42 AM, Timur Tabi <timur@freescale.com> wrote:
>> The initrd thing is a good idea, but it doesn't help non-Linux
>> operating systems.  Then again, those OS's might not have any GPL
>> issues, so it could be a moot point.
> 
> The more I think about it, the more I think that the initrd is the
> better approach.  Non-GPL firmware blobs are not a new problem, other
> drivers have the same issue and the kernel already has a facility for
> handling them.  Consistency is worth something here.  As you say, the
> ideal solution would be to link the blob into the kernel and be done
> with it.  <grumble>

It would be nice to not have to provide separate copies of the firmware 
to u-boot and Linux -- not from a space perspective, but support. 
Instead of having to make sure people have the right firmware in one 
place, we'd have to make sure they have it in both places.

It would also be nice to not require an initrd if one wants an NFS root. 
  That's a lot more complexity than a not-strictly-necessary phandle. :-P

And as Timur pointed out, the device tree is not just for Linux.  I 
don't think the lack of GPL makes it a moot point, as there's still some 
maintenance and support benefit to keeping it in one place -- especially 
since the appropriate firmware version often depends on the specific 
hardware revision that you have.

>>>  With real OF it is trivial to not have
>>> multiple copies of the data if you want a few properties with
>>> the same data.  There is no reason this could not be done in DTB
>>> as well (and some way in DTS to express that, or maybe the tools
>>> could auto-detect it, whatever).
>> So you're suggesting a change to DTC to support an enhanced syntax?
> 
> It isn't a problem to change dtc if we've got a good use-case for
> doing so.  I've cc'd David Gibson.  He's probably got some insight on
> the best way to handle this without an incompatible .dtb file format
> change.

What Segher suggested sounds like it's fundamentally a .dtb file format 
change.

-Scott
