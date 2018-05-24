Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sGVs2cR2zF1PD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:25:40 +1000 (AEST)
Date: Thu, 24 May 2018 12:24:58 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] powerpc/lib: optimise PPC32 memcmp
Message-ID: <20180524172458.GA17342@gate.crashing.org>
References: <cover.1527004752.git.christophe.leroy@c-s.fr>
 <05bd657afedaf4a0de5abab0c5db2e88fa73bdfe.1527004752.git.christophe.leroy@c-s.fr>
 <bb7ef10a-4777-7635-3e54-830dd3eeb8bb@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bb7ef10a-4777-7635-3e54-830dd3eeb8bb@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 23, 2018 at 09:47:32AM +0200, Christophe Leroy wrote:
> At the time being, memcmp() compares two chunks of memory
> byte per byte.
> 
> This patch optimises the comparison by comparing word by word.
> 
> A small benchmark performed on an 8xx comparing two chuncks
> of 512 bytes performed 100000 times gives:
> 
> Before : 5852274 TB ticks
> After:   1488638 TB ticks

> diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
> index 40a576d56ac7..542e6cecbcaf 100644
> --- a/arch/powerpc/lib/string_32.S
> +++ b/arch/powerpc/lib/string_32.S
> @@ -16,17 +16,45 @@
>  	.text
> 
>  _GLOBAL(memcmp)
> -	cmpwi	cr0, r5, 0
> -	beq-	2f
> -	mtctr	r5
> -	addi	r6,r3,-1
> -	addi	r4,r4,-1
> -1:	lbzu	r3,1(r6)
> -	lbzu	r0,1(r4)
> -	subf.	r3,r0,r3
> -	bdnzt	2,1b
> +	srawi.	r7, r5, 2		/* Divide len by 4 */
> +	mr	r6, r3
> +	beq-	3f
> +	mtctr	r7
> +	li	r7, 0
> +1:
> +#ifdef __LITTLE_ENDIAN__
> +	lwbrx	r3, r6, r7
> +	lwbrx	r0, r4, r7
> +#else
> +	lwzx	r3, r6, r7
> +	lwzx	r0, r4, r7
> +#endif

You don't test whether the pointers are word-aligned.  Does that work?
Say, when a load is crossing a page boundary, or segment boundary.


Segher
