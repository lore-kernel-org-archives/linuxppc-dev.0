Return-Path: <linuxppc-dev+bounces-19492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EB01073C98
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 11:05:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frKwT5sw0z2ynf;
	Wed, 08 Apr 2026 21:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775641905;
	cv=none; b=cKhsyAjpG72/aDVkzOS49T8txhftjdEeM76BFM9AWdWbZZ/phCh7CPK5jm0hXFFfbF/zMj0hR76Vy0HUbag+iqnIl8oceCr653/VrtjFsgR4nZYpcZJkqeiOzF5kZqbZz3lqtz7kTLpnLUFZzZdFoMHoGFIrTmZjdpzT9QACu5YmXNmDjPhHEyz7ZVe77Lib8Ga2W6pA5aJmTCi3ecW/n6Y/K+9g7/PZbBW7+3KWlq65lVQK5DthbOdDbz+h/v8a2Xu0EAbGy77z2uFFC6J9g5BhFztfxNYiTCVhdwADwZBwS6hx0sbafndC44LwplnRm1Z8sB2K6WtZ2WAF/Ee2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775641905; c=relaxed/relaxed;
	bh=Hvse3DbDwQddZc+LIMEeQsyuNm30c430JGwGVkssxZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYwn8jLQjzEnHQcjZI7phKNkfwq4MwF7vjoMPUxxMLR+UeOnhR5DxQMCxH4F/mZDssGum3/mzWkyW0VFdXlVCDo4LG4oEuyMftQ7E5om8Y8scaCTKYI0PuzbF1KUJFdNuOEgJQEMsb1ECYig0GOBZOnfL5ETsHQPSeDgDvBpcdbo0ckpdtcR+j9r4s3WqvjkogD2byNpzvYGmkAtHCVrTmGZ+BjrUq1jcKm94ZC94qpOB3KTaRlJq7edeth6sya4Z3G/P9qauv7tjMVB7Pf3mS4anTwdwQHib5F6ZnSgrbEG9evpc4/Zqknpyc/bhWlrjkWTSynwgGBY2178AbY7fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frJHj2qpSz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 19:51:45 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 9D936F406D7; Wed, 08 Apr 2026 11:51:40 +0200 (CEST)
Date: Wed, 8 Apr 2026 11:51:40 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V10 0/4] Rust support for powerpc [RESEND]
Message-ID: <adYlLLfRgSyxus3n@luna>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
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
In-Reply-To: <20260406200149.3727922-1-mkchauras@gmail.com>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

(This email is a resent, my IP address got flagged by spamhaus again
because I’m on a residential range, hopefully this incident is
resolved…)

On Tue, Apr 07, 2026 at 01:31:45AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Enable experimental rust support for ppc64le and ppc32be. The patch for
> ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> `rust: Add PowerPC support` and the discussion for that is done here[1].
> 
> This has been tested on
> - powernv9 hardware
> - pseries P11 hardware
> - pseries(9, 10) qemu
> - powernv(9, 10) qemu
> - rustdoc on x86 and powerpc64le
> - rusttest on x86 and powerpc64le

I just tested your series for the Wii, so targeting powerpc (32, be),
and got this error:
```
error[E0463]: can't find crate for `pin_init_internal`
   --> ../rust/pin-init/src/lib.rs:365:11
    |
365 | pub use ::pin_init_internal::pin_data;
    |           ^^^^^^^^^^^^^^^^^ can't find crate

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0463`.
```

I didn’t get this error in a previous version of your series, would you
want me to bisect them?

Thanks for your continuous work on it anyway!

> 
> We are actively working with our LLVM team to get the target for ppc,
> ppc64 and ppc64le in the rust compiler.
> 
> 
> [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
> [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com
> 
> Changelog:
> V9 -> V10:
> - rust/Makefile updated with review comments from Miguel
> - Patch 1/4 updated with commit message and subject
> V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras@gmail.com/
> 
> V8 -> V9:
> - rust/Makefile updated with a directory instead of abspath
> V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras@gmail.com/
> 
> V7 -> V8:
> - rust/Makefile updated to separate host libraries from target
> V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras@gmail.com/
> 
> Changelog:
> V6 -> V7:
> - Documentation removed as powerpc is still under development
> - Added a fix for race condition in rust/Makefile
> V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras@gmail.com
> 
> V5 -> V6:
> - Added a missing Tested by from Venkat which got missed since V3
> - Support is marked as Maintained instead of experimental
> V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gmail.com
> 
> V4 -> V5:
> - Removed a nested ifdef from PPC64 for Little endian toolchain
> V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gmail.com
> 
> V3 -> V4:
> - Co-developed-by header added in patch 1
> V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gmail.com
> 
> V2 -> V3:
> - Splited HAVE_RUST in 2 lines
> - BINDGEN_TARGET_powerpc initialized before assigning the same to
>   BINDGEN_TARGET
> V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com
> 
> V1 -> V2:
> - jump label fix for rust has been moved to a separate patch
> - PPC32 support has been taken
> - rust support has been marked experimental
> - target.json dependency has been removed
> - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
> 
> Link Mauve (1):
>   rust: Add PowerPC support
> 
> Mukesh Kumar Chaurasiya (IBM) (3):
>   rust: Fix "multiple candidates for rmeta dependency core" error
>   powerpc/jump_label: adjust inline asm to be consistent
>   powerpc: Enable Rust for ppc64le
> 
>  arch/powerpc/Kconfig                  |  2 +
>  arch/powerpc/Makefile                 |  7 +++
>  arch/powerpc/include/asm/jump_label.h | 23 ++++++----
>  rust/Makefile                         | 66 ++++++++++++++++-----------
>  4 files changed, 61 insertions(+), 37 deletions(-)
> 
> -- 
> 2.53.0
> 
> 

-- 
Link Mauve

