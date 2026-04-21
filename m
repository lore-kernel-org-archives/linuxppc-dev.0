Return-Path: <linuxppc-dev+bounces-19902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271EBF8FA90
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 16:37:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0SgX4Wt0z30Ng;
	Wed, 22 Apr 2026 02:37:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0a:1040:9780:49:5ff:fe41:d261"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776789432;
	cv=none; b=LO7Kjb93M4yuvbVtiTTYXdBkwKMiY/hKZoZBxYKgtFvNoAJ/njHlqJvLgMS9rFgobDs5ftKkMd0xKmej7h/ZIaLEcEUashGp8slI7eIgHacnsWE/52CqjFAwWNFVIdhfuEeCEsgc3OPv5WOBlWCAdCqHhobJNoUOH2rqJK8f1r+iq3k2Hnk3Ph5dg0K95Ukso8TYz7HU9jjgis/oQfjpLsKFHepeMmeHIXrPzAUUU/jTCkf7vqLU88o2e/9KbqCjT5VhXvBGFvGbmd9ncWwml3pMOqgySsou3+0ueV7s7u89Obab+0In6qyFQvdIBbQnnXJXkFAI3hzfWex5W720ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776789432; c=relaxed/relaxed;
	bh=jlOKvTnAjY6YI/bhWrNlNnhoxocEHYkZx9WhTwXC0bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/kZdBdW6VfTAZLsYb+Z+lbQKRmrJDz2HwNETr/O05QiU8WBV7gpeF0bBTFXvcS/fWJF6GwE+onCIoUKgxX9pXzUJiPrpz0AUNPnxlu2hOyxy8+I70n5Lb5+vmaq/J2aIBfyTI4HWTeM2W7ma8X5hMlXmthz9CW3pSgcSIxxiMia9PGlV3rn+6Q84cWnu23I+SyxrzotaMe5Gw9JGAl/obXBeAdNZsUSJU74c5yoTvxJDN6tPHUB3zdCaSbOgnX/yj8e0d3atkkX+ZSxOhrz9MD5QWAB5lZm1/UxYFbge+ENS4s5ctS4oIVRhYVUF7+qYP0mxmHn5mvAcGSiwXEf/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (unknown [IPv6:2a01:e0a:1040:9780:49:5ff:fe41:d261])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0SgV4rc6z2yyy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 02:37:10 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id CAA00F40852; Tue, 21 Apr 2026 18:36:58 +0200 (CEST)
Date: Tue, 21 Apr 2026 18:36:58 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Gary Guo <gary@garyguo.net>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aeenqoV-dWWW3tZv@luna>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <DHYYH903GZVW.EU2UKXD2ET0S@garyguo.net>
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
Content-Type: multipart/mixed; boundary="J+r4kPV/yKTiBgTB"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DHYYH903GZVW.EU2UKXD2ET0S@garyguo.net>
Jabber-ID: linkmauve@linkmauve.fr


--J+r4kPV/yKTiBgTB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Tue, Apr 21, 2026 at 04:59:11PM +0100, Gary Guo wrote:
> On Tue Apr 21, 2026 at 11:26 AM BST, Link Mauve wrote:
> > From 2c0a3ec3da6fa1f0151225c05159f7a812317d32 Mon Sep 17 00:00:00 2001
> > From: Link Mauve <linkmauve@linkmauve.fr>
> > Date: Fri, 10 Apr 2026 13:51:24 +0200
> > Subject: [PATCH 3/3] XXX: Workaround for __udivdi3() and __umoddi3()
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > The core crate currently depends on these two functions for i64/u64/
> > i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> > the kernel so let’s panic if they are ever called.
> > ---
> >  rust/exports.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/rust/exports.c b/rust/exports.c
> > index 587f0e776aba..5f1cdf13882e 100644
> > --- a/rust/exports.c
> > +++ b/rust/exports.c
> > @@ -12,6 +12,7 @@
> >   */
> >  
> >  #include <linux/export.h>
> > +#include <linux/panic.h>
> >  
> >  #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
> >  
> > @@ -20,6 +21,14 @@
> >  #include "exports_bindings_generated.h"
> >  #include "exports_kernel_generated.h"
> >  
> > +void __udivdi3(void) {
> > +	panic("__udivdi3() called but shouldn’t be made available on this architecture!\n");
> > +}
> > +
> > +void __umoddi3(void) {
> > +	panic("__umoddi3() called but shouldn’t be made available on this architecture!\n");
> > +}
> > +
> 
> This should be added to compiler_builtins.rs and gated for PPC32.

Thanks for the suggestion, this already seems like a much better
location for that!

This works fine for the core crate, but now panic_qr also gets the same
issue, here it is with V=1:
```
+ powerpc-linux-musl-ld -EB -m elf32ppc -z noexecstack --no-warn-rwx-segments -Bstatic --build-id=sha1 --orphan-handling=warn --script=./arch/powerpc/kernel/vmlinux.lds --strip-debug -o .tmp_vmlinux1 --whole-archive vmlinux.a .vmlinux.export.o init/version-timestamp.o --no-whole-archive --start-group --end-group .tmp_vmlinux0.kallsyms.o
powerpc-linux-musl-ld: drivers/gpu/drm/drm_panic_qr.o: in function `<drm_panic_qr::SegmentIterator as core::iter::traits::iterator::Iterator>::next':
drm_panic_qr.f39a15fa3c72e9fe-cgu.0:(.text+0x200c): undefined reference to `__udivdi3'
```

From a cursory look at the SegmentIterator::next() function I don’t
understand where the division could come up, but it’s actually nice to
get an error when operations which shouldn’t happen happen anyway, it
makes it more likely to get them fixed.

> 
> Best,
> Gary
> 
> >  // For modules using `rust/build_error.rs`.
> >  #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
> >  EXPORT_SYMBOL_RUST_GPL(rust_build_error);
> 

-- 
Link Mauve

--J+r4kPV/yKTiBgTB
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename=0001-rust-Make-__udivdi3-and-__umoddi3-panic.patch
Content-Transfer-Encoding: 8bit

From c938984c5974ba636699ce0e2cfabeb45a8d861d Mon Sep 17 00:00:00 2001
From: Link Mauve <linkmauve@linkmauve.fr>
Date: Fri, 10 Apr 2026 13:51:24 +0200
Subject: [PATCH] rust: Make __udivdi3() and __umoddi3() panic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The core crate currently depends on these two functions for i64/u64/
i128/u128/core::time::Duration formatting, but we shouldn’t use that in
the kernel so let’s panic if they are ever called.

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


--J+r4kPV/yKTiBgTB--

