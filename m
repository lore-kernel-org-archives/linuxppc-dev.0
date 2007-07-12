Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA335DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 04:57:30 +1000 (EST)
Message-ID: <46967990.1090203@freescale.com>
Date: Thu, 12 Jul 2007 13:57:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 4/4] Add DMA engine driver for Freescale MPC8xxx
	processors.
References: <46B96294322F7D458F9648B60E15112C6F3E46@zch01exm26.fsl.freescale.net>
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3E46@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhang Wei-r63237 wrote:
>>It'd be much simpler to allocate the entire ring at once.  No need for
>>linked lists, DMA pools, etc.  Just a single dma_alloc_coherent.
>>
> 
> 
> I use a flexible ld ring size here. If there is no more free ring, the
> driver can add new ld to the ring.

I don't think that's worth all the complexity that it adds.  Most 
drivers make do just fine with a fixed-size ring.

>>What benefit do we get out of using extended mode?  If the 
>>driver can do
>>everything it needs to with basic, with no performance 
>>penalty, why not
>>always use basic?
>>
> 
> Why there are extended mode in silicon? :) 

I've been wondering that myself. :-)

> Since there are here, we use it.

"Because it's there" really isn't a good reason for adding complexity to 
the code.

>>It'd be nice if we didn't have to stop the DMA in order to insert new
>>descriptors.
> 
> 
> Since there is only happen at no more free ld in the ring. We need to
> break the ld-ring and add new ld to it. 

Or you could just block until a previous descriptor completes.

>>Why not just use the index into the ring as the cookie?
> 
> 
> The cookie will record all transfer by increased number. The ring index
> is less for all transfer.

I'm not sure I follow.  All you need is a way to identify a currently 
used descriptor, right?

>>>+						fsl_chan->id, stat);
>>>+	if (!stat)
>>>+		return IRQ_NONE;
>>>+	busy = stat & (FSL_DMA_SR_CB);
>>>+	stat &= ~(FSL_DMA_SR_CB | FSL_DMA_SR_CH);
>>
>>This masking must happen *before* the IRQ_NONE check.
> 
> Really? FSL_DMA_SR_CH is also a stat of event. 

Does the IRQ handler always clear the bit?  If not, then it doesn't count.

> And I need the FSL_DMA_SR_CB status.

The busy assignment can still happen before the mask...  just move the 
IRQ_NONE check down.

-Scott
