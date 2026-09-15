Return-Path: <linuxppc-dev+bounces-27302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8184FC88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:05:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkbhb5SMJz2yFW;
	Tue, 15 Sep 2026 19:05:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789463135;
	cv=none; b=b1iCZzolK0lhzQNoEYbqGemRGl+ZR4WtIiwimw4KSF7Uus7dyYNWR7PxueN7W/Uzlue+LfQetzXwJg144aLrZhaSFVMugCU3qKQQ8OTWQKaLLtt/d6eHS4d0ZSYJOJV3jG+59Fr8j7TYdOu7+9XsOVMJHlYtT6D3SEq9cJLe4tK7RjJ3uC/5mmHLpqSyvoZmCbbxks6f+6uAQdeCwO4OnRP8JXkhb56Bs7lQHiUtHrQctZpaaVYsOlJmpXw7SSxfkFHdkZw2q0fCyuvXNbfLsJVt4XPKkWq9uoggk6Dl9nkLjgn1snwb9ufa0iK9fdd4r0/wvgX8wjC8owjeuLvb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789463135; c=relaxed/relaxed;
	bh=vSfuwonf/WIHgTGI6ifOt5SgGmeBPJ0PHGizN2q97L8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd1unDJheVSgGI/zYtDzan9ZMSZmMt4xQwjLbng5lf35x+rohB44juvwclvda7l1392An/UcAerIUy7DR9TdmQECqiPHUnDH4kOEdj5On3Z/mUaHgMWv2mqg5e5YhpdoKI4oimpni4MVhgvl7PWd21g2LSYrRMz/WyMu1JJmUKE+Y5/5+BiN/0yxjvYH3wLnaDFcse2vZgttCbjiqExkKQCYiEXnmUoYik+cqmEoM8/xwjQGZDImdP7RsiaMY4QnsUVh9ygqwP1IohJTlL01rz2TE9kWQsi0Sq6pRG2oq7GlV3LGdGg6AzPZz5G2DnR4d6/xcp74IB1h4FDKxXBNRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gHED8svw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gHED8svw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com [IPv6:2607:f8b0:4864:3b::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbhZ6YBzz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 19:05:34 +1000 (AEST)
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-85469d249c6so2932389b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463133; x=1790067933; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vSfuwonf/WIHgTGI6ifOt5SgGmeBPJ0PHGizN2q97L8=;
        b=gHED8svwFXGWI4nCeshoa4npnZLIny0NJzHA3pcG0f3KIoRyiQGPDVmucirzTAmNXU
         3twOqEJS+wupKG5A0BzKnmXVdB8ahNeCSQbxxlNNrcONNd8QhBsb3aMEI+9q0Txu/8Wg
         oMC7JI+Lkm7xH2usr7bJazKdVJ8Ch7zrBaKVltUOK6vProrvjs5dOX2eMkfPyazWqL+H
         xDLfPkuPaCvfuBUSlvBUuzBo9W4RqCnusRMaIyPZKxGrXcnwyGup4LaFnlhZVgn3d4Dh
         PSowkiQaspUTJ7FtNgFEZyDQj+0PiIl6S/GfG4YZg2qDoWEa/BXf4qM5R8zIHlZY3Xzt
         Hz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463133; x=1790067933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSfuwonf/WIHgTGI6ifOt5SgGmeBPJ0PHGizN2q97L8=;
        b=kICc4d/xXx0QprSG8jUp6y3gPIpJmbHiHUd4Aig/5eU+/DnXrEBqpLQMt2cjDO+8s9
         84x7ojidT7svm0CccBHySy8B6/kfI1epXvhjP44EV/bppMLDrJoUnr58v+YB7+SM3fmN
         K8kCerpG2VNh4wS6C3PfxEG679vR9k9tQ62ehU29YgLNR/9+pB4CzoBGRCH9Q6l424cs
         XBXuRooHqLLchfuYhP5L+qn23hxAk7gaeXQi4GvmdBTmGfUFIkYULcpnxWs70VUBba3L
         iFw/oUSdg1IpwefxuSwO90Aknlf5F2u1BHrSFr6rTDC8p9OoRveeGhJSgqTRv9OX551/
         IZlA==
X-Forwarded-Encrypted: i=1; AKwUvBwJvXMHL+8Gw58r6GskM+QIJMq9+1VQmRUThQeYg26ViyKgxg36MR/gUO5+1QvZNnuPgIMUTn1VimXPaGI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mVybk0CmcPSRdnlORtNmu+bdoZoBUPuQ+bCCqzT2/S5BQgbcbg
	+RwmTQKayCFgCeLL41djQp5JCUwxowm672w9if3emZwrFKFWSE0AY+4e
X-Gm-Gg: AYBFou2c9Haq/Ttyn6M5v2t6ilj27rLO465Wf4SZiz1EtWcnnQ5ejlBcV4OSc6y7rYi
	3oSA8E6ytWr+/yGLIt9fhnxgXbuI8QhO3zBCZ5GLIu57q/MLbZWS6KPvqUOxyvbfzVrIbeS4Vpk
	xJszbNg0XzjmCkaB89iVHvkAZVXpaEJ9bYnJUnLnOUsAPmC4yx+XIJqcyMB/3TNsO9iw0cqOM0D
	YaohuPCS7Idd6sP4sr3CtirJ9KT2ZS13gy/xAlr+DQvivpHuly7sPZgqvlsUTpzlDbwQ1XcOT75
	m1PTI/SMY0DI6JUIyQYSd214ESh1+PshxOm74cSNDRxIZSPB82Qs5VCLQpzbHPq05qp5Z9oMOM6
	VYDdOZyagV190vgKfAsyQD+TW9HO+Umvn8xUC39zUobkOQMe6A31dUkFMatnGPwc1CTemi+T6Bm
	DObSDeJ0k0sLiA0vCnftdb7UBYnfjOYmM8YtnYnlokqv+ra/G2V3Z05yxwP9M2tR1LMgT7LSjnJ
	Iek2gLu/f/+tceXXhQIXkqaBYzLke58NlCgHmxsGVV4GIZMweHu4xaWPVf3y+s=
X-Received: by 2002:a05:6a20:d090:b0:3cc:faf3:331a with SMTP id adf61e73a8af0-3db40422652mr13861188637.10.1789463132520;
        Tue, 15 Sep 2026 02:05:32 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65a8120sm6495512a12.30.2026.09.15.02.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:05:31 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	mkchauras@gmail.com,
	ynorov@nvidia.com,
	david@davidgow.net,
	joelagnelf@nvidia.com,
	fujita.tomonori@gmail.com,
	linkmauve@linkmauve.fr,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH V5 2/2] rust: kernel: Add KUnit tests for powerpc ARCH_WARN_ASM bug table emission
Date: Tue, 15 Sep 2026 14:34:53 +0530
Message-ID: <20260915090453.1227034-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915090453.1227034-1-mkchauras@gmail.com>
References: <20260915090453.1227034-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
bug_addr displacement — i.e. the '1b' label reference in _EMIT_BUG_ENTRY
resolves to the trap instruction — by calling find_bug() with the exact
virtual address of the twi instruction, mirroring what the real powerpc
trap handler does.

The trap address is captured at link time via a .dc.a 1b relocation placed
in .data by the global_asm! block. global_asm! is used instead of asm!
because LLVM eliminates asm! blocks in dead branches; global_asm! is
file-scope and always emitted. BUG_KUNIT_TRAP_ADDR is defined as a .global
symbol directly on the .dc.a word so the linker relocation lands on it —
a Rust static initialized to zero would end up in BSS where relocations are
not applied.

.dc.a emits a pointer-width word (4 bytes on ppc32, 8 bytes on ppc64),
so BUG_KUNIT_TRAP_ADDR is declared as usize on the Rust side, making the
tests correct on both ppc32 and ppc64. The global_asm! block is split into
two cfg-gated variants (CONFIG_PPC64 / !CONFIG_PPC64) to select the right
.balign since concat!() only accepts literals.

Five tests are included in the rust_kernel_bug_powerpc suite:

  bug_entry_found         - find_bug() returns non-NULL for the trap address,
                            proving the bug_addr displacement is correct
  bug_entry_is_warning    - the emitted entry has BUGFLAG_WARNING set
  bug_entry_file          - bug_get_file_line() returns the correct source
                            file (requires CONFIG_DEBUG_BUGVERBOSE)
  bug_entry_line          - the recorded line number is non-zero, confirming
                            the {line} operand was substituted correctly
                            (requires CONFIG_DEBUG_BUGVERBOSE)
  bug_entry_addr_is_in_text - kernel_text_address() confirms the trap address
                            lies in kernel text, not data or zero

The suite is named rust_kernel_bug_powerpc and the Kconfig option
CONFIG_RUST_BUG_POWERPC_KUNIT_TEST depends on PPC && GENERIC_BUG,
covering both ppc32 and ppc64.

Tested on ppc64le (ltcfujiaac-lp3, 7.3.0-rc1+): pass:5 fail:0 skip:0.
Tested on ppc32 Book3S (QEMU mac99 G4, chrp32_defconfig): pass:5 fail:0 skip:0.
Tested on ppc64le (QEMU pseries, pseries_le_defconfig): pass:5 fail:0 skip:0.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/kernel/Kconfig.test |  13 +++
 rust/kernel/bug.rs       | 209 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index e6a5c7a795f0..5a82f0812c89 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -83,4 +83,17 @@ config RUST_BITFIELD_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RUST_BUG_POWERPC_KUNIT_TEST
+	bool "KUnit tests for powerpc ARCH_WARN_ASM bug table emission" if !KUNIT_ALL_TESTS
+	depends on PPC && GENERIC_BUG
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests that verify ARCH_WARN_ASM emits a
+	  correct __bug_table entry on powerpc (both ppc32 and ppc64): the
+	  bug_addr displacement must resolve back to the trap instruction so
+	  that find_bug() can locate the entry — exactly as the real trap
+	  handler does.
+
+	  If unsure, say N.
+
 endif
diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 3566f0234ca4..cd90bd511479 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -152,3 +152,212 @@ macro_rules! warn_on {
         cond
     }};
 }
+
+// Test-only constants and file static referenced by the global_asm block below.
+//
+// global_asm! is file-scope and always emitted — LLVM cannot eliminate it,
+// unlike asm! inside a function which is subject to dead-code removal.
+//
+// BUG_KUNIT_TRAP_ADDR is declared as a .global symbol entirely inside the
+// global_asm! block so the .dc.a 1b relocation lands directly on it.
+// A Rust static initialized to zero would end up in BSS; the linker does
+// not apply relocations to BSS, so the address would stay zero at runtime.
+#[cfg(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST)]
+mod test_statics {
+    use crate::bindings::{bug_entry, BUGFLAG_WARNING, TAINT_WARN};
+
+    pub(super) const FLAGS: u32 = BUGFLAG_WARNING | (TAINT_WARN << 8);
+    pub(super) const SIZE: usize = core::mem::size_of::<bug_entry>();
+
+    // LINE and BUG_KUNIT_FILE are only referenced by the {file}/{line}
+    // operands in global_asm!, which are only present when
+    // CONFIG_DEBUG_BUGVERBOSE is set (the non-verbose _EMIT_BUG_ENTRY
+    // drops the file/line fields from the bug table entry entirely).
+    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
+    pub(super) const LINE: u32 = line!();
+
+    // Null-terminated source file name — the assembler references this symbol
+    // for the verbose file pointer in __bug_table, same as warn_flags!.
+    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
+    const _FILE: &[u8] = file!().as_bytes();
+    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
+    #[no_mangle]
+    pub(super) static BUG_KUNIT_FILE: [u8; _FILE.len() + 1] = {
+        let mut bytes = [0u8; _FILE.len() + 1];
+        let mut i = 0;
+        while i < _FILE.len() {
+            bytes[i] = _FILE[i];
+            i += 1;
+        }
+        bytes
+    };
+}
+
+// Emit ARCH_WARN_ASM at file scope and capture the trap address.
+//
+// BUG_KUNIT_TRAP_ADDR is defined as a .global symbol right on top of the
+// .dc.a 1b directive so the linker resolves the relocation directly into
+// that symbol's storage — no BSS, no zero-init problem.
+// .dc.a emits a pointer-width word (4 bytes on ppc32, 8 bytes on ppc64),
+// matching the usize declaration on the Rust side.
+#[cfg(all(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST, CONFIG_PPC64, CONFIG_DEBUG_BUGVERBOSE))]
+::core::arch::global_asm!(
+    concat!(
+        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
+        ".pushsection .data\n\t",
+        ".balign 8\n\t",
+        ".global BUG_KUNIT_TRAP_ADDR\n\t",
+        "BUG_KUNIT_TRAP_ADDR:\n\t",
+        ".dc.a 1b\n\t",
+        ".popsection\n",
+    ),
+    file  = sym test_statics::BUG_KUNIT_FILE,
+    line  = const test_statics::LINE,
+    flags = const test_statics::FLAGS,
+    size  = const test_statics::SIZE,
+);
+
+#[cfg(all(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST, CONFIG_PPC64, not(CONFIG_DEBUG_BUGVERBOSE)))]
+::core::arch::global_asm!(
+    concat!(
+        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
+        ".pushsection .data\n\t",
+        ".balign 8\n\t",
+        ".global BUG_KUNIT_TRAP_ADDR\n\t",
+        "BUG_KUNIT_TRAP_ADDR:\n\t",
+        ".dc.a 1b\n\t",
+        ".popsection\n",
+    ),
+    flags = const test_statics::FLAGS,
+    size  = const test_statics::SIZE,
+);
+
+#[cfg(all(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST, not(CONFIG_PPC64), CONFIG_DEBUG_BUGVERBOSE))]
+::core::arch::global_asm!(
+    concat!(
+        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
+        ".pushsection .data\n\t",
+        ".balign 4\n\t",
+        ".global BUG_KUNIT_TRAP_ADDR\n\t",
+        "BUG_KUNIT_TRAP_ADDR:\n\t",
+        ".dc.a 1b\n\t",
+        ".popsection\n",
+    ),
+    file  = sym test_statics::BUG_KUNIT_FILE,
+    line  = const test_statics::LINE,
+    flags = const test_statics::FLAGS,
+    size  = const test_statics::SIZE,
+);
+
+#[cfg(all(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST, not(CONFIG_PPC64), not(CONFIG_DEBUG_BUGVERBOSE)))]
+::core::arch::global_asm!(
+    concat!(
+        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
+        ".pushsection .data\n\t",
+        ".balign 4\n\t",
+        ".global BUG_KUNIT_TRAP_ADDR\n\t",
+        "BUG_KUNIT_TRAP_ADDR:\n\t",
+        ".dc.a 1b\n\t",
+        ".popsection\n",
+    ),
+    flags = const test_statics::FLAGS,
+    size  = const test_statics::SIZE,
+);
+
+#[cfg(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST)]
+#[::kernel::macros::kunit_tests(rust_kernel_bug_powerpc)]
+mod tests {
+    use crate::bindings;
+
+    fn trap_addr() -> usize {
+        // BUG_KUNIT_TRAP_ADDR is a .global symbol defined in the global_asm!
+        // block above, placed in .data at the exact .dc.a 1b relocation word.
+        // The linker resolves it to the virtual address of the twi instruction
+        // before any Rust code runs, so reading it here is always safe.
+        extern "C" {
+            // .dc.a emits a pointer-width word: 4 bytes on ppc32, 8 on ppc64.
+            // usize matches the native pointer width on both.
+            static BUG_KUNIT_TRAP_ADDR: usize;
+        }
+        // SAFETY: read-only after link time, no concurrent mutation possible.
+        unsafe { BUG_KUNIT_TRAP_ADDR }
+    }
+
+    /// The `__bug_table` entry emitted by `ARCH_WARN_ASM` must be locatable
+    /// via `find_bug()` using the trap instruction's address.  A NULL result
+    /// means the `1b` label reference in `_EMIT_BUG_ENTRY` resolved to the
+    /// wrong address and the real trap handler would not recognise the site.
+    #[test]
+    fn bug_entry_found() {
+        // Non-zero proves the .dc.a relocation was resolved by the linker.
+        assert!(trap_addr() != 0);
+
+        // SAFETY: find_bug() is always safe to call with any address; it
+        // simply walks __bug_table and returns NULL if nothing matches.
+        let entry = unsafe { bindings::find_bug(trap_addr()) };
+        // Non-NULL proves the bug_addr displacement in _EMIT_BUG_ENTRY is correct.
+        assert!(!entry.is_null());
+    }
+
+    /// The emitted entry must be flagged as a warning (not a hard BUG).
+    #[test]
+    fn bug_entry_is_warning() {
+        assert!(trap_addr() != 0);
+        let entry = unsafe { bindings::find_bug(trap_addr()) };
+        assert!(!entry.is_null());
+        // SAFETY: entry is non-null and points to a valid bug_entry.
+        let flags = unsafe { (*entry).flags } as u32;
+        assert!(flags & bindings::BUGFLAG_WARNING != 0);
+    }
+
+    /// With `CONFIG_DEBUG_BUGVERBOSE` the entry must record a non-null file
+    /// pointer pointing back into this source file.
+    #[test]
+    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
+    fn bug_entry_file() {
+        use core::ffi::CStr;
+
+        assert!(trap_addr() != 0);
+        let entry = unsafe { bindings::find_bug(trap_addr()) };
+        assert!(!entry.is_null());
+
+        let mut file_ptr: *const core::ffi::c_char = core::ptr::null();
+        let mut line: u32 = 0;
+        // SAFETY: entry is non-null and valid; file_ptr and line are local
+        // variables passed as out-parameters.
+        unsafe { bindings::bug_get_file_line(entry, &mut file_ptr, &mut line) };
+
+        assert!(!file_ptr.is_null());
+        // SAFETY: file_ptr is a null-terminated C string from BUG_KUNIT_FILE.
+        let file_str = unsafe { CStr::from_ptr(file_ptr) }.to_str().unwrap_or("");
+        assert!(file_str.contains("bug"));
+    }
+
+    /// With `CONFIG_DEBUG_BUGVERBOSE` the recorded line number must be
+    /// non-zero (a zero line would mean the asm operand was not substituted).
+    #[test]
+    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
+    fn bug_entry_line() {
+        assert!(trap_addr() != 0);
+        let entry = unsafe { bindings::find_bug(trap_addr()) };
+        assert!(!entry.is_null());
+
+        let mut file_ptr: *const core::ffi::c_char = core::ptr::null();
+        let mut line: u32 = 0;
+        // SAFETY: entry is non-null and valid.
+        unsafe { bindings::bug_get_file_line(entry, &mut file_ptr, &mut line) };
+
+        assert!(line != 0);
+    }
+
+    /// The trap address stored in `__bug_table` must lie within the kernel
+    /// text segment.  If the label reference in `_EMIT_BUG_ENTRY` resolved
+    /// to data or zero, `kernel_text_address()` would return false.
+    #[test]
+    fn bug_entry_addr_is_in_text() {
+        assert!(trap_addr() != 0);
+        // SAFETY: kernel_text_address() is always safe to call with any addr.
+        let in_text = unsafe { bindings::kernel_text_address(trap_addr()) };
+        assert!(in_text != 0);
+    }
+}
-- 
2.55.0


