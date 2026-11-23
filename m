Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F077606A683
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=42b6mgLI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CrCLsvMt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6mh5R37z2xyj;
	Tue, 24 Nov 2026 00:51:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441892;
	cv=none; b=US4OFzdfvXY9m3GrpqJ/Orj7hCbkJb+Nlx2zDAfKSUKjcGKumkyHomXUpFrn4FmktAKne1Sa8eK3I6EGh5vEVxT7Uxv5JchZzSykWxzQzdYnfEdGt7T/aQ0DHLLqDFUXdqTnsbcxlr9FE50KE3QkldkbDxMZRUSOi+ZFlw/AcChej7dZNon8wt9xTmwx+FqmldKJvuCcvk2nDnvT9mXcXTdAZxNG0fSzrmiNHuLrIB6Hs3pX86IgxyvZ1g66Mz300ttRaOKEk8jDvwMxnsTqGBGGX2pTaQn1Y8l4B2MSFc5VcUppKvafrtB0gc1BWRqDHODHsmL13S4Y9HEdCcQO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441892; c=relaxed/relaxed;
	bh=5sFaXvA9vx15Nywpdl3NvvJxA2pf2Qf5PnzQHGb7eBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sb4dKdNQmdkUnZZv9ccwWlL7SXKOiBNrlge7cpWNiGT8WzRXfSBppqY0ksDCKA1V+kqVWVmHWawGZbCCCJz4uNzpxa5oiFHX+U3Htufdu6Rpc82kCWsgeCAbSXQoTexSblKCL8vxHsd44pGbc/xsWXaNG6/Hin1jID/Z/bH/WFoWNr/Tv4pacverIgnt0fffGMDIzgHRhCAgk7+0o31dHi5qCESaN8DdSDdB2WcDGZekQV+U4fwCSSYfXyIFnagijD9W7BX6VAZtkV1ZpFzSyB0NkuIAiRvrxtyvSY3QHsk3OldghUG2v1AfE30dp8Qncp1Vk+hhqS8b9Ick25a7BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=42b6mgLI; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CrCLsvMt; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=42b6mgLI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CrCLsvMt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6mf4tKqz3bRp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:51:30 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sFaXvA9vx15Nywpdl3NvvJxA2pf2Qf5PnzQHGb7eBo=;
	b=42b6mgLIuU+F+S2GlLo82F+40zks1I3ParrxfhXxOeiIN6CX7YexYDUC6GXnp4UOaHqvmi
	rueKaxZPgopp3WWrMJ9ivOuGql7vhRwqrTriYEGG6ndX0qCscYb7AEbt2PxUU0+b6nd2dt
	wfv5aG5df/oZSAe7Uer72VZhxJ2OefR6UBZSe70z5F0y/CbxpQ7V1nWZp3oBVfwRdZLO6h
	fs1K74tvJ+MturgKOmuh3EXLBvDYjX2hQCbg3oD9KCR2SWtooXWe03M3nNgv719/F8e2Pv
	8nmNDiuItrU+b5v52Jry8B/LzK2AdBpms0G7k9XW47IxNtIOQAyOXvyqIGdWMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sFaXvA9vx15Nywpdl3NvvJxA2pf2Qf5PnzQHGb7eBo=;
	b=CrCLsvMtlydLFWCXif6/L6uV62axTpYtX8NNzE0vRn7tBdCToQxzwCjnmsiMVyWxKbawQz
	71CVQ5Tri+gvE3Ag==
Date: Mon, 23 Nov 2026 14:50:58 +0100
Subject: [PATCH v6 07/11] LoongArch: vDSO: Enable the vdsocheck tool
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-vdso-absolute-reloc-v6-7-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
In-Reply-To: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=3278;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M6WFFqo+yQNRSndBT6wB+Qd/XP3diHhHIC/1+2kgJZg=;
 b=vobOCi8V2Ww5CZjhDGPnGtE/6mmXyQIGHbhp4Ye78sY6UcjVcQ9/rdZ4B/0wQ2qV2tFQT+MYE
 GvphsrL4IijByLExRMrAyOXpewMTgTunrbHm4R5e3R48BMFwZ8xmLki
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/Kconfig       |  1 +
 arch/loongarch/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs  | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b5ed4881d3c0..ad4cafeddbb8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -211,6 +211,7 @@ config LOONGARCH
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
+	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	select ZONE_DMA32 if 64BIT
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 0b84892d084b..ad54383b1908 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -51,7 +51,7 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 #
 
 quiet_cmd_vdsold_and_vdso_check = LD      $@
-      cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
+      cmd_vdsold_and_vdso_check = $(cmd_ld_vdso); $(cmd_vdso_check)
 
 quiet_cmd_vdsoas_o_S = AS       $@
       cmd_vdsoas_o_S = $(CC) $(a_flags) -c -o $@ $<
@@ -80,7 +80,7 @@ $(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
 
 $(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
 
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 $(obj)/vdso.so: OBJCOPYFLAGS := -S
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 37455d326110..7952ad6ba72b 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -122,6 +122,32 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_LOONGARCH => AllowedRelocations {
+            in_object_file: &[
+                47,  /* R_LARCH_ADD8 */
+                48,  /* R_LARCH_ADD16 */
+                49,  /* R_LARCH_ADD24 */
+                50,  /* R_LARCH_ADD32 */
+                51,  /* R_LARCH_ADD64 */
+                52,  /* R_LARCH_SUB8 */
+                53,  /* R_LARCH_SUB16 */
+                54,  /* R_LARCH_SUB24 */
+                55,  /* R_LARCH_SUB32 */
+                56,  /* R_LARCH_SUB64 */
+                64,  /* R_LARCH_B16 */
+                65,  /* R_LARCH_B21 */
+                66,  /* R_LARCH_B26 */
+                71,  /* R_LARCH_PCALA_HI20 */
+                72,  /* R_LARCH_PCALA_LO12 */
+                73,  /* R_LARCH_PCALA64_LO20 */
+                74,  /* R_LARCH_PCALA64_HI12 */
+                99,  /* R_LARCH_32_PCREL */
+                128, /* R_LARCH_PCADD_HI20 */
+                128, /* R_LARCH_PCADD_LO12 */
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.56.1


