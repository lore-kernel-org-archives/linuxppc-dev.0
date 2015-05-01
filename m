Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CC121A0D1C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 09:29:51 +1000 (AEST)
Message-ID: <1430522976.7979.78.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Date: Sat, 02 May 2015 09:29:36 +1000
In-Reply-To: <1430521038.7979.70.camel@kernel.crashing.org>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
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

On Sat, 2015-05-02 at 08:57 +1000, Benjamin Herrenschmidt wrote:

> > Overlay = an FDT blob to graft into a live running system. Sounds like
> > the same thing.
> > 
> > > As for the details of Gavin implementation, I haven't looked at it in
> > > details yet so there might be issues there, however I don't know what
> > > you mean by "overlays", any pointer ?
> > 
> > CONFIG_OF_OVERLAY
> > 
> > http://events.linuxfoundation.org/sites/events/files/slides/dynamic-dt-keynote-v3.pdf
> 
> Well, that looks horrendously complicated, poorly documented and totally
> unused in-tree outside of the unittest stuff, yay ! It has all sort of
> "features" that I don't really care about.

Looking a bit more at it, I don't quite see how I can attach a subtree
using that stuff.

Instead, each node in the overlay seems to need extra nodes and
properties to refer to the original.

So the FW would essentially have to create something a lot more complex
than just reflattening a bit of its internal tree. For each internal
node, it will need to add all those __overlay__ nodes and properties.

That is not going to fly for me at all. It's order of magnitudes more
complex than the solution we are pursuing.

So I think for our use case, we should continue in the direction of
having a helper to unflatten a piece of FDT underneath an existing
node. I don't like the "HYBRID" stuff though, we should not refer to
the original FDT, we should just make them normal dynamic nodes.

Ben.
