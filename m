Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tv4b766cFzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 09:04:03 +1100 (AEDT)
Message-ID: <1483567434.15843.28.camel@kernel.crashing.org>
Subject: Re: [PATCH 9/9] powerpc: A new cache shape aux vectors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>, wschmidt@us.ibm.com
Date: Thu, 05 Jan 2017 09:03:54 +1100
In-Reply-To: <87lgurkmd4.fsf@linux.vnet.ibm.com>
References: <20170104051535.9454-1-benh@kernel.crashing.org>
 <20170104051535.9454-9-benh@kernel.crashing.org>
 <87lgurkmd4.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-04 at 11:04 -0200, Tulio Magno Quites Machado Filho

> > +#define AT_L1I_CACHESIZE	40
> > +#define AT_L1I_CACHESHAPE	41
> > +#define AT_L1D_CACHESIZE	42
> > +#define AT_L1D_CACHESHAPE	43
> > +#define AT_L2_CACHESIZE		44
> > +#define AT_L2_CACHESHAPE	45
> > +#define AT_L3_CACHESIZE		46
> > +#define AT_L3_CACHESHAPE	47
> 
> These names will clash with the other ones defined by alpha and sh:
> 
> /* Shapes of the caches.  Bits 0-3 contains associativity; bits 4-7
> contains
>    log2 of line size; mask those to get cache size.  */
> #define AT_L1I_CACHESHAPE	34
> #define AT_L1D_CACHESHAPE	35
> #define AT_L2_CACHESHAPE	36
> #define AT_L3_CACHESHAPE	37

Is this a problem though ? In the kernel at least these are defined in
arch specific headers so there is no clash.

Otherwise, I can change them to *_CACHEGEOMETRY, is that ok ? Or add a
PPC_ prefix...

Cheers,
Ben.
