Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 535D3DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 04:03:16 +1000 (EST)
Message-Id: <77D91812-7338-462D-8361-A9A55869D515@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Remi Machet <rmachet@slac.stanford.edu>
In-Reply-To: <1222709165.8628.4.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: New dma-noncoherent code, looking for comment and people to test
Date: Mon, 29 Sep 2008 13:03:11 -0500
References: <1222709165.8628.4.camel@pcds-ts102.slac.stanford.edu>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 29, 2008, at 12:26 PM, Remi Machet wrote:

> Hi,
>
> I rewrote dma-noncoherent.c and I am looking for people to review  
> and test it
> on various platforms that use it to make sure I did not introduce  
> any bug.
> The platforms affected by this change are those that define
> CONFIG_NOT_COHERENT_CACHE:
> ppc44x
> walnut
> makalu
> kilauea
> ep405
> adder875
> ep88xc
> taishan
> warp
> sam440ep
> sequoia
> bamboo
> canyonlands
> rainier
> katmai
> ebony
> mpc885_ads
> mpc866_ads
> ppc40x
> c2k (already tested)
> prpmc2800
>
> The old code in dma-noncoherent.c uses a memory pool at a hard coded
> virtual address set by CONFIG_CONSISTENT_START (typically  
> 0xFF100000). If not
> set carefully this address can conflict with early ioremap in systems
> that enable HIGHMEM, on top of that the code is overly complex  
> because it
> needs to have its own memory manager.
> This is why I tried to re-implement the code using standard memory
> management APIs. The new code does not require the user to set
> CONFIG_CONSISTENT_START or CONFIG_CONSISTENT_SIZE, is much smaller and
> simplier. It also can allocate as much memory as available in ZONE_DMA
> (instead of being limited by CONFIG_CONSISTENT_SIZE).
>
> I also removed the HIGHMEM support in dma_sync since memory  
> allocated for
> DMA transfer should always be in ZONE_DMA (ie not in ZONE_HIGHMEM).
>
> Looking forward to any comment about why this code may not work or  
> is not
> as good as the original. If you do test this code on your platform,  
> let me
> know how it goes ... if no-one object and no bug is found I will  
> submit
> this patch in a month or so.
>
> Thanks !
>
> Remi

We really should change this code over to the new dma changes Becky's  
introduced so we just have a non-coherent set of DMA ops (thus we can  
do both non-coherent and coherent in the same system).

- k
