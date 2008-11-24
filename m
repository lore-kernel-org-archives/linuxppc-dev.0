Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57D6BDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 05:55:24 +1100 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.8])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	mAOItIOq011237
	for <linuxppc-embedded@ozlabs.org>; Mon, 24 Nov 2008 10:55:18 -0800
To: linuxppc-embedded@ozlabs.org
Subject: Async DMA question regarding dma_async_memcpy_buf_to_buf
MIME-Version: 1.0
Message-ID: <OFDD6E2111.A0808007-ON8825750B.0067D813-8825750B.0067EC1C@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 24 Nov 2008 10:55:16 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a question about 
.../drivers/dma/dmaengine.c/dma_async_memcpy_buf_to_buf() in 2.6.28-rc2. 
It looks like it always assumes that the source pointer points to data 
coming from the CPU and the destination pointer always points to the DMA 
device.  I say this because of the following two lines from the function:

 dma_src = dma_map_single(dev->dev, src, len, DMA_TO_DEVICE);
 dma_dest = dma_map_single(dev->dev, dest, len, DMA_FROM_DEVICE);


As you can see 'src' is mapped DMA_TO_DEVICE indicating the data is going 
from the CPU to the device, and 'dest' is mapped DMA_FROM_DEVICE, 
indicating the opposite direction.  Seems to me this means the function is 

assuming a certain direction (i.e., a write to the device), but there 
isn't a corresponding function for going the other direction.  This leads 
me to believe that the function is intended to operate in either 
direction.  But this is in contradiction to both the mapped directions and 

what I've read in LDD3, ch 15.

The hardware doesn't care (I'm using an MPC8347E), as far as the DMA 
engine is concerned these are just addresses.  All of this goes to cache 
coherency.  The map/unmap functions are supposed to ensure that data is 
copied and caches flushed at the right times to ensure cache coherency. So 

the question is this; is the dma_async_memcpy_buf_to_buf() function 
intended to be bi-directional and is it safe to pass it a 'src' pointer 
that's actually coming from the device, or does there need to be a second 
function for doing a copy from the device to the CPU?

Thanks.

Bruce
