Return-Path: <panto@antoniou-consulting.com>
Received: from li42-95.members.linode.com (li42-95.members.linode.com
 [209.123.162.95])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87CBE1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 16:23:47 +1000 (AEST)
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <1431564871.4160.8.camel@kernel.crashing.org>
Date: Thu, 14 May 2015 09:23:39 +0300
Message-Id: <53EAE361-0015-4702-97C6-9F67B87963C2@antoniou-consulting.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com>
 <1430774063.7979.139.camel@kernel.crashing.org>
 <1431560124.20218.91.camel@kernel.crashing.org>
 <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com>
 <1431564871.4160.8.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robherring2@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Sorry for taking this long to respond, but I am working on the same =
problem right
now. I thought I might have something to show, but not yet :)

My PCI overlay case is different. In my case there is no firmware and =
there
is the blob is provided as an overlay.

The idea is that for a given PCI bus, when a PCI device with a matching
device id, vendor id is probed a matching overlay should be applied.

The trickiness lies in the way that the way that the target is different
each time and how to handle generational issues (i.e. what happens if =
the pci device
is removed before the application of the overlay occurs, what happens =
when multiple
applications should happen in parallel, etc.)


> On May 14, 2015, at 03:54 , Benjamin Herrenschmidt =
<benh@kernel.crashing.org> wrote:
>=20
> On Wed, 2015-05-13 at 19:18 -0500, Rob Herring wrote:
>=20
>> I haven't decided really.
>>=20
>> The main thing with the current patch is I don't really like the =
added
>> complexity to unflatten_dt_node. It is already a fairly complex
>> function. Perhaps removing of "hybrid" as discussed will help?
>=20
> I agree, we should be able to make that much simpler, I was planning =
on
> sorting that out with Gavin.
>=20

I think using overlays should cover your case without any issues.
I don=E2=80=99t like messing with the unflatten method TBH.

>> If there are things we can do to make overlays easier to use in your
>> use case, I'd like to hear ideas. I don't really buy that being more
>> complex than needed is an obstacle. That is very often the case to
>> have common, scale-able solutions. I want to see a simple case be
>> simple to support.
>=20
> Well, it's a LOT more complex from the FW perspective for a bunch of
> features we don't really need, in a way because the DT update in our
> case is just purely informational to avoid keeping wrong/outdated DT
> bits, it has little functional impact (it might have a bit for =
interrupt
> routing through bridges though).
>=20
> However, I am also pursuing an approach on FW side using a generation
> count in our nodes and properties which we could use to generate
> arbitrary overlays if we know what generation linux has.
>=20
> There might actual be a usage scenario for a generic way for our
> firwmare to convey DT updates to Linux for other reasons.
>=20
> A few things that I don't find in the overlay code (but maybe I =
haven't
> looked at it hard enough):
>=20
> - Can it remove nodes/properties ?
>=20

Yes.

> - Can it "commit" a changeset so it's permanently part of the main DT =
?
> We will never have a concept of "revertable" changesets, if we need a
> subsequent update, we will get a new overlay from FW that will remove
> what needs to be removed and add what needs to be added.
>=20

The overlay when applied is a part of the kernel DT tree.
It is trivial to add a mechanism that simply commits everything and
tosses away the revert information.

Note that in that case you have to make provisions for the unflatten
blob to not be freed or for the device tree nodes/properties to be
dynamically allocated.

> IE, our current mechanism without overlay is fairly simple:
>=20
>  - On PCI unplug, we remove all nodes below the slot (from linux),
> the FW does the equivalent internally.
>=20

If you use an overlay, you just revert it and everything would
be as it was before, without anything hanging below the slot node.

Note that the =E2=80=98remove all nodes below the slot=E2=80=99 does not =
work for my case.

That is because there are devices being instantiated under the slot
(i2c busses, i2c devices, FPGAs etc) that need to be removed from the
system.

>  - On PCI re-plug, the FW internally builds new nodes and sends a
> new subtree as an FDT that we can expand/attach.
>=20

You can easily send a DT blob containing an overlay from firmware.

It can be even easy, since you might not have to recreate the full blob
each time, but instead using flat device tree methods to populate the
few properties that change each time.

> Now we could consider that subtree as a changeset that can be undone,
> but that wouldn't work for boot time. And subsequent updates wouldn't
> have that concept of "undoing" anyway.
>=20

I have posted another patch that does boot-time DT quirk which are
non-revertable.

https://lkml.org/lkml/2015/2/18/258

> IE. conceptually, what overlays do today is quite rooted around the =
idea
> of having a fixed "base" DT and some pre-compiled DTB overlays that
> get added/removed. The design completely ignore the idea of a FW that
> maintains a "live" tree which we want to keep in sync, which is what =
we
> want to do here, or what we could do with a "live" open firmware
> implementation.
>=20
> Now we might be able to reconcile them, but it feels to me that the
> overlay/changeset stuff is too rooted in the first concept=E2=80=A6
>=20

The first DT overlays use case (beaglebone capes) is what got the =
concept
started.

Right now is a generic mechanism to apply modifications to the kernel
live tree, with the possibility to revert them.

> Ben.
>=20
>=20

Regards

=E2=80=94 Pantelis
