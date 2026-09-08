Return-Path: <linuxppc-dev+bounces-26747-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF3DC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 06:41:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfDr11K9wz2yqf;
	Tue, 08 Sep 2026 16:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788849713;
	cv=none; b=bhYBquXocBw5MI3pfHJ/gGSK6b5Kgo0QjWrUN4vrotrosHtNArkFby+4pHGr7ePlBodxdy2lYFwlOs/fj5jxmZXX2aISyy2EjISIamhMurxc1noZryuu1M/68RM3nXmAMKiCv0vFnoalNR727kdzxgL4lxwFD3GwtGe12tk1Y4N4fCQ/J4DDlG8qtA8YQwj49TRjMQlHeQiptCyx2ojFWoN3JJBFn9/UV8xpuR3eow7QxVA+xIQaatGLTmtbYHqddn9DBxTsvOtH1ttv0RNqfa4KF0l6dIXFSOewc5drk/bGJ/xxlSfnuj8NTHU9EcCRgrhKUzi7iVr5LcWPI2gMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788849713; c=relaxed/relaxed;
	bh=QpMeGTA/JL9YkhE8VitmDDEUz8BAqAeVVV3RUo7s8KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUsbrvE6+EU5IzaMkLqD3Jzn+LSzTEkd28tPb73np7GEbLupd6BuQkocRX8JUGqKuPnwBiHihKXDDTV5J46i9SaE6bujRvh6j62FnsWgfOthIjnjyxiVuGA42s9RHOBoySntfWGDXVj5k7AIBfXwjXj9/fyg33VtW2IO0HlBEzEzWUduiRIeYIZTMPXsV7yskI4Bswk2vEp+UYDnkEAnhF7Db0UIolr8/SZ4SjU2LU4pfdwwv2NC7+dQ+xGtYwf52F0RER+G1q9z2/c/7QSg33WSDqGnKuEhf9JsUvsjd1HkuEG4hpQePwRiH1IulHXm0gJCD7gCR+PGd0K4qDTBqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YMIoDXx/; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Wz8zdRK+; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YMIoDXx/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Wz8zdRK+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfDqz6qRzz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 16:41:51 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpMeGTA/JL9YkhE8VitmDDEUz8BAqAeVVV3RUo7s8KM=;
	b=YMIoDXx/ryyJO/wNSJr79hBrk/1uKFLoRwuyXWq2ERwfWyVqyJffleMbiT+vvuWtO204/K
	XO3RmXGCnqV4w7lfkhlRudbX45mFtdRD41W9PJVoty/pqKiHswGZXTaKvmOaxPSu5VZJVM
	xxsp4AJePJ+ALKIQ/EeGwO+kVJXptZyvKlxH78jJhdZkeOrN+Ww5q1WKtNHcy76t1B+jzv
	XQRYBH9ansqx4KI/6zXA4pK/oLhRKj+aRYBHIq9E7X1UO0E3YCVRVTfZ6ee2DiCObTk4zf
	wtUuUCDZU7XTwecLf7y0KofwzMRjqZcFYKJ6viLp4DkuxsMmnK/jJKnBlUZEnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpMeGTA/JL9YkhE8VitmDDEUz8BAqAeVVV3RUo7s8KM=;
	b=Wz8zdRK+ls5E3Iazhq49Wi6Kk0ecGxrc48ZY5jjgK217bXfYrQAd4sT7ItwhO6FCRyToCS
	ZOi8PKGbBnEfh/BQ==
Date: Tue, 08 Sep 2026 08:33:55 +0200
Subject: [PATCH v5 21/24] MIPS: ELF: Add more PC-relative relocation
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
Message-Id: <20260908-vdso-absolute-reloc-v5-21-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=1280;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=R3oIxCvKReHS31AXFavRgNPui6/4omq3e3P+29cRTsM=;
 b=rkjnjj70dplXDvHhkzfJOvBIecn20+RvsB4YJZT7kS6dmC1XplZqrPoTSbkM+YB0aLRxuxOb5
 Wp9eyI0SYfRAyhHyeFjnDOCIAqDeZA0dEsHaudn+dA9ns9ki2xZGWbR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These are used by userspace and are necessary for the vdsocheck tool.

Also update the copy in tools/ so they can be used by vdsocheck.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf-r.h       | 4 ++++
 tools/include/uapi/linux/elf-r.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 170888422400..a6a4d7643c5d 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -646,6 +646,10 @@
  */
 #define R_MIPS_PC21_S2		60
 #define R_MIPS_PC26_S2		61
+#define R_MIPS_PC18_S3		62
+#define R_MIPS_PC19_S2		63
+#define R_MIPS_PCHI16		64
+#define R_MIPS_PCLO16		65
 /*
  * This range is reserved for vendor specific relocations.
  */
diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
index 170888422400..a6a4d7643c5d 100644
--- a/tools/include/uapi/linux/elf-r.h
+++ b/tools/include/uapi/linux/elf-r.h
@@ -646,6 +646,10 @@
  */
 #define R_MIPS_PC21_S2		60
 #define R_MIPS_PC26_S2		61
+#define R_MIPS_PC18_S3		62
+#define R_MIPS_PC19_S2		63
+#define R_MIPS_PCHI16		64
+#define R_MIPS_PCLO16		65
 /*
  * This range is reserved for vendor specific relocations.
  */

-- 
2.55.0


