Return-Path: <linuxppc-dev+bounces-27169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4F9C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:59:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhj2r0xGFz2yqT;
	Sat, 12 Sep 2026 16:59:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789196388;
	cv=none; b=WGSEnLwTY8CiWmnsS8RObAN/1qV/KlL7Ah+Hvdy9YSrBPk4tcR4Ij9961Js4aK4ZT/JNmyDzeMNbPvZwVIu1uI54u7qWoKAgtVXx94CUTS1cRaRUWTrlqx/4vRibquMvY8h4C+6HbwXi0pPNkR1lXToI0MwCERsHFnCyQMBme6Ti+cJ0HxqtYF3bh58HAVAReluy6JoVe3deUKBdJyVQAhVeAmJlD3iZ5MgWkWUQXDS96zRFbwH5pEb6cPEICAtFmjWRtulDve/lqKwGn+3VJ+2syhxdIKrzGRj7Q5+T+eHBTzXWNwAX5HP0aeEjhVjUnwrQLEltNoPZ9jQPIIUEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789196388; c=relaxed/relaxed;
	bh=sQBQeHY/m2oxf/tBIxLoCVyblcJokzqcMJJjpX+vwvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4A91RKicvjhgddJ4wRyOCPFNI6rBxtxCf7pbZZbTNCUaSJTQGwDUI9MMZGblmDFDS/W+ZnrpjyHOEL1o43Yq+FaXeFJVwF8xYjyc+IATmTzgW16KeRe0sAikdl86fHyVf3i82w3vXNGIff7ASg7bIIrPl/cIBZo6+feIYLyAgX9p0xr2Qohab+b4Pc8COgjSSxWnviE5pH8ls3amtzWeVID8p+fAnpXxr70ZgMRQJjZ0T32y1ZQpBy84wZvdzN9OZLD/bF8LbY/Z/fw/ZNeO3N0MB5GbD9ZbcNs8jNYhta6mdevLTa7crcaI2X6PSYDw9CJzFwLnjqb6Sr+ZOIxmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LI8vz4Z6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LI8vz4Z6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhj2q18Fhz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 16:59:46 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso1412818a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 23:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789196385; x=1789801185; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQBQeHY/m2oxf/tBIxLoCVyblcJokzqcMJJjpX+vwvU=;
        b=LI8vz4Z6OJsOfZawCniixw/28Edo8mPMBhFaF67m72fFAoGTwVh1RmNQjLclgohKBh
         3qNhCzaY6DHycq364J5Zqc6SpZMgLWopwKOOIAHVVXV3HUoBM6kLP4hDwtMVp8ksFQ+9
         ZAbQURlAXhyvoKjCjCr6Q3kJ+gceYYyi218vptq3gUUNHTSQB1eOF5Qw8XspKtK2ALH6
         ocXAGaHA6xna/4T+cdXLMgdGoT20VlAVfNodB+vO/PB2Xy8AjegG+T7g3eImmLnmv7LS
         toNiSqJkzftM2roTIQPVlnE7PRwh9U7myeQxcjkpp+ibQlg+jA9RSHILSxGdsSuUybJv
         ntGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789196385; x=1789801185;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQBQeHY/m2oxf/tBIxLoCVyblcJokzqcMJJjpX+vwvU=;
        b=TDhsA13seNzVWWVKHQ3rY7y9vEt1tOgw1uewnF8tvlCroz+N0otHqv1HvESSl9ANgT
         SjDwvCXBFqPMgegH7AayWgikM9J05n1frQg6eU7RhPTL5cswm1xmCIsUOw/0vI0rwxuP
         QBofOy2TFTpM5r0Dp+5aBVGoqJyZ9cTQXbbKcWUnct5KxzuXiyK8LXtvzs3sxA6uGu15
         sy4/cDjVsp46nApJPUzHXDbCVGFbmo/3jPxdhfMYO5LZKXnQ8t0AP9S6UlXsBIDxThcG
         rnMiWK+QDvlhOgJEsG3xAwda12VXjwmEwCUL31iPxeElrzzczGY81jEqUVtywGqsVkyH
         bYIw==
X-Forwarded-Encrypted: i=1; AKwUvBzfh9ztg+kvljJIVjcv6ifm2bA6KiXRW1vxvAzajYmmtLSpRbsEbhVDkJ3QbcYMgoTjkRgh6AXpJzz6Ttk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mYkZ25brw4VcPI+UYkP0xEz/YbnhpS+yX+Qhx5YDAaqZ/JgcPB
	V50mDDVbINKlUGdR34i+6ezhdg8cJ/vOp81U0kJIdXRbKAV/q9f5UL8L
X-Gm-Gg: AYBFou2u2wHszopQCwqeLLuX3mY+dYqH/7zweF4otVWVa2tPAy0YuRSErnBsFZZDOw9
	5nGofElSBo2CuY2/yKHq4V9MV397qRG3VniCkt0TdAsNIstvKNvx8pJtKbjApEkgYdN5hgfHLmu
	7o2ra7GZqKO6ZdcNi5iWWLYLSJ1uCltlOovDqHZdVHtUTchoMLoFPLdifcuBTvk1QV6psztUJfb
	/RPnAB7NjGZ5ni/K5gwqkBfUowMHTIPoYlgR35pwwQoI2A5N6PCyWlOy2RZ5WuqNPXofTHvbr6y
	vND+IgnR8TXWVrPZDs73GEe/3MsWolcH/q9E4A3ya7KyPR2+B4byhM7hmagH4vWV8DDfbhCEUZd
	2tAGaLMNmLVjsiITIOAEa6zCfx/Uah5JM7cYAC+QbyGlMTBXMC90U0SQixIDLMzRHK4d1tomqEA
	gYxtX9DU2Uvjw+zsC2PQzRHMALfAQcdypbVbiIQuOk5TnxKJeeOuw8agcoE8YtlMUh5JVVvAJqc
	tWCFPgR+JKiPvLGCB56BIJ4gp/kvJELROjFsJU5Kv0l0w==
X-Received: by 2002:a17:90b:2689:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-39d9bbc81damr13190186a91.1.1789196384673;
        Fri, 11 Sep 2026 23:59:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm10777777c88.8.2026.09.11.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 23:59:44 -0700 (PDT)
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
	ecourtney@nvidia.com,
	joelagnelf@nvidia.com,
	fujita.tomonori@gmail.com,
	linkmauve@linkmauve.fr,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 2/2] rust: kernel: Add KUnit tests for powerpc ARCH_WARN_ASM bug table emission
Date: Sat, 12 Sep 2026 12:29:02 +0530
Message-ID: <20260912065902.24017-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912065902.24017-1-mkchauras@gmail.com>
References: <20260912065902.24017-1-mkchauras@gmail.com>
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

Tested on ppc64le pSeries: pass:5 fail:0 skip:0.
Tested on ppc32 QEMU mac99 G4: pass:5 fail:0 skip:0.
Tested on ppc64le QEMU pseries: pass:5 fail:0 skip:0.

Assisted-by: LLM
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/kernel/Kconfig.test |  13 +++
 rust/kernel/bug.rs       | 171 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)

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
index 3566f0234ca4..da43e62ddcdd 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -152,3 +152,174 @@ macro_rules! warn_on {
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
+    pub(super) const LINE: u32 = line!();
+
+    // Null-terminated source file name — the assembler references this symbol
+    // for the verbose file pointer in __bug_table, same as warn_flags!.
+    const _FILE: &[u8] = file!().as_bytes();
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
+#[cfg(all(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST, CONFIG_PPC64))]
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
+#[cfg(all(CONFIG_RUST_BUG_POWERPC_KUNIT_TEST, not(CONFIG_PPC64)))]
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


