Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A74ECDDED2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 14:28:24 +1000 (EST)
Subject: Re: powerpc: Add proper reference to dma_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080708135426.43edb5dc.sfr@canb.auug.org.au>
References: <20080708031256.57176084@vitb-lp>
	<20080708135426.43edb5dc.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 14:28:11 +1000
Message-Id: <1215491291.8970.195.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-08 at 13:54 +1000, Stephen Rothwell wrote:
> Hi Vitaly,
> 
> On Tue, 8 Jul 2008 03:12:56 +0400 Vitaly Bordug <vitb@kernel.crashing.org> wrote:
> >
> > +++ b/arch/powerpc/kernel/of_platform.c
> > @@ -76,6 +76,9 @@ struct of_device* of_platform_device_create(struct device_node *np,
> >  		return NULL;
> >  
> >  	dev->dma_mask = 0xffffffffUL;
> > +	dev->dev.dma_mask = &dev->dma_mask;
> 
> That is done in of_device_alloc which is called just above.

So the problem might just be that coherent_dma_mask isn't set.

Ben.
