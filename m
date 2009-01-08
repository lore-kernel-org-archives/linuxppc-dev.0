Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D222DDFB5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 11:25:24 +1100 (EST)
Subject: Re: __pa giving strange phys address on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "dibacco@libero.it" <dibacco@libero.it>
In-Reply-To: <KD4DIL$CAE78B389ABC17D576E1A2B47EE54AEE@libero.it>
References: <KD4DIL$CAE78B389ABC17D576E1A2B47EE54AEE@libero.it>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 11:25:08 +1100
Message-Id: <1231374308.2142.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 22:11 +0100, dibacco@libero.it wrote:
> I used __pa on the result of an uncached_mem_alloc. 

No idea what uncached_mem_alloc() is but if that uses the consistent
memory stuff it won't work with __pa.

> Furthermore __pa should work on the return of a kmalloc?

Yes. But don't use that, just use the dma allocation/mapping functions
instead, they return to you both the pa and the dma_addr_t. This is
better for -many- reasons.

Cheers,
Ben.
