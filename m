Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EC841A0D6C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 08:57:35 +1000 (AEST)
Message-ID: <1430521038.7979.70.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Date: Sat, 02 May 2015 08:57:18 +1000
In-Reply-To: <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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

On Fri, 2015-05-01 at 13:46 -0500, Rob Herring wrote:
> On Fri, May 1, 2015 at 10:22 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Fri, 2015-05-01 at 07:54 -0500, Rob Herring wrote:
> >
> >> The difference seems to be whether you allocate space or just point to
> >> the FDT for various strings/data. Is that right?
> >>
> >> >    * of_fdt_add_subtree() is the introduced API to do the work.
> >>
> >> Have you looked at overlays and if so why do they not work for your purposes?
> >>
> >> Why do you need to do this with the flattened tree?
> >
> > The basic idea I asked Gavin to implement is that since the FW needs to
> > provide a bunch of DT updates to Linux at runtime in the form of new
> > nodes below an existing one, rather than doing it via some new/custom
> > format, instead, have it send a bit of FDT blob to expand under an
> > existing node.
> 
> Overlay = an FDT blob to graft into a live running system. Sounds like
> the same thing.
> 
> > As for the details of Gavin implementation, I haven't looked at it in
> > details yet so there might be issues there, however I don't know what
> > you mean by "overlays", any pointer ?
> 
> CONFIG_OF_OVERLAY
> 
> http://events.linuxfoundation.org/sites/events/files/slides/dynamic-dt-keynote-v3.pdf

Well, that looks horrendously complicated, poorly documented and totally
unused in-tree outside of the unittest stuff, yay ! It has all sort of
"features" that I don't really care about.

I still don't see what it buys me other than making my FW a lot more
complex having to generate all that additional fixup etc... crap that I
don't totally get yet.

What's wrong with just unflattening the nodes in place ? The DT comes
from the FW in the first place so all the phandles are already good in
the new added blob. Internally, the FW created new nodes in its internal
representation and flattened the subtree and sends that subtree to
Linux.

I don't plan to play "revert" either, if you unplug, I do need to remove
what's under the slot but that's true of boot time devices, not just
"new" ones, so the overlay stuff won't do the trick and I certainly
don't want to keep track...

Ben.
