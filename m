Return-Path: <linuxppc-dev+bounces-16635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5411ECD99E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6Sn71kClz2yF1;
	Fri, 06 Feb 2026 07:02:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770321755;
	cv=none; b=mPBTum1Bu1UPcgj91DSKRry4GCkF5ZvkMDpU/hDQ1z3Og6ro9hY9yyk99ZFzWRGOaYpM2W4qy8mjwk4LeGEMJ+a1fpbsGiTcJz+o3Ei5Q7OMxADxtckHwSH4O01gzIPQH8Si3KZLAWUySoliimwiCN/HkumVDk/kzf3Yg2qmnwa3YQyCiZjWtJmtUbHqZcdKFNhmkHNqR/PXXIW46DJVGMMdHWN+1As0zuMXtOFf1yCFcwWlxKjbU8XSEMMOFECJKZzGE2JfPf3AOF8+hdYkpOmwZgi3+oKA9ixYqlDTf864SHIkTcHfRRZMOoTzaNaY6z82J+X0QV9neeoT4dzZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770321755; c=relaxed/relaxed;
	bh=FKbvFta9jCkl6h83PXQ8FYsveDYX4ZZbL1JmzX3m7TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqdeh+BUBZbEtyE71LlzrQ6tAQqh3L4Ac/IPAwBqqqf1ATWrFttVxvWULge81Kf9BzeDBDBSh2zUe1X49ftC7HTE/rq9FOxLNBYSlHV8nxv/nFDgLLVGbrW4YRPsKC/uC27Y4GyDsJplpzThAOhCSxje1qXe+TLtpSnWFaiqCYQfUyiojruhKcsAnteJzrvUy2jEDjEaXMFtKm87ahPuPjxUJ3nOZUqJMJFcC7ieMJ0SNOCVcyZPR1XeoWB1TYcWSkZoUdCCS4fG2YI1S0Zr3deNIclgE55+vOiwXMGpibxMLyMHPi9CDMQFJlCec2zXuvQ3OGFrRm8lIAy4OxQbhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WK/Rgv0W; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WK/Rgv0W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6Sn64RXgz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 07:02:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BBB4600AD;
	Thu,  5 Feb 2026 20:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1987AC4CEF7;
	Thu,  5 Feb 2026 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770321750;
	bh=SFGAh9JJzYHViSrH+N5Q4JCcy+AltvYYtmD2XxefkXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WK/Rgv0WoN69gXl/scqZ7qkgu6PdyplCxPfXa+i3e7YHDx+PkO8ZL86NwJfvjJr0E
	 HIDg+Nt874Yw4XyK+b4w2qGGhHvGVAmCAxrMtHcPzC+XjzYp3IhuGLMjElm+jNc1AX
	 aZI6l0HE+Oje1bzOFYJLXRbWL8PkHCpj2tJypG6ZpPkfZ5xlUaSP6OaNMAB3wZPYqa
	 KUkvwaCRDgiuoVFtrAQVUDAOS6XtZ/NqpeeOQ7fwqSRzUdFgyOlOczAOGMFVJTZcri
	 ZsT0SFt5I2RJLHjBe22NpcgwUXYel3f7RhICE0EyG+tOJTtyIT+ajPMw4DXlxUFC3W
	 PpmUzAX2rnMJg==
Date: Thu, 5 Feb 2026 13:02:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Jubilee Young <workingjubilee@gmail.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Link Mauve <linkmauve@linkmauve.fr>, ojeda@kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, corbet@lwn.net,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH V2 3/3] powerpc: Enable Rust for ppc64le
Message-ID: <20260205200222.GA1298159@ax162>
References: <20260204210125.613350-1-mkchauras@gmail.com>
 <20260204210125.613350-4-mkchauras@gmail.com>
 <aYSgjPD5KRcNN0j4@luna>
 <1ed12a72-06e4-461b-907e-2581e25e3e38@linux.ibm.com>
 <aYS2oWCE0ZCC3don@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72mi-V_SF+JErMJu1wZEd27HPHqhsxE8dELtd5e3ZEaA4w@mail.gmail.com>
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
In-Reply-To: <CANiq72mi-V_SF+JErMJu1wZEd27HPHqhsxE8dELtd5e3ZEaA4w@mail.gmail.com>

On Thu, Feb 05, 2026 at 08:34:27PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 5, 2026 at 6:29 PM Mukesh Kumar Chaurasiya
> <mkchauras@gmail.com> wrote:
> >
> > use rust version nightly-2026-01-28
> >
> > the latest one has some issue. I just raised a bug for the rustc
> > here[1].
> >
> > [1] https://github.com/rust-lang/rust/issues/152177
> 
> It appears to be a bug in LLVM 22 for ppc64, not present in 21.
> 
> If I understand correctly, then it may be fixed in 22.1.9 if it gets released.
> 
> Thanks Jubilee for the quick reply there!
> 
> Cc'ing Clang/LLVM build support, in case they didn't hear about it.

Thanks for the CC, I had not seen that issue. LLVM 22 is currently in
the -rc phase and I see that the fix has been merged into the
release/22.x branch as of yesterday so it should be in LLVM 21.1.0-rc3
when it get released on February 10. LLVM 21.1.8 was the last release of
the 21.x series (hard to keep up with all the numbers...) and it sounds
like this is only a regression from the LLVM 22 development cycle.

Cheers,
Nathan

