Return-Path: <linuxppc-dev+bounces-28112-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DCCC98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 12:47:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrDBh5GfPz2y24;
	Thu, 24 Sep 2026 22:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790254060;
	cv=none; b=Kk4yAn/Yq9ty6utuclxcsAeRJ4t06ix70wdX75cga3eUSm1f6w/OG64hKFlS8U1toD6oY95hO3vT0IBrkhLWCUz3gWwOgnulEXeQhLWLmIB5lfWbIpehpToFtU7TcsRltTQhKcQG09iw7e/Z97nIWBYjPBnHkAQAmtmSQaU5jV+DcBRUqFQKylqCnBlJ+tPljc5NRZeiBpH4BIUajUUMKXNWqgU3ELUQw1ze0GOEL7Dhk0kCtHjY3fBKhvKaXKfLtY5h7vRbAaRbF7I++5J6yUbdulRR1YRHoza5ZlvPGj4MnZcKj1p8a3R9al093UoBKs6DakSkYm8gszXrmeU6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790254060; c=relaxed/relaxed;
	bh=8FDNIGeDSkOCO0TGmymYj94wOJuOHbjrsRaMRjULTm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL8MzgRprlDEFA3NHECAWsfST4ecOzUMiFfwYRwz4DqtG5MG6ePiRkOIUkUb/LB5ti5yU2vnMZqy3K4JnPr9AZLxjbM/UCm4i5GaER0vO3BVzHBMIiHXGIBXqhSXipLUQMd60NXEaGnZZzt0b02hoc1UN5AEiAevcFNiIYh5E160GBXhztyH2LB3CTXWnFJVUFagReqaz42xjz+vnuBpMNMppnMnNfoU4utV3NFcndvWzFPCkfvDqDxJn1KFp3vF05ugDBuZZBSLP9GtyeNmLNyhQOyrNUwTekUMEQGSS1EvgaRDxYcHiUerDul0Nf6EGgNU3ux8FrAYYDb027oa9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qS3yws8A; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qS3yws8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrDBg5Zn3z2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 22:47:39 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54612152B;
	Thu, 24 Sep 2026 05:47:04 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7A03F86C;
	Thu, 24 Sep 2026 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790254027; bh=aLsBzLjrp1DcDn6DWeVaafFM2AupnjMYo0e+qs0lkyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qS3yws8ARWxyQ1+ftpRPaMpKdtTTqu44bLMcI+dQ5YtFKmjLG0C1X4YEq9s7GpDps
	 QgQoCK7B8qUrIu+1Q7wIkRxMaXhUEFpkXZltly9wUzAAbIRJPgRBC8r5ZJRrcXrM5P
	 giKPrhw3skc7Z/BVVwLCIIOEY3xT3cPCUtPBhDbQ=
Date: Thu, 24 Sep 2026 13:46:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
	sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
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
Message-ID: <arUbw_TIA0Uj7oXT@J2N7QTR9R3>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260924111557.GP1837346@noisy.programming.kicks-ass.net>

On Thu, Sep 24, 2026 at 01:15:57PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 23, 2026 at 11:58:13AM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Tue, Sep 22, 2026 at 08:47:35AM +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > > > bug_addr displacement — i.e. the arch's trap label reference resolves to
> > > > the trap instruction — by calling find_bug() with the exact virtual address
> > > > of the trap, mirroring what the real trap handler does.
> > > > 
> > > > To support all architectures, each arch that implements ARCH_WARN_ASM now
> > > > defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> > > > at which the trap instruction is placed:
> > > > 
> > > >   x86       "1"     (ud2 at label 1:)
> > > >   powerpc   "1"     (twi at label 1:)
> > > >   riscv     "1"     (ebreak at label 1:)
> > > >   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
> > > >   s390      "0"     (mc at label 0:)
> > > > 
> > > > The label is used consistently: in ARCH_WARN_ASM itself, in the
> > > > bug_addr back-reference inside __BUG_ENTRY / _EMIT_BUG_ENTRY, 

> > > Not really a fan of that. And I can't really tell what you're doing with
> > > it either. The kunit is in Rust and thus unreadable :-(
> > > 
> > > I would rather you fix up is_valid_bugaddr(), some architectures seem to
> > > have an always true stub because of the callchains always being from the
> > > break instruction.
> > 
> > Hey Peter,
> > 
> > thanks for the suggestion. I will fix up the is_valid_bugaddr for
> > powerpc. I am not very good with other archs asm but i can do it for
> > ppc32 and ppc64.
> 
> Untested thingies for arm64 and s390x.
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 914282016069..3d8a969eab5f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -987,14 +987,13 @@ void do_serror(struct pt_regs *regs, unsigned long esr)
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long addr)
>  {
> -	/*
> -	 * bug_brk_handler() only called for BRK #BUG_BRK_IMM.
> -	 * So the answer is trivial -- any spurious instances with no
> -	 * bug table entry will be rejected by report_bug() and passed
> -	 * back to the debug-monitors code and handled as a fatal
> -	 * unexpected debug exception.
> -	 */
> -	return 1;
> +	u32 insn;
> +
> +	if (aarch64_insn_read((u32 *)addr, &insn))
> +		return 0;
> +
> +	/* Match ASM_BUG_FLAGS() / BUG() instructions. */
> +	return insn == (0xd4200000 | (BUG_BRK_IMM << 5));
>  }
>  #endif

What problem is this trying to solve?

Mukesh's original patch seems to be trying to check whether we compiled
things correctly (such that the bug_table entry points at the expected
insturction), and I don't think that warrants a runtime check, but (as
per my reply to him) I don't understand why that's a thing to check in
the first place.

On arm64 we only call is_valid_bugaddr() under do_el1_brk64() ->
call_el1_break_hook() -> bug_brk_handler(). We only call
bug_brk_handler() when HW has taken a BRK exception with the BUG_BRK_IMM
immediate, and that can only be triggered by executing the right
instruction (BRK #BUG_BRK_IMM), which we ONLY use for BUG(). and WARN().

So I don't see why any change is necessary here.

If the HW has somehow taken a BRK exception from any other instruction
(which would presumably be a HW bug), there won't be a bug_table entry,
and so __report_bug() will fail to find an entry, and will return
BUG_TRAP_TYPE_NONE, same as for the !is_valid_bugaddr() case.

Mark.  

