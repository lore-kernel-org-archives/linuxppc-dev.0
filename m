Return-Path: <dgibson@ozlabs.org>
Date: Thu, 8 May 2008 11:59:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: Use dcrinfrastructure.
Message-ID: <20080508015948.GG5156@yookeroo.seuss>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.4F3AC1C9004A@mail57-sin.bigfish.com>
	<fa686aa40805052155q43a7ebd8x14c1711bd4c6bbfa@mail.gmail.com>
	<20080506061444.GB17798@yookeroo.seuss>
	<20080506174352.52C857D805C@mail62-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080506174352.52C857D805C@mail62-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 06, 2008 at 10:43:50AM -0700, Stephen Neuendorffer wrote:
[snip]
> > > Hmmm, something doesn't quite feel right about this.  The node
> > > describing the tft device is a child of the dcr@0 node which is the
> > > dcr bus.  However, dcr bindings use dcr-bus and dcr-reg instead of
> > > parent-child relationship to specify how to access the dcr
> registers.
> > > So, in this example; if the device is described by tft@80, and the
> dcr
> > > bus is described by opb2dcr-bridge@40700000, then what does dcr@0
> > > describe?  (I do understand what they really describe in EDK terms;
> > > but I'm looking at it through device tree glasses).
> > >
> > > I don't think the presence of a dcr@0 node is a problem, but in this
> > > case #size/address-cells doesn't have any meaning (the child doesn't
> > > have a reg property) and it looks like it should be a child of the
> > > opb2dcr-bridge node (otherwise, what is it attached to?).
> > 
> > Yes, indeed.  If dcr@0 is representing the DCR bus / interface it
> > should really have the dcr-access-method property and have all the
> > dcr-parent handles point at it.
> 
> Hmm, I tend to agree.  Certainly the address-cells and size-cells can
> go.  Part of the nastiness is that I'm trying to maintain a modicum of
> backward compatibility at the moment in the device tree generator.  This
> structure allow the dcr@0 node to have ranges; and the tft node to have
> a properly translated reg = <> property for the existing driver which
> only understands mmio.  I don't think it really works for the opb2dcr
> bridge to be a bridge and a dcr-controller at the same time. :)  This
> structure is also very similar to what is generated if the
> dcr-controller is native from the processor (there's just no bridge).

I don't really understand what you're getting at here, sorry.  Perhaps
you could describe what you're doing with the tft device in more
detail?

> > Current standard practice is not to represent the DCR bus as node with
> > subnodes for the DCR-controlled devices.  That's because the DCR bus
> > tends to run in addition to other on-chip busses, and some things have
> > to go on another on-chip bus to make sense, but still have DCR control
> > registers (for example the internal bus bridges on 4xx).
> > 
> > Arguably for DCR-only devices we should instead have a node
> > representing the DCR bus and just put the devices under it with the
> > DCR number encoded in reg in the normal way.  But then its
> > inconsistent with the devices that need the other DCR representation.
> 
> Yup, it's exactly this problem I'm trying to fix in the case of the tft
> driver.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
