Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 677B31A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 17:47:50 +1000 (AEST)
Message-ID: <1431589652.4160.49.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Thu, 14 May 2015 17:47:32 +1000
In-Reply-To: <D7FC0542-DD1A-428F-8E75-81620C6D83DC@antoniou-consulting.com>
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
 <1431587657.4160.37.camel@kernel.crashing.org>
 <75F026CA-5AC1-4106-B2F0-AB0D006DEF5A@antoniou-consulting.com>
 <1431588358.4160.42.camel@kernel.crashing.org>
 <D7FC0542-DD1A-428F-8E75-81620C6D83DC@antoniou-consulting.com>
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

On Thu, 2015-05-14 at 10:34 +0300, Pantelis Antoniou wrote:

> >> What you describe is inserting a bunch of properties and nodes under
> >> a slot’s device node. Reverting the overlay removes them all just fine.
> > 
> > Except that still doesn't work for boot time :-)
> > 
> > So I would have to do a special case on unplug:
> > 
> > 	if (slot->dt_is_overlay) /* set to false at boot */
> > 		remove_subtree_myself();
> > 	else
> > 		undo_overlay(slot->overlay);
> > 
> 
> OK, in that case you do require removal. But in any case it’s the ‘negative’
> of an already applied one, either at boot time or not.

Sort-of, unless we have a way in the overlay to simply specify node
removal statements so we don't have to explicitly remove all properties
(or even all children).

> Modifying the overlay code to apply a ‘negative’ property should do the trick.
> 
> Is that correct?

I would do negatives node and let Linux imply the properties (or even
children).

But yes, that would probably do.

 .../...

> I will probably need that generation count myself for my PCI use case.
> 
> > However that requires supporting removal of nodes/properties. So I'm
> > tempted to keep that feature on the back burner and go with an ad-hoc
> > interface for PCI for now.
> > 
> 
> I see. Bonne chance :)

Merci :)

Cheers,
Ben.
