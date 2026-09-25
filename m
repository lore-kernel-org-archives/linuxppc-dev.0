Return-Path: <linuxppc-dev+bounces-28189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77087C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:07:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrjx60lYrz2yDD;
	Fri, 25 Sep 2026 18:07:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790323658;
	cv=none; b=KSijoNuab9N30yc29Jr4npkGM0fIo462WRlQDeNWL+VuRmizslVLCwHj40cmB4R3rSvW+e2c8cb+pJy4p7tXBsLTu8MzOPjbRlGsZsY8LB54zv6+DotvbYiGhIismx5OEpNcCiiVBbYRk/WZxuE2X606bgmnk5DYIY083gokSztsm+poTIgwjmeqk2MPdWsvL+amSMSPFzr5jtj3mQ+zO70gLjj0iIAz4Yrzy00O36ULbjXX3ggJqIhSzhg7A9FRRYjqv3GakOkmVqamod2CLvkFFtgNW9E15dlqnTTDLxql1qsnmt/oJKaIqnMoNh8z46zKMd1xxKephGPiprY+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790323658; c=relaxed/relaxed;
	bh=aAoTpNL9Rkr8q2fk3TnB4FxN4+dnMt8DgZILqZRPS7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohjCuaJQfu1gy8S+ctce50k2vWtlb8r7XeQxiLyXa+8H2aCHx7ZCCurYdzDSM2o7mACXT8Su7oEor9ap+SBW/MzlaHSqfPxVJ0g0uPNeiybXvqsKpBX+G7kpbeh0u0SHqqFjIBwOYy7+y57hAL9bH9M0DZdVIpAwbeBYw/P+PUsZSkRdCdFghTbxl02m1gIKWeEYVd7azsRdNMPqEauCjlCsaFJvdakalIqJljBI15OcTxP7OQ2nYBf7zZS6bhQbFOAp8J6nq8VaxRW/ICAyETi64Od2zZBVV+QSLooiZ7jZgQVMqf6pyuPHQ3Xwq+/bKFtk3yspGQ0mS86njULm6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DEvDGER6; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DEvDGER6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrjx32Symz2y2M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 18:07:33 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B6A176B;
	Fri, 25 Sep 2026 01:06:56 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A38C3F86C;
	Fri, 25 Sep 2026 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790323620; bh=bqDlux4ZKljQzEX29W5C7azTEBape0jUhDg+vIkPwoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEvDGER69TkBehaUf1yXHc3/91mWH80U9Sq8HoDSqxSYDa1beSIk9FM1cgkMAerwg
	 12kXgZdinDC2N/cJSR8OMQEWeSUxgZ7fwzymJTvxenh5IUpGfzfQb+59SwynX6yJir
	 Gn0WTY/9P0VH0qqHnfWw6FImcfLEqU66XxmwvNtw=
Date: Fri, 25 Sep 2026 09:06:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	jszhang@kernel.org, japo@linux.ibm.com, peterz@infradead.org,
	jpoimboe@kernel.org, seanjc@google.com, pmladek@suse.com,
	thuth@redhat.com, ynorov@nvidia.com, joelagnelf@nvidia.com,
	david@davidgow.net, fujita.tomonori@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYrlmVgPYMgsohb@J2N7QTR9R3.cambridge.arm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <arUYLsJJewE--wqo@J2N7QTR9R3>
 <arYR4GrzNnFko7XO@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <arYR4GrzNnFko7XO@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Fri, Sep 25, 2026 at 11:51:33AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Thu, Sep 24, 2026 at 01:31:42PM +0100, Mark Rutland wrote:
> > On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > > bug_addr displacement — i.e. the arch's trap label reference resolves to
> > > the trap instruction — by calling find_bug() with the exact virtual address
> > > of the trap, mirroring what the real trap handler does.
> > > 
> > > To support all architectures, each arch that implements ARCH_WARN_ASM now
> > > defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> > > at which the trap instruction is placed:
> > > 
> > >   x86       "1"     (ud2 at label 1:)
> > >   powerpc   "1"     (twi at label 1:)
> > >   riscv     "1"     (ebreak at label 1:)
> > >   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
> > >   s390      "0"     (mc at label 0:)
> > 
> > I'm not a fan of exposing such a low-level implementation detail out of
> > the architecture code, and I don't think we should expose this.
> > 
> > What exactly are you trying to verify here, and why? Has there been
> > some _specific_ issue on powerpc that caused you to look at this?
> > 
> > Mark.
> 
> Hey Mark,
> 
> During implementing ARCH_WARN_ASM for rust I broke the bug entry for
> powerpc so I wrote this to verify. 

IIUC you mean you encoded the bug_entry::bug_addr field incorrectly?

Did that result in the entry *always* being wrong, or *sometimes* being
wrong?

AFAICT you should be able to use existing the LKDTM 'BUG' and 'WARNING'
tests for that sort of problem, no new code needed. They don't fit into
KUnit, but you should only need to run them when changing the way you
construct a bug_entry, so that doesn't seem like the end of the world.

> I sent it out mainly for ppc but few people wanted that if it needed
> it should be done for all archs.  So separated this thing and sent it
> out as an RFC to check whether other archs want this or not.

Given the information provided so far, I don't think this is necessary.
I do not want this for arm64.

Mark.

