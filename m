Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83205DDFEC
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:35:05 +1000 (EST)
Message-ID: <4833524C.3040207@freescale.com>
Date: Tue, 20 May 2008 17:35:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>	<1211318219.8297.177.camel@pasglop>	<483344C0.3020703@freescale.com>
	<20080520231516.76b924a2@core>
In-Reply-To: <20080520231516.76b924a2@core>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Trent Piepho <tpiepho@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Cox wrote:
>> It looks like we rely on -fno-strict-aliasing to prevent reordering 
>> ordinary memory accesses (such as to DMA descriptors) past the I/O 
> 
> DMA descriptors in main memory are dependant on cache behaviour anyway
> and the dma_* operators should be the ones enforcing the needed behaviour.

What about memory obtained from dma_alloc_coherent()?  We still need a 
sync and a compiler barrier.  The current I/O accessors have the former, 
but not the latter.

-Scott
