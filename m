Return-Path: <linuxppc-dev+bounces-28117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38A3C98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:06:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrDcf5r8cz2y24;
	Thu, 24 Sep 2026 23:06:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790255202;
	cv=none; b=SoVSG+YjZcBtG78dbiq5R+UVYIo7TY2HP5DXZDi0R4FmkobRk2G9zDL4aCqYvADWLxcbqOjZO4mCgsgE1r5snkWONYL44qnjg7qdeK/O6uk4PXosRapcLj/IO2PvEwiPZ0dHnnwKXVf8z5a0CXo0zHk+BP6sLIZJMmZW0rXorGF0g/u23ED8EF8dJ6Bxv27vMbTXPCdVg79IsttCibc3oIWRKCgUSv7OZ5r93hNPob6mEimu1gCtlLqNQfcIWNqHugAfArCXQ1fHWk5kLNgGM8l1P0xg5ZKWNgQ2WSCtWr+Cb1S7VCB2ySNBCjxGlqPgVOYJFSA/nocFC6RfynbQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790255202; c=relaxed/relaxed;
	bh=BL/NfyqxMyKYscXUUwTNSk0XfX3XG2LiigJ5+oNzdhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZE8LEcvNwa3/TrKKiuaQjNxaVM0RgQcYWREmfmSj4gXV+QFHwdTqRQA4orUqfcSqj6ZF5B5vfPOU1bJ+vMKsQ0jJmBOEG+SFdUiZ+eIPrMhdg8dCeBRc+UIUZockWv7k10mTjAkzblWro/P3TSlGWVqt3c9qOY3N0/h69xUCMN2k5IjthyUBJ/4eRfgC3aq6HHM8+u15KPYFpwuPQ+Kei9yx5cplNTK4AsmqeBZvdoNLdFPEH24coTIDR4CVPtGl6CYQnBGlBt3VkQ+MvTIe2fu4MX5XWAr2h2VMGkSFA00O9rlE7PS50v5hOfbxSBRS+GKjbHT8jf8yHK7AUqkcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L5T5MVGA; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L5T5MVGA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrDcd6XJjz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 23:06:41 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72CC61756;
	Thu, 24 Sep 2026 06:06:06 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 540843F86F;
	Thu, 24 Sep 2026 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790255169; bh=EGw34BO6GoODDHqtAWjnN4dQ0qfGJO7mhTtfUZBl07g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5T5MVGA1XE7fvh0OgeMuV6WxEvg/uuyaiKVs7/Rb0XZiQu6QLiQiyVzic9dwbkKj
	 AsHQO82O3eGMXwH0QQs/G8Eagu43wXo1aY65K+KpEyokxL7WJ+W4gxNEeTmwo5/88x
	 2Z1VqPAa89aa8XVYSCxLOJX2ek0aIfWGYkdJLQV0=
Date: Thu, 24 Sep 2026 14:05:57 +0100
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
Message-ID: <arUgNdqpA5U8EjjP@J2N7QTR9R3>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
 <arUbw_TIA0Uj7oXT@J2N7QTR9R3>
 <20260924125253.GY776954@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924125253.GY776954@noisy.programming.kicks-ass.net>

On Thu, Sep 24, 2026 at 02:52:53PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2026 at 01:46:59PM +0100, Mark Rutland wrote:
> > What problem is this trying to solve?
> > 
> > Mukesh's original patch seems to be trying to check whether we compiled
> > things correctly (such that the bug_table entry points at the expected
> > insturction), and I don't think that warrants a runtime check, but (as
> > per my reply to him) I don't understand why that's a thing to check in
> > the first place.
> > 
> > On arm64 we only call is_valid_bugaddr() under do_el1_brk64() ->
> > call_el1_break_hook() -> bug_brk_handler(). We only call
> > bug_brk_handler() when HW has taken a BRK exception with the BUG_BRK_IMM
> > immediate, and that can only be triggered by executing the right
> > instruction (BRK #BUG_BRK_IMM), which we ONLY use for BUG(). and WARN().
> > 
> > So I don't see why any change is necessary here.
> > 
> > If the HW has somehow taken a BRK exception from any other instruction
> > (which would presumably be a HW bug), there won't be a bug_table entry,
> > and so __report_bug() will fail to find an entry, and will return
> > BUG_TRAP_TYPE_NONE, same as for the !is_valid_bugaddr() case.
> 
> Right, so I wasn't at all sure what he was doing, Rust is still mostly
> unreadable garbage to me.
> 
> But I figured I'd much rather see him use is_valid_bugaddr() to do
> runtime checks than whatever dodgy games he was playing with that label.
> 
> So *if* doing runtime checks is what is wanted, then is_valid_bugaddr()
> needs to actually work, because then it grows a user outside of the BRK
> handler.

Thanks; I think we're aligned. :)

Before we delve into implementation details, I'd like to understand the
problem Mukesh is trying to solve.

Mark.

