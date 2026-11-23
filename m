Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C1606A335
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=c51R8ppc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=yQt064qw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6mY65JZz2y8W;
	Tue, 24 Nov 2026 00:51:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441885;
	cv=none; b=UNBOXbTOGvUjBLclAJ1NCOW9dpNCWJzp3X+ynXlY/cAtaJYU6GLcOgvETuHtGK6L0BXKYoOWO7z7k4LOEOln4Rxe6bspi0DDKODNriG3gVL7GRDNXYLXrrb97ln0wM31yodAc3j5bDeYQuC0gArbw7rUsOhO2eYe7vZIz905I47t6z7T7nE99ODYfv5feNBaqtYN/p5bufwPQPDpUs/qylfYxuinfFYjC4QmMra9fFf3uTMKSjtEolTU0UM+qyn2Xmwrs7ldT/pEE3SIUXLTRgqgNw5pSQ7S0k5K/pXy29fKYDoBoEe77h/CSLCI9bYpW2lzw7vUFlse0Q/2+HWiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441885; c=relaxed/relaxed;
	bh=9c4YRQQ6pnzSBpHUo5gQq1+MNXBhFp0V4WLQqxvRU3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/MDK5TZQqwLMXeKiPcbxomINiRtJLQS7QmQQ+ITQDDrvhK1fA6Go/HCxzOS0DoSys91EnxPDgW+fm6LOozx6QomPG4Isqs8QFVMacOQWkNUNlNu1TcjYL+pwTZ6w+79YatHWM0uovUCJPM07HodlMXvL+g4hCsJEFcT2ifLELDw6wBUxoa32wqouRTXVqaXtQnMJM8lVhQoOHU0pcoW3zzkIONWUzXCDHX+JIJmH0SabABTezuaqxyqoZLrI2c9y8PQBe7cPDbtVikX4xHq+yxUyVCeDR8yV8a/tUXWclXwdiDbxk2TUg/z9zk+GPigeVgExtAhnH7BFZywRdHPdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=c51R8ppc; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=yQt064qw; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=c51R8ppc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=yQt064qw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6mX5TFNz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:51:24 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c4YRQQ6pnzSBpHUo5gQq1+MNXBhFp0V4WLQqxvRU3w=;
	b=c51R8ppcFvgF+lecaj/yMlPRqDjEJqCxkHivVfbfMQYdSfZe4M6c4s4DoB+NYtz7vO+Y1t
	zZOi7noMVQNksc1y//WWdcFqSuEJJ5VrMKnXxTPR5jbhVw16t+8ig0vz2qxTFGsx97LlEV
	7Uxe5/+6DmvvvdKnLhZ5hkReO6ryCa6YDLcA6hFwgtuHyUBzoOOf8ceeoNaqPaklx7PIyF
	P7gF2nVtFX8AGncfEJvHENxFQOf+VcI4sDu8GW+0V/oxaZLjGmJxyoSPUsV/ExJ5sbdp1d
	ZKG7YGmqcArtssE05wbISs4JnXpKGfVfz5XJo+/b5IbUn7BR+NLokBi2wh91QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c4YRQQ6pnzSBpHUo5gQq1+MNXBhFp0V4WLQqxvRU3w=;
	b=yQt064qwYnbu3hJCbzrs1LSu9wJF9vC0+skGBQRPBjGzvIEoRyyX+E0474vs7Sqd4TUE6E
	XDQAx4LTWCyhrtCA==
Date: Mon, 23 Nov 2026 14:50:53 +0100
Subject: [PATCH v6 02/11] x86/vdso: Enable the vdsocheck tool
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
Message-Id: <20261123-vdso-absolute-reloc-v6-2-161e218dd217@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=2480;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QoUIl45MXZMRNJ380RzxrALVLspll1WbUT4Y7wjP5Nc=;
 b=h6xhrNJ/daWsX6d0KucIl1wYohqmJySrJ2C1jkqbSYPKJvt4SX6MThWjG3AJ53+HBHR3/pKpF
 7soB51VQ7nVDYQrnRCfrdx/gAbVU1MOH1o8b4GwEdR9wgqoPiEeBzvq
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
 arch/x86/Kconfig                            |  1 +
 arch/x86/entry/vdso/common/Makefile.include |  2 +-
 lib/vdso/check/vdsocheck.rs                 | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..09d3aa04ee82 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,6 +302,7 @@ config X86
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
index f4c0730bc976..8cd8c7f3fec8 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -34,6 +34,20 @@ fn is_ignored_section(&self, section: &elf::Section<'_>) -> bool {
 
 fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'static>> {
     match machine as u32 {
+        bindings::EM_386 => AllowedRelocations {
+            in_object_file: &[
+                2,  /* R_386_PC32 */
+                9,  /* R_386_GOTOFF */
+                10, /* R_386_GOTPC */
+            ],
+            ..Default::default()
+        }
+        .into(),
+        bindings::EM_X86_64 => AllowedRelocations {
+            in_object_file: &[2 /* R_X86_64_PC32 */, 4 /* R_X86_64_PLT32 */],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.56.1


