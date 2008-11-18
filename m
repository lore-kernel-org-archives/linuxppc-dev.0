Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA3A6DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 06:29:47 +1100 (EST)
Message-Id: <12AFC562-6204-4626-8559-6F1C05F08BD3@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <B9E49084-CF78-4D98-8A3F-8F1179181DE5@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Add sync_*_for_* to dma_ops
Date: Tue, 18 Nov 2008 13:29:32 -0600
References: <1226953165-19305-1-git-send-email-becky.bruce@freescale.com>
	<B9E49084-CF78-4D98-8A3F-8F1179181DE5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 18, 2008, at 10:57 AM, Segher Boessenkool wrote:

>> @@ -286,42 +306,75 @@ static inline void  
>> dma_sync_single_for_cpu(struct device *dev,
>> 		dma_addr_t dma_handle, size_t size,
>> 		enum dma_data_direction direction)
>> {
>> -	BUG_ON(direction == DMA_NONE);
>
> Did you intend to remove this here?  It would be nice to test for it
> even on platforms where the op is a nop; if there is an equivalent
> test in every implementation of the ops, remove it there instead
> (that's more source + binary code to remove, always a good thing ;-) )


You're right that we have lost this test in platforms which do not  
implement the sync ops, and if the test is useful, I can certainly  
move it.  However, it will actually result in more code on the current  
ppc kernel, as there are 3x more dma_sync_* instances than there are  
actual dma_direct_* instances (and nobody else implements  
dma_sync_* :)  Not that we're talking about a lot of code here, but it  
definitely won't make the kernel smaller since we just don't need a  
sync unless we're noncoherent which, thank <insert deity here>, is rare.

With the swiotlb case, the check needs to be in the swiotlb code  
because there are other architectures that use the swiotlb code that  
do not use a structure to get to their dma_ops like we do.  IA64, for  
example, sets up its dma_ops using config options and #defines the  
names of the various dma_ functions.  They don't go through a dma_ops  
dereference, so the (possibly redundant for us) check in the swiotlb  
code would need to remain.

So, the reason for moving it would be that we think it's still a  
useful check to have.  I'm happy to move it in that case.

Thanks,
-Becky
