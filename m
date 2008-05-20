Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BF23DDF37
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:43:12 +1000 (EST)
Message-ID: <4833542E.3040608@freescale.com>
Date: Tue, 20 May 2008 17:43:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
References: <483344C0.3020703@freescale.com>	<20080520231516.76b924a2@core>	<4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
In-Reply-To: <20080520.153947.84346222.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Scott Wood <scottwood@freescale.com>
> Date: Tue, 20 May 2008 17:35:56 -0500
> 
>> Alan Cox wrote:
>>>> It looks like we rely on -fno-strict-aliasing to prevent reordering 
>>>> ordinary memory accesses (such as to DMA descriptors) past the I/O 
>>> DMA descriptors in main memory are dependant on cache behaviour anyway
>>> and the dma_* operators should be the ones enforcing the needed behaviour.
>> What about memory obtained from dma_alloc_coherent()?  We still need a 
>> sync and a compiler barrier.  The current I/O accessors have the former, 
>> but not the latter.
> 
> The __volatile__ in the asm construct disallows movement of the
> inline asm relative to statements surrounding it.
> 
> The only reason barrier() in kernel.h needs a memory clobber is
> because of a bug in ancient versions of gcc.  In fact, I think
> that memory clobber might even be removable.

Current versions of GCC seem quite happy to move non-asm memory accesses 
around a volatile asm without a memory clobber; see the test Trent posted.

-Scott
