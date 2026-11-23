Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9A606A32E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y2qrpUFH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=XY2hGy4c
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6mg2SVmz3bV6;
	Tue, 24 Nov 2026 00:51:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441891;
	cv=none; b=AcpLFRE9+phlDP+FjHV/9pcsP9PfVIQ0OFnEqpgm+wrSkfcPAAcMXaUBor43raGPrqpj4mKu9HKm00I0lJsSOetbtsD6not2fucpGIEP+S4BMJK3vS8QbzvpRnv1oQpuQb97VeX1Sx7glZT2F52+ea11loKucKbDPR7mIe4ezWxzfGdDHj4RZWg07fS56PUYwOw0N4R0DBS0RcE6Q0eQr/0S+OGE93M3UlgqyJQHsO3eYViM/Rm/C30vYFgW4E4+7Z2Y+XjxrIB+wKrhdn6G4eiLxz60McbuNfA58b1uIgMasshKRd1H+i/JfIuwfGeUSZhw7fBrH2//wKMuTOukXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441891; c=relaxed/relaxed;
	bh=4eFtOIUXlB/3zrN30y5Vr5c5KdL9zNbkcXs+QwRBLLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8lQiscNkC4qlS2XTLo/XgFriA/nTKne1Vr9vTLRpTz8TaxEhnpsrFpp5Jk/8SdEyuAhvm0eIX2MfI9YniPTW++lu+c6zQznd+3GAvFKFaSjI9dTKSUFVqCm6lqvsQknpmBBVBqj3+RL+9NT1Tmo/+DL7sdnNAqSLzoJ/q8IIe+fI0jY2lv43/FPuATfjZTTWdn2G1N1M4nfubGA+xiYtSpSjPKMDC30hLn/TbamqKRxmXnVGJCdk/+EzvRb7hwKFuCHTi/SZGzD6AQn+GBzl9LZfgjh5VKieA63lMo7zBf2OoQezQEhTJDAdz1jpaGd6Rv7yBDeLNpcLKmgy6sjuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y2qrpUFH; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=XY2hGy4c; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y2qrpUFH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=XY2hGy4c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6mc481Pz2ySY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:51:28 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eFtOIUXlB/3zrN30y5Vr5c5KdL9zNbkcXs+QwRBLLo=;
	b=y2qrpUFHjyo+0pMBHaWwUhYXbTJNPIcVR4whnZwubVPwGrLaE+1Mmk2Mwi5WKuQDu7n6iK
	IxT3kxQpnVBBexAnF0ihS5lfLDaFO2yZB/xnwdS5zoFeUyigBfLzBR9hxvT3x4gDmc+6ZJ
	flIELvpITzh8VhPCfJya5ZOTnXK/xiterHEPXNFbpa5f+Qizmz2LKuMplLRNcmsaccPT71
	bzlF810zu1Rww5Diqxf9sA0ClHmhjYZs9LcDI8M2QN/FteZKxNbWWCxFnzgO4x1Y2LXygE
	/0EP1KSgGHVkf/dr39ZaV3wh4xEEjOL8onok1E/zu4qmvtjdVXNW+2xfMnH4iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eFtOIUXlB/3zrN30y5Vr5c5KdL9zNbkcXs+QwRBLLo=;
	b=XY2hGy4cWmay/FFPNrPlsYtYrkhSLiBVvC67xaDxTH8uahrD+vR0WYB/jdZNhsfoWk9NzD
	rmVwXtqSDk1V2JAg==
Date: Mon, 23 Nov 2026 14:50:57 +0100
Subject: [PATCH v6 06/11] riscv: vdso: Enable the vdsocheck tool
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
Message-Id: <20261123-vdso-absolute-reloc-v6-6-161e218dd217@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=3576;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MntGa2c7F/hFX8g0jBZrZAZFlve/PN+fivtH3qTBWPk=;
 b=E0OeOrGeIR7bOANcC60kOQeCX/ghNoL4OOe/6jVEwOUqPM8BuZA5TNCH2kWGUvAnrKk1cra32
 Sqyo9hLfgFEAlCARi9PB7WSaGZbX9p2AcUfrE8XdPahGDH8DoZdd3Qg
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
 arch/riscv/Kconfig              |  1 +
 arch/riscv/kernel/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs     | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e7891a2a89da..2a0f5fbcd7e3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -226,6 +226,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
+	select VDSO_CHECK if MMU
 	select VDSO_DATASTORE if MMU
 	select VDSO_GETRANDOM if MMU && 64BIT
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index c023046a3fd7..b15039d0309e 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -75,7 +75,7 @@ endif
 $(obj)/$(vdso_o): $(obj)/$(vdso_so)
 
 # link rule for the .so file, .lds has to be first
-$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
+$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_check)
 LDFLAGS_$(vdso_so_dbg) = -shared -soname=linux-vdso.so.1 \
 	--build-id=sha1 --eh-frame-hdr
@@ -97,7 +97,7 @@ include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold_and_check = VDSOLD  $@
-      cmd_vdsold_and_check = $(LD) $(CFI_FULL) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
+      cmd_vdsold_and_check = $(LD) $(CFI_FULL) $(ld_flags) -T $(filter-out FORCE $(vdsocheck),$^) -o $@.tmp && \
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
                    rm $@.tmp && \
                    $(cmd_vdso_check)
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index da58ff220eab..37455d326110 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -96,6 +96,32 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_RISCV => AllowedRelocations {
+            in_object_file: &[
+                16, /* R_RISCV_BRANCH */
+                17, /* R_RISCV_JAL */
+                18, /* R_RISCV_CALL */
+                19, /* R_RISCV_CALL_PLT */
+                23, /* R_RISCV_PCREL_HI20 */
+                24, /* R_RISCV_PCREL_LO12_I */
+                25, /* R_RISCV_PCREL_LO12_S */
+                33, /* R_RISCV_ADD8 */
+                34, /* R_RISCV_ADD16 */
+                35, /* R_RISCV_ADD32 */
+                36, /* R_RISCV_ADD64 */
+                37, /* R_RISCV_SUB8 */
+                38, /* R_RISCV_SUB16 */
+                39, /* R_RISCV_SUB32 */
+                40, /* R_RISCV_SUB64 */
+                43, /* R_RISCV_ALIGN */
+                44, /* R_RISCV_RVC_BRANCH */
+                45, /* R_RISCV_RVC_JUMP */
+                51, /* R_RISCV_RELAX */
+                57, /* R_RISCV_32_PCREL */
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.56.1


