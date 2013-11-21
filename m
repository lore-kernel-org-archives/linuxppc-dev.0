Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 409152C0141
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 12:57:03 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 21 Nov 2013 07:26:55 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4E6EF3940057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 07:26:52 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAL1ukKC37879888
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 07:26:46 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAL1upwe006975
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 07:26:51 +0530
Message-ID: <1384999009.2566.2.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH powerpc] Fix a dma_mask issue of vio
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Nov 2013 09:56:49 +0800
In-Reply-To: <1384993347.26969.124.camel@pasglop>
References: <1384848697.2511.17.camel@ThinkPad-T5421>
 <1384910882.26969.57.camel@pasglop>
 <20131120232337.GT16735@n2100.arm.linux.org.uk>
 <1384992102.26969.120.camel@pasglop>
 <20131121000819.GU16735@n2100.arm.linux.org.uk>
 <1384993347.26969.124.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-21 at 11:22 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2013-11-21 at 00:08 +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 21, 2013 at 11:01:42AM +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2013-11-20 at 23:23 +0000, Russell King - ARM Linux wrote:
> > > > Li Zong's patch works around the issue of a failing dma_set_mask(),
> > > > but as I've already said elsewhere, the real fix is to get whatever
> > > > created the struct device to initialise the dev->dma_mask with a
> > > > bus default.
> > > > 
> > > > Using dma_coerce_xxx() merely makes the problem "go away" papering
> > > > over the issue - it's fine to do it this way, but someone should still
> > > > fix the broken code creating these devices...
> > > 
> > > Ok, they are created by the vio bus core, so it should be doing the
> > > job here of setting the dma_mask pointer to a proper value.
> > > 
> > > Li, can you take care of that ? Look at other bus types we have in
> > > there such as the macio bus etc...
> > 
> > Oh, hang on a moment, this is the "bus" code.
> > 
> > In which case, the question becomes: do vio devices ever need to have
> > a separate streaming DMA mask from a coherent DMA mask?  If not, then
> > something like the following is what's needed here, and I should've
> > never have used dma_set_mask_and_coherent().
> 
> No, a single mask.
> 
> > dma_set_mask_and_coherent() (and the other dma_set_mask() functions)
> > are really supposed to be used by drivers only.
> > 
> >  arch/powerpc/kernel/vio.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> > index e7d0c88f621a..d771778f398e 100644
> > --- a/arch/powerpc/kernel/vio.c
> > +++ b/arch/powerpc/kernel/vio.c
> > @@ -1419,7 +1419,8 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
> >  
> >  		/* needed to ensure proper operation of coherent allocations
> >  		 * later, in case driver doesn't set it explicitly */
> > -		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
> > +		viodev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
> > +		viodev->dev.dma_mask = &viodev->dev.coherent_dma_mask;
> >  	}
> >  
> >  	/* register with generic device framework */
> 
> Right that's exactly what I had in mind. Li, can you test this please ?

Sure, and it works.

Tested-by: Li Zhong <zhong@linux.vnet.ibm.com>

> 
> The previous "fix" using dma_coerce_mask_and_coherent() is already on
> its way to Linus, so we'll rework the above patch to undo it but for
> now please test.
> 
> Cheers,
> Ben.
> 
> 
