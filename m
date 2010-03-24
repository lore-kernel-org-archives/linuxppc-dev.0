Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195]) by ozlabs.org (Postfix) with ESMTP id 4C14CB7CC2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 04:08:04 +1100 (EST)
Received: by yxe33 with SMTP id 33so36882yxe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 10:08:02 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 24 Mar 2010 11:07:42 -0600
Message-ID: <fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Wed, Mar 24, 2010 at 11:00 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>>> Why the phandle redirection? =A0Why not just put the firmware blob into
>>> a property in the QE node, or as a subnode?
>>
>> Because there might be multiple QE devices on a single chip, and each
>> will need to upload the same firmware. =A0So instead of embedding the
>> firmware multiple times, just embed it once, and have a pointer.
>
> You're messing up the binding because of a (perceived) deficiency in
> the DTB format? =A0Or maybe just the DTS format. =A0Or maybe you shouldn'=
t
> even care about size here. =A0Or really, the device tree is the wrong
> place to store firmware blobs at all.

That is a good question.  Why is it necessary to pass the blob via the
tree?  So far we've avoided using firmware blobs in the flat trees.
Or to ask in other words; what is the use case that requires passing
via the device tree?

Also, depending on firmware to correctly squirt the firmware blob into
the dtb at boot is risky.  Even when firmware is buggy, there is
resistance to upgrading firmware on working boards because it could
result in a bricked board.  In fact, every time we depend on firmware
to modify the dtb at boot is risky, so it should only be done when
strictly necessary (I would even say that to date we've probably been
rather too liberal about getting u-boot to modify the device tree).

I would say that either the firmware should be loaded via the existing
(non-dt) firmware loading mechanism, or it should be built into the
static dtb blob.  Don't try to add it at runtime.

g.
