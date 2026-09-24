Return-Path: <linuxppc-dev+bounces-28111-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124E4C98317
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 12:32:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrCsC6zNFz2yD3;
	Thu, 24 Sep 2026 22:32:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790253151;
	cv=none; b=D4fmfkQoCYQ+dyRPPcV/crAhCPnOcIpwD6/ikv0dzKy/v6C8pjvqHjcivmc94l4/QSuTBUxWQo0hlBUQcxRQbLY9+g817qnsbAOyTdQNHhvdo4d522QGXvxZPr2Sm6ae1udazRBVpdBKYl3y7rxM3BeNQZ7v3x4LsWtjBfcYNPye5akyU3mj3OVhLCtnzhqroOg2AhvNMtWw72m1RnN7kNIkXj+kav4Q+paqAqHSFkqx3Wm9OMdJwma6t78okKjcqo8fkSPUl7toEDUkxYZSUe8cao1Pd7pTN+xNB+xRrVS+cQL0h1P2FfN/QWE61AjVvoCF1I08w6ijvwHRYC4Vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790253151; c=relaxed/relaxed;
	bh=DxfLt02tiYB/R06QhwaMsYXhy8uIIvTYHfePzbadpUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xin4i6UFiMqSmEtOL5/Nko0C8ItBzHqt6EzA50XyWrxUtMhqcjuhHlB9RQMcvO31n2QPV+TVp1hMjjFJzHyt5LYF/mZwnFkpLpgcv87BwHdwxSWI/UqKJ7LWbJSx44UVIsyEQOHfiOMB6DPVmeCtxarxYqmDSWxKQjXPf+ETzVC4v6Jg6b0amKUenWqyZ6NEQqQiJhI9/PNRu03fRqBUVuNNITKzW88JfF4qL8knFQ2Y66cJbxmVY/RFFaQ4WPTauTSGtoh3SYKzmEYfPv/UzyKhQdR3PFsvDOPGF8SDXcR3OfhVrqCMB+/wHEI7tuYFBcWahG1VC0YGW3k/OhB7yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lz309Dy3; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lz309Dy3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrCs960Ttz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 22:32:28 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A49A152B;
	Thu, 24 Sep 2026 05:31:51 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2777F3F86C;
	Thu, 24 Sep 2026 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790253115; bh=tyroa8lBoOqLwHpTeRHuGpjV833qc9sQbRMa/D+dsoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz309Dy3TlEu+7y1tHZCYfrdPqaWCgtZMoXnPf8tuQOM4LMWKCZ6sgCmYSkYsjvcs
	 tO7bMRWvAOIpOXYh7A+nfbCx25N76QAhUGvlajWZ3EFwvUyLVK0EAGgwuHLQJWAXUT
	 QV+kIw/8QJ9o4Wbe1n28zhddNcWmz6QOOLHombIo=
Date: Thu, 24 Sep 2026 13:31:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
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
Message-ID: <arUYLsJJewE--wqo@J2N7QTR9R3>
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

I'm not a fan of exposing such a low-level implementation detail out of
the architecture code, and I don't think we should expose this.

What exactly are you trying to verify here, and why? Has there been
some _specific_ issue on powerpc that caused you to look at this?

Mark.

