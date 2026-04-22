Return-Path: <linuxppc-dev+bounces-19934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EF9F94CDC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:02:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sBl2m28z2yr6;
	Wed, 22 Apr 2026 18:02:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776844927;
	cv=none; b=muaUORXeM1i7tHyQhK5uKhdjH5KgjigsrwxkVD8eRuGMvVl2nO8gJTIijis556yOR2X3MkuRqea0iXmIM1vsogPjLKDqUgVuSHYCFCy8IG006LjdLQKS+6tOI1+pUhfTXZkx2cEHS8LTnbG1QBf6VEUvaMmek+BTgZuBY0IAXORyoqSsYHNbyCy+V2KM025B2ISqbwGY6DZKk5gUnIJqCivPIZf4Yigj6f6VB74AYMbpPAtrrOyfVnAK5JRJgorihHmKOyjn4qpcy74s+EtKDO9mqmW9I2xAfriq7JGtnVi/l9jqU189AqsxXjR9M9i4lkGJvfOyCoYcJk3HAjoF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776844927; c=relaxed/relaxed;
	bh=ZAK3HXgQ1LnjoFMsAqsdTAgReqYDDzRuh5xjWSFZi68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYlKQrfeRlVvxYyHCwgCGaKHKGkkXDQtrFYOUT9cMgIRLLGzWHwMnJiUV7nBD/Ky0qwXSyLaUcWmxvU2jLLB7Lxrjm06lBGVqSV/TZn081vrvAa91zbqFpAMZaAQj0mzKhyPDynjqZEvDLlJS9m6dom60br7B4xhS77qDFmCGVrR1UkU3nCAKjaT6EZs5IFlkp5YZDmfR3VdkAHpPBglbi+1RT5T3Digo07OUowbQ83Ft3YIqDBaBApjAvJwAb7bdbDDm667fQGmArvsoGhO612yveFxF2KjKIkA5rfJthv3WvbSdenTg2uLnfaOYbKz4a5GXuHRxfpM7h0OYEPikg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sBd1g7Vz2yql
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:02:00 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id E06ACF404CC; Wed, 22 Apr 2026 10:01:55 +0200 (CEST)
Date: Wed, 22 Apr 2026 10:01:55 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Gary Guo <gary@garyguo.net>, Link Mauve <linkmauve@linkmauve.fr>,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aeiAc8vfaR33tLr6@luna>
References: <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna>
 <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DHYYG7A745M5.VQY4GMDJNC1Y@garyguo.net>
 <aee3ivM9VkbqdQby@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72k7HXYE+1hhbT8xfL+pwhBwVqCQaN=1xXUuTnMhH0J7QQ@mail.gmail.com>
 <aeh-QhEGO7ZiwQZ7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
Content-Type: multipart/mixed; boundary="3Ye2Bg1oCXFzfOAa"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeh-QhEGO7ZiwQZ7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Jabber-ID: linkmauve@linkmauve.fr


--3Ye2Bg1oCXFzfOAa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 22, 2026 at 01:23:41PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Apr 21, 2026 at 08:16:06PM +0200, Miguel Ojeda wrote:
> > On Tue, Apr 21, 2026 at 7:47 PM Mukesh Kumar Chaurasiya
> > <mkchauras@gmail.com> wrote:
> > >
> > > There are some other build errors apart from this on 1.85. So few months
> > > back in the meeting with LLVM team we concluded that for sometime
> > > powerpc will be ahead of other archs at 1.95 till others catch up.
> > 
> > In that case you may want to modify `scripts/min-tool-version.sh` in
> > this series too.
> > 
> > I hope that helps!
> > 
> Yeah this helps, Thanks :) 
> 
> Will post out a new series soon.

Great thanks!

For your new series you might want to incorporate the attached patch,
which makes the core crate build on PowerPC.

> 
> Regards,
> Mukesh
> > Cheers,
> > Miguel

-- 
Link Mauve

--3Ye2Bg1oCXFzfOAa
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename=0001-rust-Make-__udivdi3-and-__umoddi3-panic.patch
Content-Transfer-Encoding: 8bit

From 120e1283d1e49d73df483496ffc669328511657c Mon Sep 17 00:00:00 2001
From: Link Mauve <linkmauve@linkmauve.fr>
Date: Fri, 10 Apr 2026 13:51:24 +0200
Subject: [PATCH] rust: Make __udivdi3() and __umoddi3() panic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The core crate currently depends on these two functions for i64/u64/
i128/u128/core::time::Duration formatting, but we shouldn’t use that in
the kernel so let’s panic if they are ever called.

This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
build on PPC32.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 rust/Makefile             | 4 ++++
 rust/compiler_builtins.rs | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 99537c2c55ee..568f241a21a7 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -626,6 +626,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
 		__ashrti3 \
 		__ashlti3 __lshrti3
 endif
+ifdef CONFIG_PPC32
+	redirect-intrinsics += \
+		__udivdi3 __umoddi3
+endif
 
 ifdef CONFIG_MODVERSIONS
 cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index dd16c1dc899c..fc6b54636dd5 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
     __aeabi_uldivmod,
 });
 
+#[cfg(target_arch = "powerpc")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __udivdi3,
+    __umoddi3,
+});
+
 // NOTE: if you are adding a new intrinsic here, you should also add it to
 // `redirect-intrinsics` in `rust/Makefile`.
-- 
2.54.0


--3Ye2Bg1oCXFzfOAa--

