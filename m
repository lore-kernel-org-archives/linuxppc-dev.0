Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5ECA72C012D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 10:24:04 +1100 (EST)
Date: Wed, 20 Nov 2013 23:23:37 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH powerpc] Fix a dma_mask issue of vio
Message-ID: <20131120232337.GT16735@n2100.arm.linux.org.uk>
References: <1384848697.2511.17.camel@ThinkPad-T5421>
 <1384910882.26969.57.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384910882.26969.57.camel@pasglop>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 20, 2013 at 12:28:02PM +1100, Benjamin Herrenschmidt wrote:
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
> 
> I'm asking because I'm worried about breakage elsewhere...

I'd expect that the reason it doesn't work is that the dma_set_mask()
is failing, which means we don't go on to set the coherent mask.

Li Zong's patch works around the issue of a failing dma_set_mask(),
but as I've already said elsewhere, the real fix is to get whatever
created the struct device to initialise the dev->dma_mask with a
bus default.

Using dma_coerce_xxx() merely makes the problem "go away" papering
over the issue - it's fine to do it this way, but someone should still
fix the broken code creating these devices...
