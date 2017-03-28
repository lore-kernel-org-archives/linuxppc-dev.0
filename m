Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsXGR2lySzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:44:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] powerpc: string: implement optimized memset variants
In-Reply-To: <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Tue, 28 Mar 2017 11:44:30 +1100
Message-ID: <87mvc6b575.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
> index 85fa9869aec5..ec531de99996 100644
> --- a/arch/powerpc/lib/mem_64.S
> +++ b/arch/powerpc/lib/mem_64.S
> @@ -13,6 +13,23 @@
>  #include <asm/ppc_asm.h>
>  #include <asm/export.h>
>  
> +_GLOBAL(__memset16)
> +	rlwimi	r4,r4,16,0,15
> +	/* fall through */
> +
> +_GLOBAL(__memset32)
> +	rldimi	r4,r4,32,0
> +	/* fall through */
> +
> +_GLOBAL(__memset64)
> +	neg	r0,r3
> +	andi.	r0,r0,7
> +	cmplw	cr1,r5,r0
> +	b	.Lms
> +EXPORT_SYMBOL(__memset16)
> +EXPORT_SYMBOL(__memset32)
> +EXPORT_SYMBOL(__memset64)

You'll have to convince me that's better than what GCC produces.

cheers
