Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36A252C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 13:05:01 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 20 Nov 2013 12:05:00 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 275843578050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 13:04:57 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAK1l02G61538358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 12:47:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAK24sVk012694
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 13:04:55 +1100
Message-ID: <1384913091.2893.8.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH powerpc] Fix a dma_mask issue of vio
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 20 Nov 2013 10:04:51 +0800
In-Reply-To: <1384910882.26969.57.camel@pasglop>
References: <1384848697.2511.17.camel@ThinkPad-T5421>
 <1384910882.26969.57.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 rmk+kernel@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 12:28 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2013-11-19 at 16:11 +0800, Li Zhong wrote:
> > I encountered following issue:
> > [    0.283035] ibmvscsi 30000015: couldn't initialize event pool
> > [    5.688822] ibmvscsi: probe of 30000015 failed with error -1
> > 
> > which prevents the storage from being recognized, and the machine from
> > booting.
> > 
> > After some digging, it seems that it is caused by commit 4886c399da
> > 
> > as dma_mask pointer in viodev->dev is not set, so in
> > dma_set_mask_and_coherent(), dma_set_coherent_mask() is not called
> > because dma_set_mask(), which is dma_set_mask_pSeriesLP() returned EIO.
> > While before the commit, dma_set_coherent_mask() is always called. 
> > 
> > I tried to replace dma_set_mask_and_coherent() with
> > dma_coerce_mask_and_coherent(), and the machine could boot again. 
> > 
> > But I'm not sure whether this is the correct fix...
> 
> Russell, care to chime in ? I can't make sense of the semantics...
> 
> The original commit was fairly clear:
> 
> <<
>     Replace the following sequence:
>     
>     	dma_set_mask(dev, mask);
>     	dma_set_coherent_mask(dev, mask);
>     
>     with a call to the new helper dma_set_mask_and_coherent().
> >>
> 
> It all makes sense so far ... but doesn't work for some odd reason,
> and the "fix" uses a function whose name doesn't make much sense to
> me ... what is the difference between "setting" and "coercing"
> the mask ? And why doe replacing two "set" with a "set both" doesn't
> work and require a coerce ?

I think the difference is because the check of return value from
dma_set_mask in dma_coerce_mask_and_coherent():
--
        int rc = dma_set_mask(dev, mask);
        if (rc == 0)
                dma_set_coherent_mask(dev, mask);
--

and in struct device {, dma_mask is a pointer, while coherent_dma_mask
is value (don't know why we have this difference). 

And here for pseries, dma_set_mask() failed because the dma_mask pointer
still remains null.

And in dma_coerce_mask_and_coherent(), the dma_mask is set with the
address of coherent_dma_mask
--
	dev->dma_mask = &dev->coherent_dma_mask;
--

Thanks, Zhong

> 
> I'm asking because I'm worried about breakage elsewhere...
> 
> Cheers,
> Ben. 
> 
> > ---
> >  arch/powerpc/kernel/vio.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> > index e7d0c88..76a6482 100644
> > --- a/arch/powerpc/kernel/vio.c
> > +++ b/arch/powerpc/kernel/vio.c
> > @@ -1419,7 +1419,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
> >  
> >  		/* needed to ensure proper operation of coherent allocations
> >  		 * later, in case driver doesn't set it explicitly */
> > -		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
> > +		dma_coerce_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
> >  	}
> >  
> >  	/* register with generic device framework */
> > 
> > 
> > 
> > 
> 
> 
