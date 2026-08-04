Return-Path: <linuxppc-dev+bounces-25354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEBFC55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 10:12:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDq8j0mq2z2yMl;
	Tue, 04 Aug 2026 20:12:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785838325;
	cv=none; b=RjAPA8s3LLjuINszNIDwCUBvR8BdNeqIYfD8E+DmFxg1LjUxAC4yQyMsUYyk3i5iYE8WhzbU+xTj3pAVXvK3pRonGrEBV6xXIggw07O/XF4NfDtehicZ2GTN6zKH4H/kjDjzN0UHSifZ0/5Nn9l69317AZ0dzNHPUzJd6uXgXCbfIjUlf1fqY9cRrDhGgwdImCIg6WgAxKRLf0UxkV83hpGg9H3u8xvMES2QCd8p7lMp2LLRRE0/nAiDmaiJE+Hhet/wAYSV+Y9vW549Nj8HHnPI7DynRXaK9jHPWYzwy78FXlA2jMNIOVtaY/wVCo23ZGwgwFJn3CKTycLMNbH6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785838325; c=relaxed/relaxed;
	bh=A3Kzb2YwA8WmNiPzWRWwUNJK2LGfZqmkI4tCffDR+M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIxKNOggydYj29tGHoUg8rhq6l9qbV2/7U0PQgQh4WcdN/8T3hK5JLFkGY8Opnr7WGKhj7u50//uyxBD6KnDgRmNwia0ciWP6DaGWDU9pnFEYDDeL9KYCvPQIXQ8XZaUf8Y2g4ZvX8NyjDm4qQZWZfyz+eUzRN6Ag2p03YNNHZd9XfEXuPQqMdmpU8ETZhgsAyYtU01QBxfOMZ/iyTypbcAoyazc2AMgIPwrt8eEzjfDKvG/jasGd3gDRxskvdClFVGbocq2BlvcorxiuwBRWntbXR7ZqWOhlDYpyBxVTx+RD00knnFRq7uutcKc/Q7HapwK+14co4S1lukMLOF3nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDq8g5Qxyz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 20:12:02 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 2B6E970A02F6; Tue, 04 Aug 2026 12:11:57 +0200 (CEST)
Date: Tue, 4 Aug 2026 12:11:57 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com, gregkh@linuxfoundation.org,
	prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com,
	lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <anG67Q6Y59kDqh-c@desktop>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
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
In-Reply-To: <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

On Mon, Aug 03, 2026 at 12:27:13PM +0530, Madhavan Srinivasan wrote:
> On Wed, 08 Jul 2026 13:54:47 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Enable experimental rust support for ppc64le and ppc32be. The patch for
> > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> > merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> > `rust: Add PowerPC support` and the discussion for that is done here[1].
> > 
> > This has been tested on
> > - powernv9 hardware
> > - pseries P11 hardware
> > - pseries(9, 10) qemu
> > - powernv(9, 10) qemu
> > - rustdoc on x86 and powerpc64le
> > - rusttest on x86 and powerpc64le
> > 
> > [...]
> 
> Applied to powerpc/next.
> 
> [1/7] rust: Fix "multiple candidates for rmeta dependency core" error
>       https://git.kernel.org/powerpc/c/00cdfd072c709c608606461d7d44d4613119bfa9
> [2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
>       https://git.kernel.org/powerpc/c/be809b60cbb61aab96179f44ac3670242ae72996
> [3/7] powerpc/jump_label: adjust inline asm to be consistent
>       https://git.kernel.org/powerpc/c/13244c0a40139fe66c4c5c5655f4d732a6002957
> [4/7] rust/powerpc: Set min rustc version for powerpc
>       https://git.kernel.org/powerpc/c/e299147cdc8e19c6421a6b7863dc82a35b09d967
> [5/7] rust: Make __udivdi3() and __umoddi3() panic
>       https://git.kernel.org/powerpc/c/c93c194e4ee71a734986fd99a8b1ec9fbb7a9b8b
> [6/7] rust: Add PowerPC support
>       https://git.kernel.org/powerpc/c/73b741adb264967093ef4eb59905618a7e0d0de0
> [7/7] powerpc: Enable Rust for ppc64le
>       https://git.kernel.org/powerpc/c/bc87cbdb952e9223616b839d64bdb4723aa2ed1d
> 
> cheers
> 

I just tested those again in linux-next, with the Wii support series on
top, but now the kernel fails to build due to ARCH_WARN_ASM and
ARCH_WARN_REACHABLE not being defined on PowerPC:
```
error: no rules expected `ARCH_WARN_ASM`
   --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
    |
  1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
    |                            ^^^^^^^^^^^^^ no rules expected this token in macro call
    |
   ::: ../rust/kernel/lib.rs:279:1
    |
279 | macro_rules! concat_literals {
    | ---------------------------- when calling this macro
    |
    = note: while trying to match sequence start

error: no rules expected `ARCH_WARN_REACHABLE`
   --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable_asm.rs:1:28
    |
  1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
    |                            ^^^^^^^^^^^^^^^^^^^ no rules expected this token in macro call
    |
   ::: ../rust/kernel/lib.rs:279:1
    |
279 | macro_rules! concat_literals {
    | ---------------------------- when calling this macro
    |
    = note: while trying to match sequence start

error: aborting due to 2 previous errors
```

This is in addition to the bindings::kvfree_call_rcu() call, but that
one is already being handled in a different thread.

-- 
Link Mauve

