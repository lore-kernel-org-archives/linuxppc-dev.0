Return-Path: <linuxppc-dev+bounces-26742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C24C79FA0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 06:35:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfDg82gnYz3bsK;
	Tue, 08 Sep 2026 16:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788849252;
	cv=none; b=g2BDVoVgMa5m65ipHIGB9cNjmoXkyumI6B+MPVkqwOpRN/SpbhswET0/Ucb26dboaKCc659vtLbuPYjEX//VjAylFD9sKs1JnibLPJ8mNq7mhhwFVfNls0vQoh99qVUtXweA9K1CsDakSiD77nym/Ljx1SbVJTrHJymS+lHy7VqsUaqeGzAmME08laEe5Zfqz8RWBGTW2/+BaiecCelh8AbnGkaXdj2jH5shwKHszH96Hlm6lVrz+7cYb0D1K76YG1thHdi0jMgj+GkdULOMn3fDjB78YhPYTaavahD1EaFOM4cy2cFfQ7iHLN4ePMgaP24etVujzqaprjHB9yVVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788849252; c=relaxed/relaxed;
	bh=R8S5zUcti2qRnvnqiwdZ99APOoLvCYmczAvcwW6T+78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNBcGpPm7mcCEGK7ZAeFtl4n0NRSj/NCsTGXFKrcjBZWUrYf0kZuNdU63+U4XLM0rl/43CTuOw4TdWtRhsPwEMm2mia96l9IjFaMko46wG7j+j6b1iXoU/3UH52yArFmMvaMNEYqMx1wJKbw7ECxdDwMNKKsifYp9AjPuRU3YMKS/nNevFFkb8F4QhTo/uUJWW/hyWUP8PJ1J8Watc5nLTXgHTQjYeVCUxvHtCPTnnSUtlIJcssQAxeCaC2lfCoIi6hG+cdELkWQ+TX16Ex0pUKfrpwERpIB+9pplC227lXfTwpqbPzgTkphGIQNLIeJZ1VF6cxoU+SYDrGLG9YEfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hBTTSmMh; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=pnROhmeQ; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hBTTSmMh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=pnROhmeQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfDg249crz30WD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 16:34:06 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8S5zUcti2qRnvnqiwdZ99APOoLvCYmczAvcwW6T+78=;
	b=hBTTSmMhDdM2I6kdqJpAUOIrF69Iua1sqGHZrZEeJV+RrcDKO3Lh6TsXgdenOxFOnA4PoA
	412uPFiR4UGcIb6zo/ixzKsRV5LZO72namgWFB+cnr4EH1Utd/VSj8gvUK8F63ekFmUhqH
	e4ILH1GjbVqWGvLNLwK9XP+4Ygy6HN0YUB9kGB3oz57J5JzxQBb26TeNDe+cNb6xv87TOy
	Z4jMkBFqsKI4y45ukbIyST/V0/zEwljrr2NXcntK+uBr0cM363V1w55zye9RhNq6wnigOn
	7fYPjipzEFO17Oeq+ED1P9qQWrEtAGBcvP+xMvJvi49Am978rgJgX00l+QbCZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8S5zUcti2qRnvnqiwdZ99APOoLvCYmczAvcwW6T+78=;
	b=pnROhmeQiS3cU0albwBwH9dlRL1TxZa9HToYE3xYcsDLiQflLOIHiW/vhhcx0oenTo2D8f
	TUqAyVRELIZVMCDg==
Date: Tue, 08 Sep 2026 08:33:52 +0200
Subject: [PATCH v5 18/24] riscv: vdso: Enable the vdsocheck tool
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-18-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
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
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=3596;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rB4eegSBfTJvyEpPR1AwSf8HHKeuiOU4EBXL8/NjovM=;
 b=ckjkIaN/2GD1n4ZD/6VNQXvUS4c8EPXkV5wm26xnc8Ipzseks5mvPh9EdV3eGaQ2tZQZNlGho
 JgbUjoNJu6vBrX5nqStpT8ES8eXNkaNjgeSRWwJDzlvAf1sCbw19+8k
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/kernel/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs     | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f8e26c4bed2b..f580d2afecf7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -229,6 +229,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
+	select VDSO_CHECK if MMU
 	select VDSO_DATASTORE if MMU
 	select VDSO_GETRANDOM if MMU && 64BIT
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 8dbf2532a573..7e707fdff26c 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -74,7 +74,7 @@ endif
 $(obj)/$(vdso_o): $(obj)/$(vdso_so)
 
 # link rule for the .so file, .lds has to be first
-$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
+$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_check)
 LDFLAGS_$(vdso_so_dbg) = -shared -soname=linux-vdso.so.1 \
 	--build-id=sha1 --eh-frame-hdr
@@ -96,7 +96,7 @@ include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold_and_check = VDSOLD  $@
-      cmd_vdsold_and_check = $(LD) $(CFI_FULL) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
+      cmd_vdsold_and_check = $(LD) $(CFI_FULL) $(ld_flags) -T $(filter-out FORCE $(vdsocheck),$^) -o $@.tmp && \
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
                    rm $@.tmp && \
                    $(cmd_vdso_check)
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 429bdcd65818..67562d21f877 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -96,6 +96,32 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_RISCV => AllowedRelocations {
+            in_object_file: &[
+                bindings::R_RISCV_BRANCH,
+                bindings::R_RISCV_JAL,
+                bindings::R_RISCV_CALL,
+                bindings::R_RISCV_CALL_PLT,
+                bindings::R_RISCV_PCREL_HI20,
+                bindings::R_RISCV_PCREL_LO12_I,
+                bindings::R_RISCV_PCREL_LO12_S,
+                bindings::R_RISCV_ADD8,
+                bindings::R_RISCV_ADD16,
+                bindings::R_RISCV_ADD32,
+                bindings::R_RISCV_ADD64,
+                bindings::R_RISCV_SUB8,
+                bindings::R_RISCV_SUB16,
+                bindings::R_RISCV_SUB32,
+                bindings::R_RISCV_SUB64,
+                bindings::R_RISCV_ALIGN,
+                bindings::R_RISCV_RVC_BRANCH,
+                bindings::R_RISCV_RVC_JUMP,
+                bindings::R_RISCV_RELAX,
+                bindings::R_RISCV_32_PCREL,
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.55.0


