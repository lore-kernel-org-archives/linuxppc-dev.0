Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CD821A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2015 02:59:36 +1000 (AEST)
Received: by wibut5 with SMTP id ut5so63704015wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2015 09:59:32 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring
 <robherring2@gmail.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Gavin Shan
 <gwshan@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
In-Reply-To: <1431564871.4160.8.camel@kernel.crashing.org>
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
Date: Sun, 07 Jun 2015 08:54:22 +0100
Message-Id: <20150607075422.6ECE9C40A12@trevor.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for not weighing in earlier, I've had other work keeping me away.

My short answer: don't use overlays. They're not what you need. Generic
CONFIG_OF_DYNAMIC should be all that is required to make changes in your
use case.

Overlays are a specific api for being able to apply a set of changes in
a revertable way, but as you say, it is a lot more complicated. However,
overlays are built on top of the of_changeset API which is a lot
simpler. It doesn't do any phandle resolution, and it doesn't do any
tracking. It takes a set of changes (attach node, detach node, add
property, remove property), an applies them to the live tree. At that
point the changes are permenant*.

It is documented in Documentation/devicetree/changesets.txt

Ideally, I want all DT changes to go through the changeset API so that
the lifecycle issues are delt with in one place. It also defers firing
notifiers until after the entire changeset is applied. With
of_attach_node/of_detach_node the notifiers are sent immediately after
each change when the tree may be in an inconsistent state. For example,
a driver expecting child nodes, but the child nodes haven't been added
yet.

Comments below...

* There is an API for reverting a changeset, which simply applies the
  changes backwards and in reverse. The overlay code uses it, but you
  won't need it.

On Thu, 14 May 2015 10:54:31 +1000
, Benjamin Herrenschmidt <benh@kernel.crashing.org>
 wrote:
> On Wed, 2015-05-13 at 19:18 -0500, Rob Herring wrote:
> 
> > I haven't decided really.
> > 
> > The main thing with the current patch is I don't really like the added
> > complexity to unflatten_dt_node. It is already a fairly complex
> > function. Perhaps removing of "hybrid" as discussed will help?
> 
> I agree, we should be able to make that much simpler, I was planning on
> sorting that out with Gavin.

Ditto here. I don't want to have any new kinds of nodes created either.
They are either OF_DYNAMIC, and therefore freeable, or they are not and
cannot be freed.

> > If there are things we can do to make overlays easier to use in your
> > use case, I'd like to hear ideas. I don't really buy that being more
> > complex than needed is an obstacle. That is very often the case to
> > have common, scale-able solutions. I want to see a simple case be
> > simple to support.
> 
> Well, it's a LOT more complex from the FW perspective for a bunch of
> features we don't really need, in a way because the DT update in our
> case is just purely informational to avoid keeping wrong/outdated DT
> bits, it has little functional impact (it might have a bit for interrupt
> routing through bridges though).
> 
> However, I am also pursuing an approach on FW side using a generation
> count in our nodes and properties which we could use to generate
> arbitrary overlays if we know what generation linux has.
> 
> There might actual be a usage scenario for a generic way for our
> firwmare to convey DT updates to Linux for other reasons.
> 
> A few things that I don't find in the overlay code (but maybe I haven't
> looked at it hard enough):
> 
>  - Can it remove nodes/properties ?

Overlays: No, because I asked Pantelis to drop them.
Changeset: yes, absolutely

>  - Can it "commit" a changeset so it's permanently part of the main DT ?
> We will never have a concept of "revertable" changesets, if we need a
> subsequent update, we will get a new overlay from FW that will remove
> what needs to be removed and add what needs to be added.

Yes

> IE, our current mechanism without overlay is fairly simple:
> 
>   - On PCI unplug, we remove all nodes below the slot (from linux),
> the FW does the equivalent internally.
> 
>   - On PCI re-plug, the FW internally builds new nodes and sends a
> new subtree as an FDT that we can expand/attach.
> 
> Now we could consider that subtree as a changeset that can be undone,
> but that wouldn't work for boot time. And subsequent updates wouldn't
> have that concept of "undoing" anyway.
> 
> IE. conceptually, what overlays do today is quite rooted around the idea
> of having a fixed "base" DT and some pre-compiled DTB overlays that
> get added/removed. The design completely ignore the idea of a FW that
> maintains a "live" tree which we want to keep in sync, which is what we
> want to do here, or what we could do with a "live" open firmware
> implementation.

Right, which is exactly the reason for the changeset/overlay split.
Overlays assume a fixed base, and that overlays are kind of like plug-in
modules. changeset makes no such assumption.

g.
