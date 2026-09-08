Return-Path: <linuxppc-dev+bounces-26740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D30CC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 06:35:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfDg56kc2z3bjL;
	Tue, 08 Sep 2026 16:34:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788849249;
	cv=none; b=j4EXmYl7PlYO4F+ypT/zdha71etloy8UFHdmWUMUKKe8KPxVL/q+Gc0PiRplEVxveRp1SictmD0qQ8PPTb+hyZkplAfiSggQSd7yEar0R7uhdoYIY8Uo7UYw/Tnb5KbmfcjtVf7pNEnOBfvfF1Zw9ev34qoxe550mhUBqVUKtxMV7M99TZFEmZSnSeUybCu8ZbQlIq9MJQP2B3gXLE+R0aOxltOtbimLz6+vkm8yqzB6AbPdd1XpvzxLyQUIlaHFtv8xQdNvLUsh9KaTsgW95YAVE5nEYo/ayoyTac1gKRVz8021q7dJnoC9uVgUkeQMlJsEzR4T/DalSd+9j2eKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788849249; c=relaxed/relaxed;
	bh=Pdi6tJcXia5GQvjWLdDYxiQ6I89enT2mzL46ZqnmdMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItnLFIv6ur/W3Zgt1mvxgsYbnXwmrSYHrkCqVzLHfC+FEjBHzt95efhy1Ufbs+k1/qVYWya80R/PwTfhcBkFDFlHAneVPPihQP4/9XXMwcqyVXR+hVlrYViRnpU0Xd1WEsU0GewF7OX14kzg7ULZ0XWrkHn9P/ONophgTvk8sYH7jxVGR9oF8BVjrR/cMxYXOPvKvWUwN1YuMWAsayITLCeupxt3xWPqjIShvZThv/AevaSIMdNXLpas8anFK9NUPCjyi6Ip/TfteuVkN/4crBf6Nf4NRqiJnes63oqrV4OrIWdFPkJ/syl9iG1992TF6YvvQCKfvk/NxP0vQDz+nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=srXUKKBv; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rW7/VoVl; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=srXUKKBv;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rW7/VoVl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfDg04N2zz305M
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 16:34:04 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pdi6tJcXia5GQvjWLdDYxiQ6I89enT2mzL46ZqnmdMg=;
	b=srXUKKBvBnZWl7h+1tvBv5e+AlKq5znw4KLWobhNXWNfQAuYkrwrf6qLr9sX3I376tXpaL
	0gCLK9hvRcYej1aY+vuLNUXX8k0WaaNjh/gf2Si2JH/haTjazZxULX0a5f7Yw140D5KgYT
	mY6i1JDe2y9ffdmhX61Pp10Gxy+SfEXQxM2EnqvziywLYsrgXQI8aTTmQXJNqF3Wlg/vEp
	0gaYbr4thtj8q00nsmFu9BsDc1syHcFh5c6rh+d3Wwq5S09FzqW3vh3uH+fdVp1FSM314K
	eg0gs4ury6AuRJrLxdmHGTOamuoIr50Pr/4C3keU04Rznfn+4zwCC+V/Fh4gkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pdi6tJcXia5GQvjWLdDYxiQ6I89enT2mzL46ZqnmdMg=;
	b=rW7/VoVlTLF38Sp6NbEw24XpKKO0l53Bu8vFJSSAarrgsh5+3oOcPR3GCmN8eCmuxD/xDP
	pyuyJDO6nu5wCADA==
Date: Tue, 08 Sep 2026 08:33:50 +0200
Subject: [PATCH v5 16/24] powerpc/elf: Add 32-bit REL16 relocation
 definitions
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
Message-Id: <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=1737;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gDavw4WAqw6o13GhA3u/II77o40pPBvpHsDECXNhldY=;
 b=at10aJs/4BEOnHQNfCkeHcofnKffueuw1V5jX3gearAcRNXGLUowN4VA80tWswO8yBV0CJAoU
 1lBC/PMHi3vDICsSQ0DEs5CGMsAX8t5/pR4/5NVDW4dQxNWMl/dsaZv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These are used by userspace and are necessary for the vdsocheck tool.
They share the numbers with their 64-bit variants.

Also update the copy in tools/ so they can be used by vdsocheck.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf-r.h       | 7 ++++++-
 tools/include/uapi/linux/elf-r.h | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 72fc9045a5d4..170888422400 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -182,8 +182,13 @@
 #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
 #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
 
+#define R_PPC_REL16		249
+#define R_PPC_REL16_LO		250
+#define R_PPC_REL16_HI		251
+#define R_PPC_REL16_HA		252
+
 /* keep this the last entry. */
-#define R_PPC_NUM		95
+#define R_PPC_NUM		253
 
 /* PowerPC64 relocations defined by the ABIs */
 #define R_PPC64_NONE    R_PPC_NONE
diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
index 72fc9045a5d4..170888422400 100644
--- a/tools/include/uapi/linux/elf-r.h
+++ b/tools/include/uapi/linux/elf-r.h
@@ -182,8 +182,13 @@
 #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
 #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
 
+#define R_PPC_REL16		249
+#define R_PPC_REL16_LO		250
+#define R_PPC_REL16_HI		251
+#define R_PPC_REL16_HA		252
+
 /* keep this the last entry. */
-#define R_PPC_NUM		95
+#define R_PPC_NUM		253
 
 /* PowerPC64 relocations defined by the ABIs */
 #define R_PPC64_NONE    R_PPC_NONE

-- 
2.55.0


