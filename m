Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rh5w3bPvzF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:35:32 +1000 (AEST)
Date: Wed, 23 May 2018 13:34:47 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] powerpc: Implement csum_ipv6_magic in assembly
Message-ID: <20180523183447.GV17342@gate.crashing.org>
References: <20180522065701.9DE696CCB4@po14934vm.idsi0.si.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522065701.9DE696CCB4@po14934vm.idsi0.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 22, 2018 at 08:57:01AM +0200, Christophe Leroy wrote:
> The generic csum_ipv6_magic() generates a pretty bad result

<snip>

Please try with a more recent compiler, what you used is pretty ancient.
It's not like recent compilers do great on this either, but it's not
*that* bad anymore ;-)

> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -293,3 +293,36 @@ dst_error:
>  	EX_TABLE(51b, dst_error);
>  
>  EXPORT_SYMBOL(csum_partial_copy_generic)
> +
> +/*
> + * static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> + *				      const struct in6_addr *daddr,
> + *				      __u32 len, __u8 proto, __wsum sum)
> + */
> +
> +_GLOBAL(csum_ipv6_magic)
> +	lwz	r8, 0(r3)
> +	lwz	r9, 4(r3)
> +	lwz	r10, 8(r3)
> +	lwz	r11, 12(r3)
> +	addc	r0, r5, r6
> +	adde	r0, r0, r7
> +	adde	r0, r0, r8
> +	adde	r0, r0, r9
> +	adde	r0, r0, r10
> +	adde	r0, r0, r11
> +	lwz	r8, 0(r4)
> +	lwz	r9, 4(r4)
> +	lwz	r10, 8(r4)
> +	lwz	r11, 12(r4)
> +	adde	r0, r0, r8
> +	adde	r0, r0, r9
> +	adde	r0, r0, r10
> +	adde	r0, r0, r11
> +	addze	r0, r0
> +	rotlwi	r3, r0, 16
> +	add	r3, r0, r3
> +	not	r3, r3
> +	rlwinm	r3, r3, 16, 16, 31
> +	blr
> +EXPORT_SYMBOL(csum_ipv6_magic)

Clustering the loads and carry insns together is pretty much the worst you
can do on most 32-bit CPUs.


Segher
