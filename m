Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 691A81A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 17:14:39 +1000 (AEST)
Message-ID: <1431587657.4160.37.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Thu, 14 May 2015 17:14:17 +1000
In-Reply-To: <3988EABE-3DE9-4E1C-9778-22E35138E359@antoniou-consulting.com>
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
 <53EAE361-0015-4702-97C6-9F67B87963C2@antoniou-consulting.com>
 <1431585994.4160.32.camel@kernel.crashing.org>
 <3988EABE-3DE9-4E1C-9778-22E35138E359@antoniou-consulting.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2015-05-14 at 10:04 +0300, Pantelis Antoniou wrote:

> Hmm, since you just want to transmit a whole subtree things are a bit
> simpler.
> 
> You don’t need any of the fixups, and your target node is known.
> 
> So your overlay is simply:
> 
> / {
> 	fragment@0 {
> 		target-path = “/foo”;
> 		__overlay__ {
> 			/* contents of the slot */
> 		};
> 	}; 
> };
>
> I think it’s possible to just bit-mangle a blob (in pseudo code).
> 
> 	const u8 template_overlay_blob[] = { <compiled blob of the above> };
> 
> 	flatten_slot(slot_blob);
> 
> 	overlay_blob = allocate_new_blob(template_overlay_blob, slot_blob);
> 
> 	overlay_node = find_node(overlay_blob, “/fragment@0/__overlay__);
> 	target_prop = find_prop(overlay_blob, “/fragment@0/target-path”);
> 
> 	inject_slot_blob(overlay_blob, overlay_node, slot_blob);
> 	modify_slot_target(overlay_blob, target_prop, slot_target);
> 	
> I don’t think you need to re-flatten anything, shuffling bits around with
> memmove should work.

Fairly gross :-)

But yeah generating the overlay doesn't necessarily scare me, I can
generate a temp tree that is the overlay in which I "copy" the subtree
(or in my internal ptr-based representation I could have a concept of
alias which I follow while flattening).

That leaves me with these problems:

 - No support for removing of nodes, so that needs to be added back to
the format and to Linux unless I continue removing by hand in the PCI
hotplug code itself

 - No support for "committing" the overlay which needs to be added as
well.

> >>> Now we could consider that subtree as a changeset that can be undone,
> >>> but that wouldn't work for boot time. And subsequent updates wouldn't
> >>> have that concept of "undoing" anyway.
> >>> 
> >> 
> >> I have posted another patch that does boot-time DT quirk which are
> >> non-revertable.
> >> 
> >> https://lkml.org/lkml/2015/2/18/258
> > 
> > Not sure how that applies in my case ... I can't change the
> > representation of the PCI subtree, this is standard OFW representation,
> > I can't change the FW to make it an overlay-like thing at boot time,
> > that would break existing kernels.
> > 
> 
> The idea is to append the ‘quirk’ to the already booting device tree blob.

I know but that's not how things work for me. At boot time the FW passes
me one tree that contains all the PCI stuff it has probed.

> Another idea floating around was to simple concatenate the booting blob with
> any overlay blobs you want applied at boot time.

Sure but I don't get overlay blobs at boot time.

> >>> IE. conceptually, what overlays do today is quite rooted around the idea
> >>> of having a fixed "base" DT and some pre-compiled DTB overlays that
> >>> get added/removed. The design completely ignore the idea of a FW that
> >>> maintains a "live" tree which we want to keep in sync, which is what we
> >>> want to do here, or what we could do with a "live" open firmware
> >>> implementation.
> >>> 
> >>> Now we might be able to reconcile them, but it feels to me that the
> >>> overlay/changeset stuff is too rooted in the first concept…
> >>> 
> >> 
> >> The first DT overlays use case (beaglebone capes) is what got the concept
> >> started.
> >> 
> >> Right now is a generic mechanism to apply modifications to the kernel
> >> live tree, with the possibility to revert them.
> > 
> > Yes but as I said it's not really thought in term of keeping the kernel
> > tree in sync with an external dynamically generated tree. Maybe we can
> > fix it, but it's more complex…
> > 
> 
> Yes it is, unfortunately.

Right. Which makes the solution of just passing my bit of tree as a blob
which I expand in Linux where I want it rather than an overlay tempting
if we can make Gavin patch more palatable (removing the hybrid stuff
etc...).

Cheers,
Ben.

> > Ben.
> > 
> >>> Ben.
> >>> 
> >>> 
> >> 
> >> Regards
> >> 
> >> — Pantelis
> > 
> > 
> 
> Regards
> 
> — Pantelis
