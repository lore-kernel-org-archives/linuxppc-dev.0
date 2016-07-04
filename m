Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjbsQ0FmCzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 15:58:01 +1000 (AEST)
Date: Mon, 4 Jul 2016 00:57:44 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: powerpc: Add POWER8 optimised crc32c
Message-ID: <20160704055744.GA31609@gate.crashing.org>
References: <1467325185-21091-1-git-send-email-anton@ozlabs.org>
 <1467325185-21091-2-git-send-email-anton@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467325185-21091-2-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Fri, Jul 01, 2016 at 08:19:45AM +1000, Anton Blanchard wrote:
> +#ifdef BYTESWAP_DATA
> +	addis	r3,r2,.byteswap_constant@toc@ha
> +	addi	r3,r3,.byteswap_constant@toc@l
> +
> +	lvx	byteswap,0,r3
> +	addi	r3,r3,16
> +#endif

You already have r0=0, so you can just do

	lvsr byteswap,0,r0
	vnot byteswap,byteswap

(the top bits of the permute vector bytes aren't used after all).

Or if you find that distasteful,

	lvsl byteswap,0,r0
	vspltisb v0,15
	vxor byteswap,byteswap,v0

Btw, the value in r3 isn't used after this, that last addi is useless?

> +	/*
> +	 * The reflected version of Barrett reduction. Instead of bit
> +	 * reflecting our data (which is expensive to do), we bit reflect our
> +	 * constants and our algorithm, which means the intermediate data in
> +	 * our vector registers goes from 0-63 instead of 63-0. We can reflect
> +	 * the algorithm because we don't carry in mod 2 arithmetic.
> +	 */

Expensive?  Ha!

	vgbbd v0,v0
	vperm v0,v0,v0,byteswap
	vgbbd v0,v0
	vperm v0,v0,v0,byteswap
	vsldoi v0,v0,v0,8

(or fold these last two together, needs another constant though).

> +	lvx	v0,0,r4
> +	lvx	v16,0,r3
> +	VPERM(v0,v0,v16,byteswap)
> +	vxor	v0,v0,v8	/* xor in initial value */
> +	VPMSUMW(v0,v0,v16)
> +	bdz	.Lv0

That VPERM looks strange...  You probably want v0 instead of v16.  Not
that it matters here.


Segher
