Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B48E1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 10:54:50 +1000 (AEST)
Message-ID: <1431564871.4160.8.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Date: Thu, 14 May 2015 10:54:31 +1000
In-Reply-To: <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Grant Likely <grant.likely@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-13 at 19:18 -0500, Rob Herring wrote:

> I haven't decided really.
> 
> The main thing with the current patch is I don't really like the added
> complexity to unflatten_dt_node. It is already a fairly complex
> function. Perhaps removing of "hybrid" as discussed will help?

I agree, we should be able to make that much simpler, I was planning on
sorting that out with Gavin.

> If there are things we can do to make overlays easier to use in your
> use case, I'd like to hear ideas. I don't really buy that being more
> complex than needed is an obstacle. That is very often the case to
> have common, scale-able solutions. I want to see a simple case be
> simple to support.

Well, it's a LOT more complex from the FW perspective for a bunch of
features we don't really need, in a way because the DT update in our
case is just purely informational to avoid keeping wrong/outdated DT
bits, it has little functional impact (it might have a bit for interrupt
routing through bridges though).

However, I am also pursuing an approach on FW side using a generation
count in our nodes and properties which we could use to generate
arbitrary overlays if we know what generation linux has.

There might actual be a usage scenario for a generic way for our
firwmare to convey DT updates to Linux for other reasons.

A few things that I don't find in the overlay code (but maybe I haven't
looked at it hard enough):

 - Can it remove nodes/properties ?

 - Can it "commit" a changeset so it's permanently part of the main DT ?
We will never have a concept of "revertable" changesets, if we need a
subsequent update, we will get a new overlay from FW that will remove
what needs to be removed and add what needs to be added.

IE, our current mechanism without overlay is fairly simple:

  - On PCI unplug, we remove all nodes below the slot (from linux),
the FW does the equivalent internally.

  - On PCI re-plug, the FW internally builds new nodes and sends a
new subtree as an FDT that we can expand/attach.

Now we could consider that subtree as a changeset that can be undone,
but that wouldn't work for boot time. And subsequent updates wouldn't
have that concept of "undoing" anyway.

IE. conceptually, what overlays do today is quite rooted around the idea
of having a fixed "base" DT and some pre-compiled DTB overlays that
get added/removed. The design completely ignore the idea of a FW that
maintains a "live" tree which we want to keep in sync, which is what we
want to do here, or what we could do with a "live" open firmware
implementation.

Now we might be able to reconcile them, but it feels to me that the
overlay/changeset stuff is too rooted in the first concept...

Ben.
