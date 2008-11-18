Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E3D1DDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 03:59:30 +1100 (EST)
In-Reply-To: <1226953165-19305-1-git-send-email-becky.bruce@freescale.com>
References: <1226953165-19305-1-git-send-email-becky.bruce@freescale.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B9E49084-CF78-4D98-8A3F-8F1179181DE5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add sync_*_for_* to dma_ops
Date: Tue, 18 Nov 2008 17:57:15 +0100
To: Becky Bruce <becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> @@ -286,42 +306,75 @@ static inline void dma_sync_single_for_cpu 
> (struct device *dev,
>  		dma_addr_t dma_handle, size_t size,
>  		enum dma_data_direction direction)
>  {
> -	BUG_ON(direction == DMA_NONE);

Did you intend to remove this here?  It would be nice to test for it
even on platforms where the op is a nop; if there is an equivalent
test in every implementation of the ops, remove it there instead
(that's more source + binary code to remove, always a good thing ;-) )


Segher
