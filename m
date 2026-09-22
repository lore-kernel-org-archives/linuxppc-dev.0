Return-Path: <linuxppc-dev+bounces-27892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2E4C982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 06:48:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hprJy2DbZz2yfy;
	Tue, 22 Sep 2026 16:48:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790059698;
	cv=none; b=R9XLIBCQ0jGO7+D0DtGx1qzMtpg3aWo7qVOu7rSFRmNS4TuSlXUjyLGzBhv8XELV3DYPVgeJLS86QQmklU4a/cmE/DAAVQqKzpEipUvfaSjG+XljfVT3ZK7wA6Zi87J45u6pOmHVONU4xik7MnVUTr++ZkFZrfC9x1rhfFCdSJh+2kCNzJcn2/bHvVU2NbXs95F1Y6zXVeWOTbT+DXCa7LLkM9t1GlWd/XEWvDpuoV739246ozktBsgmP6Vvsgp1d69fhoeUfo1PkRNQkId8tP44CMNPVgXHNu4iEcSIl4QBEuY/rDbu+zDeMqc8Eou8pkjcqW87HNNyri7hrE07LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790059698; c=relaxed/relaxed;
	bh=R3byElr0T5dtebr3WUNax1uHYhmo+4Ucoy9qEsJjVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUiw7kguyNjxnnjU/mHOU9Ei9oL/87aeWuj5+enBbCtvax+nXlqPHi14DPlz2bZDNf6LSRcB3QXvUjiDbQ/l7RvPDEkRHdlOHu4bGaAGyH4PAq3QKQ1fXWsTht4N3aRQEs0AeTFIDQ3YbkxeJy3itXwagzKUt7s9IRsgOi0hV4xB/HOVWrK+p3tgU6Ur36RVMRdYwZpbwwtpiRTvB22JsCf64s/ubaiVFrlJn3G9uX8Y45aAVwrbwM5pcMPtU3SXQDrAKXa1s73wGrF33BQV7Bn0A8IjuTE3jlydy/ngSCIAfMlPQoga7lT5jisphmcm5+hNO+2ohG70yruAJXV6ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=c3Xt8HA0; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=c3Xt8HA0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hprJw3CXJz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 16:48:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=R3byElr0T5dtebr3WUNax1uHYhmo+4Ucoy9qEsJjVkM=; b=c3Xt8HA0AS+mAjiIJ40Zoh/UJS
	6k1f1RyHNVYNuraWhcGdSGScS1d2KhQLCKSdKBum5o1mILolftQ2MBJiqfTc4JRaTinqy+O4+K+lD
	ggL5kY+CtHi10QfUTg7b5VlQCMFva7LLeT0TjJH1WLjhQ2yyGzSfcAnePqCeYnH0tMNrdKAIGLdZP
	UjLKBXSTEJ/GmsdBi+aPViTbm+RwjqJTbytVuOg0cM+wOiryFze1OSDQflvd+IT96DIRQqjISgZWX
	yWmmMNSHz7CNuoGhYNfsOtrQWrA/r10tw5dMgomPZZjYhytggDDuKYTsQvk16cZkyyPDDEbjMon3A
	9TqZylnw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8uHw-00000007NfL-0I3B;
	Tue, 22 Sep 2026 06:47:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CCD9300708; Tue, 22 Sep 2026 08:47:35 +0200 (CEST)
Date: Tue, 22 Sep 2026 08:47:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	jszhang@kernel.org, japo@linux.ibm.com, jpoimboe@kernel.org,
	seanjc@google.com, pmladek@suse.com, thuth@redhat.com,
	ynorov@nvidia.com, joelagnelf@nvidia.com, david@davidgow.net,
	fujita.tomonori@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
References: <20260922054959.955093-2-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922054959.955093-2-mkchauras@gmail.com>

On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> bug_addr displacement — i.e. the arch's trap label reference resolves to
> the trap instruction — by calling find_bug() with the exact virtual address
> of the trap, mirroring what the real trap handler does.
> 
> To support all architectures, each arch that implements ARCH_WARN_ASM now
> defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> at which the trap instruction is placed:
> 
>   x86       "1"     (ud2 at label 1:)
>   powerpc   "1"     (twi at label 1:)
>   riscv     "1"     (ebreak at label 1:)
>   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
>   s390      "0"     (mc at label 0:)
> 
> The label is used consistently: in ARCH_WARN_ASM itself, in the
> bug_addr back-reference inside __BUG_ENTRY / _EMIT_BUG_ENTRY, 


> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index 23ab05438269..6cca8880660e 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -62,8 +62,9 @@ extern void __WARN_trap(struct bug_entry *bug, ...);
>  #define HAVE_ARCH_BUG_FORMAT_ARGS
>  #endif
>  
> +#define ARCH_WARN_ASM_TRAP_LABEL "1"
>  #define __BUG_ENTRY(format, file, line, flags)				\
> -	"\t.long 1b - ."	"\t# bug_entry::bug_addr\n"		\
> +	"\t.long " ARCH_WARN_ASM_TRAP_LABEL "b - ." "\t# bug_entry::bug_addr\n" \
>  	__BUG_ENTRY_FORMAT(format)					\
>  	__BUG_ENTRY_VERBOSE(file, line)					\
>  	"\t.word " flags	"\t# bug_entry::flags\n"
> @@ -101,7 +102,7 @@ do {									\
>  	"99:\n"								\
>  	"\t.string \"\"\n"						\
>  	".popsection\n"							\
> -	"1:\t " ASM_UD2 "\n"						\
> +	ARCH_WARN_ASM_TRAP_LABEL ":\t " ASM_UD2 "\n"			\
>  	_BUG_FLAGS_ASM("99b", file, line, flags, size, "")
>  
>  #else

Not really a fan of that. And I can't really tell what you're doing with
it either. The kunit is in Rust and thus unreadable :-(

I would rather you fix up is_valid_bugaddr(), some architectures seem to
have an always true stub because of the callchains always being from the
break instruction.

