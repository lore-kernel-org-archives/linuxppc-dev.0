Return-Path: <linuxppc-dev+bounces-26735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7239BC79FAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 06:34:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfDg16CkRz2yvB;
	Tue, 08 Sep 2026 16:34:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788849245;
	cv=none; b=j3yg0vyAiZwK+UdWqddDmcanKJx34FOsWgZB0rpb8qyxooHekaNW+TnAbY591e+RKjVLzKuBDX2iTc9I8JsDEPYOXr8rRYn3ua+UFuEq8H8+lrnUeyNN+vYrxMpmVmuyncH1HWxbdyMNQXrFNhQZkrGyQDojxbZQcVKbzWoY81vHsGoWad40pN4nSnun0hXlWVg7sRiPDGZKIKMC91u/TDyPr7GTYpnY4pAj9Qji86Vm2O01tW82WJvDX6KQGCq9kcyQhd+c0V4yX3y6KkMgwIpQ0twVLrpqsZ+1A4TmDkMiEdGHwRSKZ7fOHClJHVnZAksZnFefKE4QyutCNWP1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788849245; c=relaxed/relaxed;
	bh=qmuSOH1PlxKnA1sFNyVBb78Nx7lvcJxtk6uyQh9eAbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsVLMXU4NYjdOwIWTjVKC9w3cD0cYwuz0ca2qVlixJvq37WfrfHApunrtmx5rCwu/jiDII1dIuKmQ2CdZmV1weZ2zQ/JC0j2ma5bAGYKAsFAWNNYjUgkPASMg8MM+YprkRlfaJgEDzWLlGehVm4Yk4BvUdplXDtLuRFGd0KXLjiYhDXZiipuWwRs6BmtDMdZtiKKoKg7go4WD9k2u00xnuOS9w34s1ZPc8xFWGmLMVPSJz0jqWyQancf07lJA+pCZITGC/dLsBGCrv4OMXMHz0YHc3brA6OVXXdRkfuF7lxiplDsS9+0LzHK2Nzx56UmT8WE+gvudJS6vGVC54PpeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MJbNcbqr; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=X30WsAgk; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MJbNcbqr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=X30WsAgk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfDfx2Jgsz2yxN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 16:34:01 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmuSOH1PlxKnA1sFNyVBb78Nx7lvcJxtk6uyQh9eAbo=;
	b=MJbNcbqrPXIV4MVekRibhCQzI3C+hzP+3EH4R9OzuBdd1PJ+MSUAobqW1FP7bvjy+d0i63
	nZQcOUrV6MCliZnClZqT8pq2wRrwSn6jgiyTMnu5+XxVksTmxJaG1b1+pPu8unHvuy2wBC
	BxofF/S5Die7TrXexDlzFzpSzP1uREIFOgDvLv2wHFWUeyeQ7zQPN8y20onY8ZTr1ZGpDZ
	7VAIJ29E8wEfD/0IKTZfGZnq9bYRIDS69h2jcJO8oluBA0eWh2PYptYeagtoUcDRnGeIM/
	cj7CR+3jJCS1/NopI6vTc5QAm7MHqHLBO5AkYbugodOUMCaEPNyaxk2hKv2VCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmuSOH1PlxKnA1sFNyVBb78Nx7lvcJxtk6uyQh9eAbo=;
	b=X30WsAgkstsozlHa+DC4mGpqHKVlDRk5DYwXaKpWLVIF6u35pncScYR+NtHgrl304XBqY/
	wcna4+QkMAmSkvCg==
Date: Tue, 08 Sep 2026 08:33:47 +0200
Subject: [PATCH v5 13/24] x86/vdso: Enable the vdsocheck tool
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
Message-Id: <20260908-vdso-absolute-reloc-v5-13-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=2487;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vRbc54EFTJK8Edczu3nKOvbSzT/ak7osQzTlANhwfg4=;
 b=QoGW6+1pU6UCOJIoCAQWiJdDPGXza8QAmW74TVb+TFEF4Gg6rdDkscKCRLfDPN8KjcDIG8C8F
 Q/VLV8dyYABDvGmgs7XWDfcnTFUCyodw77Rrt8RwxwTZvWyIDrh6KpE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/Kconfig                            |  1 +
 arch/x86/entry/vdso/common/Makefile.include |  2 +-
 lib/vdso/check/vdsocheck.rs                 | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..ee0f2c401980 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -305,6 +305,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
+	select VDSO_CHECK
 	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
diff --git a/arch/x86/entry/vdso/common/Makefile.include b/arch/x86/entry/vdso/common/Makefile.include
index 687b3d89b40d..510d5e79857e 100644
--- a/arch/x86/entry/vdso/common/Makefile.include
+++ b/arch/x86/entry/vdso/common/Makefile.include
@@ -71,7 +71,7 @@ quiet_cmd_vdso = VDSO    $@
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
 
-$(obj)/vdso%.so.dbg: $(obj)/vdso%.lds FORCE
+$(obj)/vdso%.so.dbg: $(obj)/vdso%.lds $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S --remove-section __ex_table
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index f4c0730bc976..1174d896a68b 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -34,6 +34,20 @@ fn is_ignored_section(&self, section: &elf::Section<'_>) -> bool {
 
 fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'static>> {
     match machine as u32 {
+        bindings::EM_386 => AllowedRelocations {
+            in_object_file: &[
+                bindings::R_386_PC32,
+                bindings::R_386_GOTOFF,
+                bindings::R_386_GOTPC,
+            ],
+            ..Default::default()
+        }
+        .into(),
+        bindings::EM_X86_64 => AllowedRelocations {
+            in_object_file: &[bindings::R_X86_64_PC32, bindings::R_X86_64_PLT32],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.55.0


