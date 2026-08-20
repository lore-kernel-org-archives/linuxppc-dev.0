Return-Path: <linuxppc-dev+bounces-26014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B2C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 06:49:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQYvv5VLFz2xGr;
	Thu, 20 Aug 2026 16:49:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787208587;
	cv=none; b=U08UpJYhzFjDgl9KOKPa4BDkqv7mE0A2l5XFobLAsaO6HDlzPHXwgUSBki9z+GxqiF8P4Gdi0ta/7jc9lbP9d0NmzQEZIre1j/yDHJgj/0i5/JEcnHj0wF0+mHE3oZxnb+LvraPC+GA1dOdo0RwLBtY1kz+Iri/nybVPyS5IpixOfFVca2m7gSDOp0IOwcYkSsXIdjn/fZftDRdX7ZN6+YiRVI3iCfhaei/O76KJZfG2zUAzKSzOsahLWOW5++qB2HjjVVIZ4ZglyC8qpVdtvgf/N1zQE8Tw3+L5hzXRtTDt94lADgnIZD7My6duSjZ6hUgqYZucnfxv2aHTyaJrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787208587; c=relaxed/relaxed;
	bh=kRc1eSHVwu1q1qbvgzDIPRU3EZV0cBSELC6VRfYKDj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrR0tsolf9zW9d2HuqoBdXNSE7KZiWskFZE5JtEE2LKd7U1vBLoDOgXVsUXahxxNbKmvwVwZITfEDAb3tSIzIm/PLWy/JLQsKLLiVbvP26v92g6LVLrLF+SuFG32X+vAikpIOzQLRK3Nh/CkqeF6cV1tzb9ngiruZ/xwuIwBLqrIbaA0OB9ZofmdBFadCg4QR3gjUx9IC/Wiu0Q9emwx+EqLJZ9OUNWzdG+zWuliToJILeV2EiRd9QZ7pbFZg/4uYTHw5IC+lR2Uvcvvb+8g7er5FKzhvVCC1AGoB4vuIFSLjIwVUVDihSJXb60DT6XIyTJ8OjJSS2dv0Cg211hKNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H9bKnITQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H9bKnITQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQYvv0G5Bz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 16:49:46 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2277989a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787208584; x=1787813384; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kRc1eSHVwu1q1qbvgzDIPRU3EZV0cBSELC6VRfYKDj0=;
        b=H9bKnITQ//6j4hEnnRjWpnSy2Siw+z6JdaQCob5t6pANQ8syaQHZevWaNdhlPYssqi
         ymt7CY7mNPy7lEugMEYikRSYYdDPrNPBM13V1mquRkCkqbjdzkkMNW9/DB5NT0Blck/9
         /yk3arXs3WtpQ34DES+0lvikcJ/B0ek5EzX7/NphDs3wYY5oPCQBdJ2FRw1KBV5Rc+kW
         7nap02N5YolejzZnfUYJaBYR7F2H6AGECIOBIkiczkuXI8xOkJ9rZrlfeQMzniRm/Pvg
         yh0LQFVFZGrScyDZCmNF8rNYgNzUCiuJ65SQN/SF2ZvnxPqEDoakF4vBcGqKk6xc6btA
         U2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787208584; x=1787813384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kRc1eSHVwu1q1qbvgzDIPRU3EZV0cBSELC6VRfYKDj0=;
        b=g81yCCTbl+Viahzcg6FgmrCGHAU6HSQO1F1M5zoMQQPOGjmXqzHXP0KkHJ/EBPcVGO
         BgAdxqySQowzjhuD80/0zk7TI0hGWqZYmY6p4APu6cIetckpXKJXy9sqxglDX17TLvJZ
         X9kL5MJfdlPPrh2u1/5nCrMvi/2mi34wrlTuYM7Vjv3n1s99bZCLYBNB9s9cvUV3osD8
         REMWTNmsBwga0gHTQKivn47Kt/CVnQD6XSlnNF817MQ2z6FcZjHAXMDGNiQDPoYtxfm+
         ujrg9tX5ykXz8+ZN7RAF3FrIZ1dBeO54ypo6o0ySEawg9NAO4+5+zUshMxJsrPvpzIBD
         yoNw==
X-Forwarded-Encrypted: i=1; AHgh+RpRhyTqmSkhvJ+x9vsj0vo+40HXFSRVV8JMUUfOnLjp7+BcSB10rvhRW1D38pBqkddX4Xe9Dc3X/1boa2k=@lists.ozlabs.org
X-Gm-Message-State: AFuF++le2N/NTgs3kY5OtWPPdYHA6IFbzlm2nkIliq7eygRlT6jO7Tqg
	f2xs+iSDNfcUPboZsWc0dZOhQ+l0B7NXAtxxYdt5ooLl0zS/bK17qFSI
X-Gm-Gg: AR+sD114ObIxy7K3xhaV4GDIj9HkoiBxqDlo8pwtHjIno9yC9aN0ZI+YG3nqhI+5t2a
	tIn33iLFQR9oonyQPJmtXbtZHQRn5ja3BG0sTK8k29CLaexj3konKgSpCcJBQ1SI5zPHckNbVR8
	MsPoEAdog5grfEl2XjLOeFWNjR13N1AkAHhcD4fKLaBeJ6DtLMgHfjUzjII85XSOyOWq2a/QKJZ
	5ZZv6ZxO7IEwbemyqjLSHF3laCtwLub4qZrmHHkzqZfKwlqRkW45MzVz94gud46Q/ZoijuvSo6F
	f4r19c4o8wS7zqFjZSNTaFiR/T7/CxXtlKtY9Towyh3ZCuTufKojiEBqM3Vg7iOYmoVQ3RFL829
	BcR79HKlSSYBTTwpemgQogHuCuGdzXGzTqqNuD3VMHBHzaJkNX5rWEebFxU3nABPQLy7SjwTAiX
	8Tydwcv54Z17dIza3pdeJ5GPTDZdgbtj9dvdyQSU6mE+I79aYILC0mI0cfoiF3oN2cxSoTDo7ex
	lkD9fdEmJ/hFjLbKoLhBQ/YxLdPu8rH
X-Received: by 2002:a17:90b:4e8f:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39580a80a58mr18755677a91.1.1787208584359;
        Wed, 19 Aug 2026 23:49:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb3069csm6696864a91.15.2026.08.19.23.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:49:43 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:19:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, thuth@redhat.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <aoahpef37-7EaTrY@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260819084825.969116-1-mkchauras@gmail.com>
 <4c5b2ab5-83f8-4ee7-bb02-3046ed01fd84@kernel.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c5b2ab5-83f8-4ee7-bb02-3046ed01fd84@kernel.org>

On Wed, Aug 19, 2026 at 01:50:43PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 19/08/2026 à 10:48, Mukesh Kumar Chaurasiya (IBM) a écrit :
> > The Rust kernel infrastructure generates inline asm for WARN() via
> > ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> > preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> > arch-specific asm template string for use in Rust's core::arch macros.
> > 
> > powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> > Rust builds to fail on powerpc.
> > 
> > Refactor _EMIT_BUG_ENTRY to accept explicit (file, line, flags) string
> > arguments rather than relying on positional asm operand references
> > (%0, %1, %2, %3). This allows the macro to be composed as a plain
> > string concatenation, which is required for ARCH_WARN_ASM where no asm
> > operand context exists.
> > 
> > Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> > the BUG_ENTRY() call site to preserve existing behaviour while enabling
> > ARCH_WARN_ASM to supply its own size operand independently.
> > 
> > Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
> > convention, indicating that no additional reachability annotation is
> > needed after a WARN on powerpc.
> > 
> > This brings powerpc into line with x86, arm64, s390, and riscv, all of
> > which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
> > 
> > Suggested-by: FUJITA Tomonori <tomo@flapping.org>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >   arch/powerpc/include/asm/bug.h | 28 ++++++++++++++++------------
> >   1 file changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> > index 0db48977c70c..8aba39e0cf26 100644
> > --- a/arch/powerpc/include/asm/bug.h
> > +++ b/arch/powerpc/include/asm/bug.h
> > @@ -32,34 +32,38 @@
> >   #endif /* verbose */
> >   #else /* !__ASSEMBLER__ */
> 
> Sorry, I still don't understand. The only place the new macro is used is a
> .S file (namely rust/kernel/generated_arch_warn_asm.rs.S), and the change
> this patch implements is inside a #if !__ASSEMBLER__.
> 
> What am I missing ?
> 
> Christophe

Hey Christophe,

The code calling ARCH_WARN_ASM is a .rs.S file that goes through the C
preprocessor as part of the Rust build machinery.

The intended mechanism is essentially

generated_arch_warn_asm.rs.S
          |
          v
         CPP
          |
          | includes <linux/bug.h>
          |
          v
ARCH_WARN_ASM(...) gets expanded
          |
          v
Rust source containing the generated assembly string

The patch therefore needs ARCH_WARN_ASM in the non-__ASSEMBLER__ section,
because that section is where the macros intended for C preprocessing
are defined.

The thing is .rs.S is not using ARCH_WARN_ASM as an assembler-time macro,
it is using the C preprocessor to expand ARCH_WARN_ASM before the
Rust/assembly processing stage.

This is my understanding of things, if i am wrong somewhere maybe
someone can clarify.

Regards,
Mukesh


[...]

