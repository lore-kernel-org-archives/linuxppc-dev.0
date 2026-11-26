Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A108606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGx75se5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvRH3QFFz2yPq;
	Thu, 26 Nov 2026 22:27:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692459;
	cv=none; b=kIGZqD8nXzFleYsFdv0HWoHllL85SSEJuBtigWwpJm5dm8S4IZysobe/zmieKX6PcvvsAIimXTZpYKJBleMmL9W4XlDq3jbSlmnFvOjn4QHpiHQrHzcbz92oDHzO5j82JHdXjR99tIBY4wQQ/K8SiwJiDGJVvPpr1woVGd1pXsDW4szW4qajpyGYJ7r8kbQ/QadCSl8iyi+V4eHjZy0bcKHXWVhEDygvhBZCzq2WTXlAbOA8W2fGVup1rcb4glw18feDK0JlrZ4t6+S1QJHAXP5WckFekc/Lq331mDVyqo55D97WlP2HhihAJvjK8vXGXjFohHnl3llqiISKsNwH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692459; c=relaxed/relaxed;
	bh=0BkCbk1BZezpNWO2fSE0tmudVFsNXM8eMjdZoP6Bz5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnRcwrxkfZ34iiAalvKxlgzERSVxQSGisskJqXO2iio+t0NNHAe8vrXCFKMcKrg0RVNKaPfM00TEMykrpR9sBGjhURIgYdSowZziDmDqEGLp30RunB4E3nbA8P63GRMobXB7FsTwPPxhzgClay1t/MKAojWu/aZPMlJ1RVptDbih30GrS95XfljgDYiiYoRpYrJkyUUXSFBFkTPCLRNbyfaO//y00I45WYl739H1PZ3pj+nfJ0IAJv7M5hqTgEdiHa68S9FUksDGHYgmHGD3fCGT8ShQfSjH6DYCznxHXi16c6Ct4XYErnvi2+F96vR0neMk+8TZt9+G6kyFgcbkfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGx75se5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGx75se5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvRF49dHz2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:27:37 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so70382135e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795692449; x=1796297249; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0BkCbk1BZezpNWO2fSE0tmudVFsNXM8eMjdZoP6Bz5s=;
        b=yGx75se5Y+kDM1aLDfEvkpEbmS8QotuS1cnURBSg34eYto6ZdRbwhy69atgwFPylQM
         quOiBFYkqQ1/r7cdAeda1sKH9M9M8vPL3Wfx5GiquH0AxxEG4WSz6g4/is7vpDwoCpRb
         55k4ZKp3CcgDtreLvgEKKGQXa14q+q4qd/YIw3bHvo42U/YXEFCkLWW/GY1hfG0pBFWg
         LwUZAe4k1/I+KI7CYL4aEmv5wgeevmzBI0slptB+Kv69ZrTDchMiv7dd5cgM+i9Zjtz5
         n8OctHMdcgnyuWONbWKryP4CSwmrXwmFZxWtSdZCGFS+OEfD1mXLovCZAcwBF2Q4fVHl
         SQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795692449; x=1796297249;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BkCbk1BZezpNWO2fSE0tmudVFsNXM8eMjdZoP6Bz5s=;
        b=rYwgnkMeO/avogS51RC4k1VhnksZ0p6La/6CLRRg4EWy4doawscL13fSLMj1sXABh3
         EvciLpWoe1J7Dy/783gHWvLbJfDuHsGF0YwKpf/7+SE6y9c5ySy5MQMtwoUTCqAB6/LF
         JleU1eU+Hl4jdabPj1q3CvNfoyO1Li2CmXV/UtIIqM8s4hcP3j0B8bWfKsTr20f8yH2h
         UpShAy5HWOn1G7uLKf3sx3lbFRx84Oicdg3c11vHNvkxNAkoGY9lSO103aK77p9qt9vy
         4mY3eJW6ys/Quom+mYkPJ+S3VdQDiiqW6F6BKQWvVMfU+AZE0eHXG7NiC2Y6pxzW3H8x
         8WAQ==
X-Gm-Message-State: APuU4Z+Tmv4uHWoYxKgw1PA+x4Cjn1v+9LkabNG1dFLkQuodE+09X03A
	8WFTku0OhRiAn0D0TI03KmxjtKo2dNzfliOaIs2WcnVCyiLAtupvpqv7
X-Gm-Gg: AZFdTZeEdwdN9gWHgiX2FluznMeuJwzEU9425GhYB7wqNkiTTRM32Kg6D+I3ZnoU0Oa
	FGRGyytmU4+UHM3Sf2OFvZGMcY6KKkqHA2/6XtZa1wQh/e0/+EyXw5MBMAAbaT1wSIKJ0DrodHe
	qSZWOoJ+NpcbQHkaAFuf6NHJbO1VJmlyTabc01J8MMy4YhyAmEOrmLdxhC5fvHlSNU3dgeMN0bh
	qm9vasDALFpxiibVHeA9j1yvFUqKw2q8wQ57/L+EnMa8RcbL7i7O1YxgxUMQx4M5KhwmXfO5M60
	GzXDLsbWUGZA0qUELy2BTeuERoaLmPbGW1xUOCUyZ8l1XDpVPG+5CC/pzpCECSEC0FjprFWXStf
	SadwLx0qUpv4tAj26D69Znd5quyz4aeC7yOLcYXZGcug2wW661JEVv9eCqx4tI0QJ6torYXniQt
	srIAKmRmRchZ594oyr8YoO+5CDy2e4sfeMHr8XjQTP4qYYCU7Y8xVRVeS3N5rVa2b7DzUvUJbrM
	OZJri+8BdIy31tMMJ4zGHCOZ1sUr6zTLFSKe7JQtWvlb2xe26SsYQ+/eibl8e9O1fu04Kp/va+C
	eR42fRzMjNBnH+p0H6BN3wB9MWQmRdL6I9qsw58Wx/13fTCpjuhIROjJ0b7PrqwSTJY=
X-Received: by 2002:a05:600c:4f4c:b0:4bb:8503:69f4 with SMTP id 5b1f17b1804b1-4bb888097a2mr516443125e9.5.1795692448756;
        Thu, 26 Nov 2026 03:27:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm816437995e9.13.2026.11.26.03.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:27:28 -0800 (PST)
Date: Thu, 26 Nov 2026 11:27:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jeevitha Palanisamy
 <jeevitha@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Andreas Larsson
 <andreas@gaisler.com>, Usama Arif <usama.arif@linux.dev>, Kevin Brodsky
 <kevin.brodsky@arm.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/3] powerpc: Add support for 128-bit cmpxchg
Message-ID: <20261126112714.021a3e66@pumpkin>
In-Reply-To: <20261125174035.1412724-2-nysal@linux.ibm.com>
References: <20261125174035.1412724-1-nysal@linux.ibm.com>
	<20261125174035.1412724-2-nysal@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 23:10:22 +0530
"Nysal Jan K.A." <nysal@linux.ibm.com> wrote:

> Implement arch_cmpxchg128() and arch_cmpxchg128_local() for 64-bit
> little-endian PowerPC (POWER8 and later) using the lqarx and stqcx.
> instructions.
> 
> This enables HAVE_CMPXCHG_DOUBLE, which allows SLUB to use the lockless
> __update_freelist_fast() path and provides kmalloc_nolock() required by
> BPF task-local storage and arena allocations.
> Select HAVE_ALIGNED_STRUCT_PAGE to ensure 16-byte alignment for struct
> page as required by quadword load/store instructions.
> 
> The lqarx and stqcx. instructions require a consecutive even/odd
> register pair, with the most significant 64 bits in the even register
> and the least significant 64 bits in the odd register. Leverage GCC's
> PTI mode variable attribute to allow the compiler to allocate suitable
> register pairs. On little-endian, the halves are swapped to match the
> memory layout.
> 
> Link: https://github.com/linuxppc/issues/issues/463
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106895
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
...
> index dbb50c06f0bf..b3164c3c0b81 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -6,6 +6,7 @@
>  #include <linux/compiler.h>
>  #include <asm/synch.h>
>  #include <linux/bug.h>
> +#include <linux/types.h>
>  
>  #ifdef __BIG_ENDIAN
>  #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
> @@ -617,6 +618,65 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
>  }
>  #endif
>  
> +#ifdef CONFIG_HAVE_CMPXCHG_DOUBLE
> +union __u128_halves {
> +	u128 full __mode(PTI);
> +	struct {
> +		u64 low, high;

There seems to be a mismatch between the register order that PTI
assigns and the one that C uses.
It might be less confusing to swap low and high in the above
and only use 'full' (probably renamed) in the asm statement.

> +	};
> +};
> +
> +#define __CMPXCHG128(name, entry_mb, exit_mb)			\
> +static __always_inline u128					\
> +__cmpxchg_u128##name(volatile u128 *p, u128 old, u128 new)	\
> +{								\
> +	union __u128_halves tmp, r, o = { .full = (old) };	\

You don't need 'o' in a register pair, it might be better
to just have two u64 for the two halves.

> +								\
> +	__asm__ __volatile__ (					\
> +	entry_mb						\
> +"1:     lqarx   %[r],0,%[ptr]\n"				\
> +"       xor     %L[t],%L[r],%[ol]\n"				\
> +"       xor     %[t],%[r],%[oh]\n"				\
> +"       or.     %[t],%[t],%L[t]\n"				\
> +"       bne-    2f\n"						\
> +"       mr      %L[t],%[n]\n"					\
> +"       mr      %[t],%L[n]\n"					\
> +"       stqcx.  %[t],0,%[ptr]\n"				\
> +"       bne-    1b\n"						\
> +	exit_mb							\
> +"2:     mr      %[t],%[r]\n"					\
> +"       mr      %[r],%L[r]\n"					\
> +"       mr      %L[r],%[t]\n"					\

If you leave this exchange to the C code it will likely get
optimised away.

The same is true for the fallback code in the next patch
where you can use asm("r14") and asm("r15) for the two halves
of 'r' and then combine them with arithmetic for the return.

This would all be more readable with slightly longer variable names.

I'm sure the above and the fallback code could be made similar
enough to avoid the duplication.

David

> +	: [r] "=&r" (r.full),					\
> +	  [t] "=&r" (tmp.full), "+m" (*p)			\
> +	: [ptr] "r" (p),					\
> +	  [ol] "r" (o.low), [oh] "r" (o.high),			\
> +	  [n] "r" (new)						\
> +	: "cc", "memory");					\
> +								\
> +	return r.full;						\
> +}
...

