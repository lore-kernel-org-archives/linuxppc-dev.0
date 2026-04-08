Return-Path: <linuxppc-dev+bounces-19495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5AB1073CA0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 11:53:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frM0h1Tlmz2yC9;
	Wed, 08 Apr 2026 21:53:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649236;
	cv=none; b=CsbV6AA2hAXzte9SL6CDuVqgTiALZ13og59jLJZ9GV/w/pMeh+oFYpe8CzexAbjCJdnXhcOPU3hsWyBOIDwK53F9ECpO2na4pjq7WHIhcsrC00t5AzJJguEC8/QIKGjRPkOkh+2X8XxpdjLBiQryRn8Ek9VRuAuZqfzGhRS1Sm5OhN5xrAFmPTZTayhWIjX7H40VoBXn/JyILSGQOxWikyuYIUUV9I281B5oWlcJ+igChQMO4PWtHCUNqlNkFYgAeFLYFUMe8mg9Es3QgIWC89FN5BqnLQm5Yhm6L8LkJrf4Whrxap4QGVXIvBDx+IsCqg4nqcapRPdHHRUoHum3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649236; c=relaxed/relaxed;
	bh=Eoc0I6ZFUNdwIm009oH3G2THpKBnhPvBaJWle5ck1ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxUtLrLYe+N+n641BhpItZwieH9UwQ3ozJ3Fk7g1wVDTEnUHWCGX8mave/Ar7KOmgcIJ8KhM5LVvATKH3iJu0JZ4Q6XZw0AdERjn4IdP9CDFEhzuaF5fVLLQRhnjQF+9FPiTHUAVDvqJb7FFZwfQbtpY0qJLPgjjSCP9yJVmaXNvvFWtUWdmnYWybHIhDom/3AmIok6nAZbOpU53u4L/CH0zQ/oKM1lz2aYbawXOyw8fDXf7D+vhgVkNyqKE93LUZO1z/m96VxqZu0uXaaTDaZXjY1uyEZ2TxgKlGmbwnxgEZfc08XieSU+hoCccxJXSVJ/R6zYgV/om+XhgIfUBKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HTsRpsKb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HTsRpsKb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frM0f649Qz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 21:53:53 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-356337f058aso3530214a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649230; x=1776254030; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eoc0I6ZFUNdwIm009oH3G2THpKBnhPvBaJWle5ck1ck=;
        b=HTsRpsKbMEWdvb0CBqa4yHNPGXOt6bEtZX6bZ0qWPyQa/WWExGoHvnQp1Z3SvbBF7v
         ixkJAkPCnlGxA6ICgdQQi1OyEuAo0dPDZQoUXNHuLRmejh2Uco+x7yLnuRod734llHBB
         vtlhdNbHgtFXgQCha8Z4dtwxsEzoydNRFm9Vb2+taMYxGAqHfWVmhFi3bztaaXYONLUz
         gKQjzP+9+3GhCEafrnDofDrlcyfdc+lsl7LDB//nEIQ06GvldH2zAH1YwuJTDaIfQ+kS
         VBpV3HIsrXHIgVSchgEYFh3Z71SXpf8tarkGDbtAzxamdjIf6vCuofFafBThGJrjpUDa
         iU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649230; x=1776254030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eoc0I6ZFUNdwIm009oH3G2THpKBnhPvBaJWle5ck1ck=;
        b=hFIN7/wKc+/FcppFMgDPMoPDrwGA4uofGlwmM1aKbHLgVmOWLqWC1HQWCyqeXOQ3KI
         imC4x99Nbhj+0vImCf5YPDoGtkiozi8+qigEzz+OOmoEkE430mmEUgI29OAP/5p00GAN
         zCa99kiaoGYpJTkoJCvH65yLALXFkgPV6Zdnm3udfZL9KPftnM5YfH2MTQCyuyBhpBUM
         II8CCXbDeKV8hHVrfIEwwPzojbOEwonRisVNBRMCjGMKk4ppXunwN9lvlYY/AV9DWv46
         dY4OVl4J/+AyRCPkd0kwnThQfnjO5Ascv/h31TMlIy5zmmsxevxPe3adrJKN3HtjbRmx
         Wt+w==
X-Forwarded-Encrypted: i=1; AJvYcCW4udCA6YP3ZEnm29IggHNFoeTB2rcu/A/FdKdwclL1s3Zt5AgFLhzJUC1ZJdSpsbO8QDWe/s/AK6OFSn8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7up+IKQhNW6pZhJ/vkqjd+f1YQDQAVEQ6dYohS75tJcc6to2i
	CebvraLm7R1no4gUi5rknowTTP3vmtaAZXalu1dCxoxlRwDXE+A0AmZP
X-Gm-Gg: AeBDietSh6EG17//0MbgWloRZPX/3R1eeu2d/gqHM2pIyaAwKSCuLhapZXrJWw6YKu0
	A6jQruz0WmZxb1v9RFf9IX1hGiYBq0M90NgS7X7zUbrrN8whGf4atMsa7tW/DbHSAwH0Y/am2RG
	gzEYs88Zxd1qOirQXdCbY95+yGTS4GGqjrXVL+A3n939kjJs+miP77YqJkLWlczQ6/Iv07wtnPC
	hXdADdnt3V+OZa4W/Ggi5zfXV+n2btbvyYb4Aqai7bznYytClsrSQFCxuChthrKHdYBzBcoCX1U
	y6383IyrdV1OtzIdfJWKBwlqcC8BMWK8CC42DhQzATtXsrDatpJfgwjBJqTNBk1x6R9EU3TbpIg
	PYKSEKDdCi/zQe9Mmj+v/55FX5O3+/vqDhKxVXnOhIKVEJS3iOvhN4LjugiZm9eK7T8uKFWB4zE
	56ynP2bPmwORRMHg0lwB6J7+wG46zSR30usVdJoT2Tm19U1jWXkAESaAhiHPQzoFVJEUE=
X-Received: by 2002:a17:90b:54cc:b0:35d:a542:2dc0 with SMTP id 98e67ed59e1d1-35de67dde76mr20971504a91.8.1775649229978;
        Wed, 08 Apr 2026 04:53:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9379f3sm25672851a91.9.2026.04.08.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:53:49 -0700 (PDT)
Date: Wed, 8 Apr 2026 17:23:39 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH V10 0/4] Rust support for powerpc [RESEND]
Message-ID: <adZBWoVVoJefiTcM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
 <adYlLLfRgSyxus3n@luna>
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
In-Reply-To: <adYlLLfRgSyxus3n@luna>

On Wed, Apr 08, 2026 at 11:51:40AM +0200, Link Mauve wrote:
> Hi,
> 
> (This email is a resent, my IP address got flagged by spamhaus again
> because I’m on a residential range, hopefully this incident is
> resolved…)
> 
> On Tue, Apr 07, 2026 at 01:31:45AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
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
> 
> I just tested your series for the Wii, so targeting powerpc (32, be),
> and got this error:
> ```
> error[E0463]: can't find crate for `pin_init_internal`
>    --> ../rust/pin-init/src/lib.rs:365:11
>     |
> 365 | pub use ::pin_init_internal::pin_data;
>     |           ^^^^^^^^^^^^^^^^^ can't find crate
> 
> error: aborting due to 1 previous error
> 
> For more information about this error, try `rustc --explain E0463`.
> ```
> 
> I didn’t get this error in a previous version of your series, would you
> want me to bisect them?
> 
> Thanks for your continuous work on it anyway!
> 

Hey Link,

Thanks for testing this.

Can you give me the command generated via make with V=1
e.g. `make LLVM=1 V=1`

Regards,
Mukesh

> > 
> > We are actively working with our LLVM team to get the target for ppc,
> > ppc64 and ppc64le in the rust compiler.
> > 
> > 
> > [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
> > [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com
> > 
> > Changelog:
> > V9 -> V10:
> > - rust/Makefile updated with review comments from Miguel
> > - Patch 1/4 updated with commit message and subject
> > V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras@gmail.com/
> > 
> > V8 -> V9:
> > - rust/Makefile updated with a directory instead of abspath
> > V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras@gmail.com/
> > 
> > V7 -> V8:
> > - rust/Makefile updated to separate host libraries from target
> > V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras@gmail.com/
> > 
> > Changelog:
> > V6 -> V7:
> > - Documentation removed as powerpc is still under development
> > - Added a fix for race condition in rust/Makefile
> > V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras@gmail.com
> > 
> > V5 -> V6:
> > - Added a missing Tested by from Venkat which got missed since V3
> > - Support is marked as Maintained instead of experimental
> > V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gmail.com
> > 
> > V4 -> V5:
> > - Removed a nested ifdef from PPC64 for Little endian toolchain
> > V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gmail.com
> > 
> > V3 -> V4:
> > - Co-developed-by header added in patch 1
> > V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gmail.com
> > 
> > V2 -> V3:
> > - Splited HAVE_RUST in 2 lines
> > - BINDGEN_TARGET_powerpc initialized before assigning the same to
> >   BINDGEN_TARGET
> > V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com
> > 
> > V1 -> V2:
> > - jump label fix for rust has been moved to a separate patch
> > - PPC32 support has been taken
> > - rust support has been marked experimental
> > - target.json dependency has been removed
> > - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
> > 
> > Link Mauve (1):
> >   rust: Add PowerPC support
> > 
> > Mukesh Kumar Chaurasiya (IBM) (3):
> >   rust: Fix "multiple candidates for rmeta dependency core" error
> >   powerpc/jump_label: adjust inline asm to be consistent
> >   powerpc: Enable Rust for ppc64le
> > 
> >  arch/powerpc/Kconfig                  |  2 +
> >  arch/powerpc/Makefile                 |  7 +++
> >  arch/powerpc/include/asm/jump_label.h | 23 ++++++----
> >  rust/Makefile                         | 66 ++++++++++++++++-----------
> >  4 files changed, 61 insertions(+), 37 deletions(-)
> > 
> > -- 
> > 2.53.0
> > 
> > 
> 
> -- 
> Link Mauve
> 

