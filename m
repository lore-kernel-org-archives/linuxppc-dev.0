Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB13EB7CF4
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 05:28:06 +1100 (EST)
Date: Wed, 24 Mar 2010 13:27:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
Message-ID: <20100324182757.GA25270@loki.buserror.net>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
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

On Wed, Mar 24, 2010 at 11:07:42AM -0600, Grant Likely wrote:
> On Wed, Mar 24, 2010 at 11:00 AM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >>> Why the phandle redirection?  Why not just put the firmware blob into
> >>> a property in the QE node, or as a subnode?
> >>
> >> Because there might be multiple QE devices on a single chip, and each
> >> will need to upload the same firmware.  So instead of embedding the
> >> firmware multiple times, just embed it once, and have a pointer.
> >
> > You're messing up the binding because of a (perceived) deficiency in
> > the DTB format?  Or maybe just the DTS format.  Or maybe you shouldn't
> > even care about size here.  Or really, the device tree is the wrong
> > place to store firmware blobs at all.
> 
> That is a good question.  Why is it necessary to pass the blob via the
> tree?

We previously put the firmware in flash, and passed a pointer on the kernel
command line.  Not only is that more complicated and error prone, it
requires that virtualized guests be granted access to the flash.

> Also, depending on firmware to correctly squirt the firmware blob into
> the dtb at boot is risky.  Even when firmware is buggy, there is
> resistance to upgrading firmware 

We need to use different terms for the boot firmware and the device
firmware. :-)

> on working boards because it could result in a bricked board.  In fact,
> every time we depend on firmware to modify the dtb at boot is risky, so it
> should only be done when strictly necessary (I would even say that to date
> we've probably been rather too liberal about getting u-boot to modify the
> device tree).

On p4080 we've gone much farther down that road, a large chunk of the device
tree content is generated dynamically by u-boot.  Being able to use the
device tree to move information from the firmware to the OS is one of the
big benefits of using the tree, IMHO.  If you end up in a situation where
you just can't use the firmware's tree for whatever reason, ignore it and
use a kernel-provided tree and you'll be no worse off than what you'd have
us do all the time.

And it's not even really relevant to whether the firmware goes in the dtb --
you could just as easily stick it in there statically with a binary include
in the dts.

> I would say that either the firmware should be loaded via the existing
> (non-dt) firmware loading mechanism, or it should be built into the
> static dtb blob.  Don't try to add it at runtime.

The binding should only be concerned with what's in the tree, not how it
gets there.

-Scott
