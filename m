Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36D606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AdnWR/fT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CiSYPSUw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6mh2WB4z3bc6;
	Tue, 24 Nov 2026 00:51:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441892;
	cv=none; b=NqnbkUNPt7ZD6tNBxXzQYPiQg7dqN4hZU4vdu20W8r5q0VWKG3tmt9JoX++3wX5UO9RYG7JXb6wvNAQUePbCVGHe/oVllA6tXpJTq/M/AsyAKnKbf0cWVcJSmU7kWyAhGFYwUVynnXqs3K6VN5ANcQoXH/unY1ZVOo8O0VErlKs0s0b5Ucz7PD39/FbeMBoxjTGKvHjtKxpK7eejN+KXBZSSHuFPpZNwMNa/xmFNksSZTCDtOKnjaqD/eYmNcjxZuN1So8hEoJqpwx18IBlSoFAIz8MPS4iN+G5rR5nwhJGaNtGCR0Uz2sSoqCtUL2HaCzc98KvCeDA5AvU+ZfrDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441892; c=relaxed/relaxed;
	bh=wbaUWZC28smuRoW90pWpaXz3GGY4MsOKGg8st7PIjvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9Cl84CmLHx9rYU3K8gZO3Xo9Xn99KUILO/+1wTNzqoqRFcgSpENPPpBm4PERq19FMCr3QwfXKQP9kOVoBgMwtiitq1vL5x2lDtGdwmXXXhBgm3RE7WeEXg9o3aVajD39Y67MsH2Jw1qoXCL+0ftKwnFZgexX2hBYa8maZM/SD3+9qQPWmlhC0CUn69eoRIMto9k3l70sD7H/WgZLcVk/sXFlTQzCVRPOWA61v1wntiKHumr+rvRlJfi6dfIQAoKk4Uif+zPuAfWcZJVWYuetcxG/pkuO7GCGySkNaW/wxqcAm+gPwsGmzynAQLr1HDFKZBPiL1Pe3sHCF8zDFZBSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AdnWR/fT; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CiSYPSUw; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AdnWR/fT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CiSYPSUw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6md2CnCz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:51:28 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbaUWZC28smuRoW90pWpaXz3GGY4MsOKGg8st7PIjvw=;
	b=AdnWR/fT44yXzm+ht95OqsrELNCyH358idfw54sxV+82ZCQh8b1aIvskImaSeMPYYiPAGX
	tMSFHMm39iz7ISqX2w8pj4D8L/qzXb1g+WS97tFqN8moTMNum/DjAz0AOhUR9mHeaYQxj9
	5LZEWcHDHmfyVG3iQ0WvT8vFcoQbpRxTznUUUuQTu76cbBTyn3KQ4CodP8l937jaO91ZuP
	Qt441N7af+F5t3S2BxLy/sH8WAJ3bW5O4y6lY0UQw0K7A+UQhTXKdNOY7nqA7niM/tyffr
	0vxJK9JiP8+NfpneuW9wJzwcEPrvj3p/SNvKjKHMhV35bVoateZvXcf6rspcBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbaUWZC28smuRoW90pWpaXz3GGY4MsOKGg8st7PIjvw=;
	b=CiSYPSUwyavYYl1x/i+wWbxPyj9epV9FlY90gd2wiTfE4WxtGjnCDB5MgwLKxaEC26eTmC
	kUVvWJED9GTdvTAw==
Date: Mon, 23 Nov 2026 14:50:56 +0100
Subject: [PATCH v6 05/11] powerpc/vdso: Enable the vdsocheck tool
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
Message-Id: <20261123-vdso-absolute-reloc-v6-5-161e218dd217@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=3226;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Cgbtb7qSJ3AcXOvZFi0BZIPMWqlXOiwZ1bBjbdIILZ8=;
 b=tf9jQyiu6Hx303xQeraxjP8OCezqMY+3qKghsgR/OWQajoh6hO04aKYTX/3KWhg5DquWsJP8b
 aAXQOlfMR3eDCtoARUDmA0kN0uVLstrGS/+wTZDeacxxM2luRimKr84
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
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/kernel/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs       | 27 +++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3b6cd655606..1c4a75c3a830 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -327,6 +327,7 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	#
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 0d1a49529885..b2e399e10273 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -82,9 +82,9 @@ targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o $(vdsocheck) FORCE
 	$(call if_changed,vdso32ld_and_check)
-$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o $(vdsocheck) FORCE
 	$(call if_changed,vdso64ld_and_check)
 
 # assembly rules for the .S files
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 0d5ceaca34d7..da58ff220eab 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -69,6 +69,33 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_PPC => AllowedRelocations {
+            in_object_file: &[
+                10,  /* R_PPC_REL24 */
+                11,  /* R_PPC_REL14 */
+                26,  /* R_PPC_REL32 */
+                249, /* R_PPC_REL16 */
+                250, /* R_PPC_REL16_LO */
+                251, /* R_PPC_REL16_HI */
+                252, /* R_PPC_REL16_HA */
+            ],
+            ..Default::default()
+        }
+        .into(),
+        bindings::EM_PPC64 => AllowedRelocations {
+            in_object_file: &[
+                10,  /* R_PPC64_REL24 */
+                11,  /* R_PPC64_REL14 */
+                26,  /* R_PPC64_REL32 */
+                44,  /* R_PPC64_REL64 */
+                249, /* R_PPC64_REL16 */
+                250, /* R_PPC64_REL16_LO */
+                251, /* R_PPC64_REL16_HI */
+                252, /* R_PPC64_REL16_HA */
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.56.1


