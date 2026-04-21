Return-Path: <linuxppc-dev+bounces-19876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0697F8924D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:27:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0JSP0xGHz2ytx;
	Tue, 21 Apr 2026 20:27:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776767221;
	cv=none; b=IIq21f7ZAGOyDhIRi06eSUQivH2W3OVz8wUzsLhY9WvNF16/mFco0UFtj90OyXmt6H5JrKTVxtuKhczvrx3bp26Q0xHMG5Disj46hasWSodCLCDN99OyRghkIms5jrE5VSoqfquLczE+z8jYGqPxj8riAf4C23PHcebAZntrb4dpbgqMPauLO3ObyY9DDTZgxk6eCVanLsPt+L8NC1tG85oBtFGWmXBMx2bGzvK5UfI5yvI9sd34Ei1c6q/lM8lC7ec+6uB/qUAjlArkjDyj+01NARbtMS+jFGsn5HDyChBYurZ6IJFUObOD+ViXFBJoHyzarNNS27GOunnZM5J0og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776767221; c=relaxed/relaxed;
	bh=vzdSLKhyjiJYRJDy+lTTggxzajotGbdqdUyK+NEKw0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyoWlZRWmM984vQmEnmor+43lCvR1UZ3wEnOcPny+JVOb2zTYwrMlYnZhXQH3LpJ8nicbfloOc5PIAcjkUTSXxtaz7FSfNmVUkoSijRJr2OzezfKIaaGvzrPZ1CMhsMD6gGn1bXgLfKT1wKX8ol1reqS5qI/wnKdCooJbtsqEoslyXcnRf5/2Hlmff5MWuDRUIpufWCpxhRSI/kepovSgRFgdKP6kTInykehnBpbrvqb9n86zgHZI5uJpZAzsk7zNjU+QCxzwW76MbDxuyqTHbgr9seY+aRTVRhYen8s/IBKiOakxsyimcOlpNYsZmj89iVGd43csonTqBoRjXspPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0JSM6ccDz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 20:26:59 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id C4191F40843; Tue, 21 Apr 2026 12:26:51 +0200 (CEST)
Date: Tue, 21 Apr 2026 12:26:51 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Link Mauve <linkmauve@linkmauve.fr>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aedQ629D0x-5KuKw@luna>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
Content-Type: multipart/mixed; boundary="ngs4HrAymANbT/pl"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Jabber-ID: linkmauve@linkmauve.fr


--ngs4HrAymANbT/pl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 21, 2026 at 03:25:22PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Apr 21, 2026 at 11:38:08AM +0200, Link Mauve wrote:
> > Hi Mukesh,
> > 
> > This patch doesn’t apply on top of mainline, which tree did you base it
> > off?
> > 
> It was on mainline v7.0 tag.

Great thanks, they do apply there!

I needed three more patches for the kernel to build on PPC32, I’ve
attached them but they are absolutely not patches which could go into
the kernel (except for the second, enabling asm_experimental_arch).

What do you think we should do about them?

> On latest there is a confilict. I'll send out a rebased version.
> 
> > On Fri, Apr 17, 2026 at 08:52:50PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > When building Rust code for powerpc64le with LLVM=1 and -j1, rustc
> > > encounters an error: "multiple candidates for `rmeta` dependency `core`
> > > found", with two candidates:
> > > 1. The host's standard library from the rustup toolchain
> > > 2. The kernel's custom libcore.rmeta in the rust/ directory
> > > 
> > > This occurs because the build system uses `-L$(objtree)/rust` for host
> > > library builds (proc_macro2, quote, syn), which causes rustc to search
> > > the rust/ directory. During this search, rustc finds both the kernel's
> > > custom libcore.rmeta and gains access to the host's standard library,
> > > creating a conflict.
> > > 
> > > The solution is to separate host libraries into a dedicated rust/host/
> > > subdirectory and use `-L$(objtree)/rust/host` for host builds instead
> > > of `-L$(objtree)/rust`. This ensures that:
> > > 
> > > 1. Host library builds (proc_macro2, quote, syn) only search rust/host/
> > >    and never encounter the kernel's libcore.rmeta
> > > 2. Proc macro builds use `-L$(objtree)/rust/host` to find their
> > >    dependencies
> > > 
> > > Special handling is added for rustdoc-pin_init, which is a host build
> > > (to access the alloc crate) but depends on proc macros from the main
> > > rust/ directory. It uses explicit `--extern` paths to reference the
> > > proc macros without adding `-L$(objtree)/rust`, which would reintroduce
> > > the conflict.
> > > 
> > > The rust/host/ directory is added to clean-files to ensure it's removed
> > > during `make clean`.
> > > 
> > > Link: https://github.com/Rust-for-Linux/linux/issues/105
> > > Link: https://github.com/linuxppc/issues/issues/451
> > > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > > ---
> > >  rust/Makefile | 38 +++++++++++++++++++++-----------------
> > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/rust/Makefile b/rust/Makefile
> > > index 9801af2e1e02..e234b8a39358 100644
> > > --- a/rust/Makefile
> > > +++ b/rust/Makefile
> > > @@ -3,6 +3,9 @@
> > >  # Where to place rustdoc generated documentation
> > >  rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
> > >  
> > > +# Clean generated host directory
> > > +clean-files := host/
> > > +
> > >  obj-$(CONFIG_RUST) += core.o compiler_builtins.o ffi.o
> > >  always-$(CONFIG_RUST) += exports_core_generated.h
> > >  
> > > @@ -27,7 +30,7 @@ endif
> > >  
> > >  obj-$(CONFIG_RUST) += exports.o
> > >  
> > > -always-$(CONFIG_RUST) += libproc_macro2.rlib libquote.rlib libsyn.rlib
> > > +always-$(CONFIG_RUST) += host/libproc_macro2.rlib host/libquote.rlib host/libsyn.rlib
> > >  
> > >  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
> > >  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
> > > @@ -150,7 +153,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
> > >  	OBJTREE=$(abspath $(objtree)) \
> > >  	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=% --remap-path-scope=%, \
> > >  			$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
> > 
> > The issue is here ↑, --remap-path-prefix=% got removed and the two
> > previous lines got merged into one.
> > 
> Yeah will fix this.
> > > -		$(rustc_target_flags) -L$(objtree)/$(obj) \
> > > +		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
> > >  		-Zunstable-options --generate-link-to-definition \
> > >  		--output $(rustdoc_output) \
> > >  		--crate-name $(subst rustdoc-,,$@) \
> > […]
> > 
> > Thanks anyway for iterating on this series!  I’ve started writing a DRM
> > driver based off a previous version. :)
> > 
> That's cool. Thanks.
> 
> Regards,
> Mukesh
> > -- 
> > Link Mauve
> > 

-- 
Link Mauve

--ngs4HrAymANbT/pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=0001-XXX-Workaround-sstep.c.patch

From 79b614dd7be16a1108e1f0176a7bc235fa163a4e Mon Sep 17 00:00:00 2001
From: Link Mauve <linkmauve@linkmauve.fr>
Date: Wed, 8 Apr 2026 14:16:04 +0200
Subject: [PATCH 1/3] XXX: Workaround sstep.c

These variables are used only on CONFIG_PPC64, which causes compilation
to fail on PPC32.
---
 arch/powerpc/lib/sstep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ac3ee19531d8..dc129f0cb6a0 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1354,15 +1354,15 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_PPC64
 	unsigned int suffixopcode, prefixtype, prefix_r;
 #endif
-	unsigned int opcode, ra, rb, rc, rd, spr, u;
+	unsigned int opcode, ra, rb/*, rc*/, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
-	unsigned int word, suffix;
+	unsigned int word/*, suffix*/;
 	long ival;
 
 	word = ppc_inst_val(instr);
-	suffix = ppc_inst_suffix(instr);
+	//suffix = ppc_inst_suffix(instr);
 
 	op->type = COMPUTE;
 
@@ -1480,7 +1480,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (word >> 21) & 0x1f;
 	ra = (word >> 16) & 0x1f;
 	rb = (word >> 11) & 0x1f;
-	rc = (word >> 6) & 0x1f;
+	//rc = (word >> 6) & 0x1f;
 
 	switch (opcode) {
 #ifdef __powerpc64__
-- 
2.54.0


--ngs4HrAymANbT/pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-XXX-Enable-asm_experimental_arch-for-PowerPC-asm.patch

From d4e72fad43175bde99287b8efdece900e5b53444 Mon Sep 17 00:00:00 2001
From: Link Mauve <linkmauve@linkmauve.fr>
Date: Fri, 10 Apr 2026 13:05:24 +0200
Subject: [PATCH 2/3] XXX: Enable asm_experimental_arch for PowerPC asm!()

This is needed to compile the kernel crate, otherwise this error
happens:

error[E0658]: inline assembly is not stable yet on this architecture
  --> ../rust/kernel/sync/barrier.rs:19:14
   |
19 |     unsafe { core::arch::asm!("") };
   |              ^^^^^^^^^^^^^^^^^^^^
   |
   = note: see issue #93335 <https://github.com/rust-lang/rust/issues/93335> for more information
   = help: add `#![feature(asm_experimental_arch)]` to the crate attributes to enable
   = note: this compiler was built on 2026-03-25; consider upgrading it if it is out of date

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0658`.
---
 rust/kernel/lib.rs     | 3 +++
 scripts/Makefile.build | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d93292d47420..92ccd47dc3ee 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -47,6 +47,9 @@
 // To be determined.
 #![feature(used_with_arg)]
 //
+// Needed for PowerPC inline assembly.
+#![feature(asm_experimental_arch)]
+//
 // `feature(derive_coerce_pointee)` is expected to become stable. Before Rust
 // 1.84.0, it did not exist, so enable the predecessor features.
 #![cfg_attr(CONFIG_RUSTC_HAS_COERCE_POINTEE, feature(derive_coerce_pointee))]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3652b85be545..c7cc21994c5a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -321,7 +321,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 #
 # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 # the unstable features in use.
-rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,offset_of_nested,raw_ref_op,slice_ptr_len,strict_provenance,used_with_arg
+rust_allowed_features := asm_const,asm_goto,asm_experimental_arch,arbitrary_self_types,lint_reasons,offset_of_nested,raw_ref_op,slice_ptr_len,strict_provenance,used_with_arg
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.54.0


--ngs4HrAymANbT/pl
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename=0003-XXX-Workaround-for-__udivdi3-and-__umoddi3.patch
Content-Transfer-Encoding: 8bit

From 2c0a3ec3da6fa1f0151225c05159f7a812317d32 Mon Sep 17 00:00:00 2001
From: Link Mauve <linkmauve@linkmauve.fr>
Date: Fri, 10 Apr 2026 13:51:24 +0200
Subject: [PATCH 3/3] XXX: Workaround for __udivdi3() and __umoddi3()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The core crate currently depends on these two functions for i64/u64/
i128/u128/core::time::Duration formatting, but we shouldn’t use that in
the kernel so let’s panic if they are ever called.
---
 rust/exports.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/exports.c b/rust/exports.c
index 587f0e776aba..5f1cdf13882e 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/panic.h>
 
 #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
 
@@ -20,6 +21,14 @@
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
 
+void __udivdi3(void) {
+	panic("__udivdi3() called but shouldn’t be made available on this architecture!\n");
+}
+
+void __umoddi3(void) {
+	panic("__umoddi3() called but shouldn’t be made available on this architecture!\n");
+}
+
 // For modules using `rust/build_error.rs`.
 #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
 EXPORT_SYMBOL_RUST_GPL(rust_build_error);
-- 
2.54.0


--ngs4HrAymANbT/pl--

