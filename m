Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1321999910.14573.11.camel@pasglop>
References: <1321999910.14573.11.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 22 Nov 2011 15:43:47 -0700
Message-ID: <CACxGe6tydq8yGnEMea-cL2Et_vWEBrmpE_Xn9U-rb1nZskxztQ@mail.gmail.com>
Subject: Re: Please revert commit dc9372808412edbc653a675a526c2ee6c0c14a91
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 devicetree-discuss@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tanmay Inamdar <tinamdar@apm.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2011 at 3:11 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi Linus !
>
> Please, revert commit dc9372808412edbc653a675a526c2ee6c0c14a91
>
> "of/irq: of_irq_find_parent: check for parent equal to child"
>
> This breaks some powerpc platforms at least. The practice of having a
> node provide an explicit "interrupt-parent" property pointing to itself
> is an old trick that we've used in the past to allow a device-node to
> have interrupts routed to different controllers.
>
> In that case, the node also contains an interrupt-map, so the node is
> its own parent, the interrupt resolution hits the map, which then can
> route each individual interrupt to a different parent.

Ah, nuts, yes that is broken then.  Yes, please revert the commit and
Rob & I will come up with a better solution.

Rob, I think it can be done by explicitly checking for np ==
desc->interrupt_parent in of_irq_init() instead of relying on
of_irq_find_parent() returning NULL.

g.
