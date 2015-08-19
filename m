Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0148.outbound.protection.outlook.com [157.56.110.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E51691A0514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 07:30:43 +1000 (AEST)
Date: Wed, 19 Aug 2015 16:30:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Pledge Roy-R01356 <roy.pledge@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Bucur
 Madalin-Cristian-B32716" <madalin.bucur@freescale.com>, Wang Haiying-R54964
 <Haiying.Wang@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/qman: Change fsl,qman-channel-id to cell-index
Message-ID: <20150819213021.GA22290@home.buserror.net>
References: <1429311187-19062-1-git-send-email-scottwood@freescale.com>
 <BN3PR0301MB126796C0EC18EEBB26702C588CD10@BN3PR0301MB1267.namprd03.prod.outlook.com>
 <1430858734.16357.256.camel@freescale.com>
 <BN3PR0301MB1267E5A61E7E5BC2789F9E898CDA0@BN3PR0301MB1267.namprd03.prod.outlook.com>
 <1431470762.16357.511.camel@freescale.com>
 <BN3PR0301MB12670C0BE318280D1C53FE0F8C670@BN3PR0301MB1267.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <BN3PR0301MB12670C0BE318280D1C53FE0F8C670@BN3PR0301MB1267.namprd03.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 19, 2015 at 03:52:55PM -0500, Pledge Roy-R01356 wrote:
> Sorry for digging up an old thread here Scott, but we never did close on this discussion.  See my replies inline below....
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, May 12, 2015 6:46 PM
> > To: Pledge Roy-R01356
> > Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; Bucur
> > Madalin-Cristian-B32716
> > Subject: Re: [PATCH 1/2] powerpc/qman: Change fsl,qman-channel-id to cell-
> > index
> > 
> > On Tue, 2015-05-12 at 16:19 -0500, Pledge Roy-R01356 wrote:
> > > > >
> > > > > I don't believe this is correct - let me explain the rational why
> > > > > we had two
> > > > properties in the QMan portal to begin with.
> > > > >
> > > > > The two properties in question are cell-index and fsl,qman-channel-id.
> > > > >
> > > > > The cell-index property is used in u-boot as an index for the
> > > > > software portal
> > > > ID when adding the fsl,liodn from the U-boot table into the device tree.
> > > >
> > > > The device tree is not supposed to contain arbitrary software identifiers.
> > >
> > > I agree - this is why the original device tree bindings removed
> > > cell-index as it can be calculated.
> >  Unfortunately u-boot relied on
> > > this value being present so to be backward compatible we don't have a
> > > way to remove it.  I'm not sure on what the procedure is to change
> > > things u-boot relies on,
> > 
> > Generally the procedure is that we don't change it.  It wouldn't be so bad if
> > using an old U-Boot just meant that datapath doesn't work with upstream
> > kernels (since that doesn't work now), but a dts that makes existing U-Boot
> > crash is another matter.
> 
> If this is true then we can never remove the cell-index property.

Correct.

> The cell-index in this case is referring to the portal index which
> could be calculated from the qman-portal@XXXX value.  My preference
> would be to eliminate cell-index and replace it with this calculation
> but that would mean older u-boot would fail to work with newer kernel. 
> While the bug that caused older u-boot to crash if this property is
> annoying this has been addressed in more recent u-boots.  I can't
> comment on a policy where u-boot must always boot newer version of
> Linux - that means Linux will have to drag along baggage like this
> property for a long time (forever?).

The baggage isn't particularly onerous.  It's just using a suboptimal
property name.  The semantics are exactly the same as
fsl,qman-channel-id.

> > > >
> > > > > The  fsl,qman-channel-id property is used in Linux and corresponds
> > > > > to a hardware value that indicates which channel is dedicated to
> > > > > the software portal.
> > > > >
> > > > > While I'm not aware of a current SoC where the channel ID for a
> > > > > software portal does not match the index (i.e. SWP 0 uses channel
> > > > > 0,
> > > > > etc.)
> > > >
> > > > Thus there's no backward compatibility issue with redefining
> > > > cell-index to mean the channel ID.
> > >
> > > Channel IDs do change and are defined when the SoC is created
> > 
> > But for SoCs that already exist, they won't change, right?  We don't need to
> > care about what existing U-Boot does on new SoCs, since U-Boot would
> > need to be changed to support the new SoC at all.
> 
> This code isn't looking at SoC product numbers - the whole point of
> putting this in the device tree is to avoid doing just that.  If we had
> to add code for each SoC to u-boot we may as well get rid of the device
> tree and hardcode this configuration in the source file that is SoC
> specific.

The point of putting this in the device tree is to avoid per-SoC code in
*Linux*.  U-Boot does use the device tree for similar purposes on some
platforms, but that's not something we've done yet.  I'm not sure how
it's relevant, though.  How would it be different if we had
fsl,qman-channel-id and no cell-index?

When I mentioned U-Boot needing to be updated for new SoCs, I meant to
run in general, not specifically the QMan code.  So, needing to be
compatible with existing QMan code is only an issue for SoCs where an
older U-Boot actually exists.  We don't need to care what the old code
would have done on newer SoCs.

> > >  (look at checks for QMan versions and adjustments for Pool Channel
> > > IDs in the driver).  If the channel ID for portal 0 ever becomes non
> > > zero we just end up having to make a mess in the code or reintroduce
> > > this field.
> > 
> > What defines that portal as "portal 0"?
> 
> Portal 0 is portal 0 because it is at offset 0 in the QMan portal
> memory region.  Portal 1 is at 0x4000 etc...  Note that this is not the
> case for forthcoming ARM devices as portals are distributed at 64K
> intervals.  However since the device tree parsing code for ARM is
> separate from the PPC code this will not pose any issue.

I don't understand why it would cause an issue in any case.  U-Boot would
need to either know the mapping from portal address to channel id, or get
it from the device tree.  There's no need to introduce the concept of
"portal number" except perhaps as some internal implementation detail.

> 
> > 
> > > > > it is possible that future SoCs could stray from this model, there
> > > > > is no reason for portal index to equal channel ID at all times.
> > > >
> > > > How can future SoCs dictate how we assign a software-defined
> > identifier?
> > > > If software wants it to be the same as the channel id, then it will be.
> > > >
> > > > If there is some aspect of the hardware itself (not the
> > > > documentation) that cell-index currently corresponds to, other than
> > > > the channel id, please make that clear.
> > >
> > > Channel ID is defined in the SoC RTL - it is not controlled by
> > > software and it is not a software assigned identifier.  It is not
> > > possible for SW to set these values.
> > 
> > I said "other than the channel id".  In particular, I was asking about the
> > concept of "portal index".
> 
> The only thing cell-index indicates is the offset of the portal in the
> QMan address space.

cell-index has been redefined to not mean that at all.  It now only means
channel ID.  We can do this because the value happens to be the same for
all existing SoCs (and we should be sure to avoid putting things into the
SDK for the aforementioned ARM chips that are contrary to the new
definition).

-Scott
