Return-Path: <linuxppc-dev+bounces-26727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5856C79FAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 06:33:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfDfp1Gdqz2yjN;
	Tue, 08 Sep 2026 16:33:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788849234;
	cv=none; b=g/ENQ9Ue+m5E5DOBGxnTKJPGPYD5a43Rbvuis87JoGVo9DTq0d1wLuDf1ymaHBg2J56FqMCAuFG1HPQLHrh4AVt+24U5hFcBS0zpJ/TXukmMGqAeuaii7gukAmVkhR8aBhvmzb65VXDQEJ6bN1nWFK5yTaW2QmKv9j4JYZRenS3OWNzsVRkEiKOZh0biTnCRtgWKHv9o0nsoA3K4Ww0tOBqQF+0UBvI4gP1mdG6ZphqnhT3R0ZACyzGk96I/R+AkXoYgMxWKBEXTk1MtkS6IlB9bAyQ4a5LBPj8y3M7nvQfLP3aN7pvREGwBIT+yWbuTl9zZpkFgFD1CDOba/EitTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788849234; c=relaxed/relaxed;
	bh=hIZqQqreoVp4jL5VDlYmXNMQM5O5p/caA2tuy/ziotc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLaBiwRAF+Ur4dnX00ZHpqCax4fzUj2n4mnP67imA1Sf/hib72allthDytXP/F2t6sXTE5KTnLM+IHmUsMLYjF/NU2b7BKtJVte04pGr3PTV3IARPTRXPGWXaZrTnFGSZKu9NTa3C5COyNs1biN6kxd56SRcpDVW1CJfsLTE2/56TZcoz3uG6TB0dlO0zqk84o+jNmVcrk1cpalyx77eIYu0MRl1Hpb1V+yxwSP32cqplLmkob9ugL2HeYyvE3EpJ9LfZd3WnvXnljY2w7jFYUoTlzSknC/7BQi0BsIY1a5UQoIiNNjPvnfCX+ILgN/e/Bs7HmbC48eVAGfCdCt6Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ebIbHeLL; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5Q9BAPxI; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ebIbHeLL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5Q9BAPxI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfDfm5dzMz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 16:33:52 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIZqQqreoVp4jL5VDlYmXNMQM5O5p/caA2tuy/ziotc=;
	b=ebIbHeLLhulPxU96t2LRMg4s4x5K/xNe3iO4CR8LKAIdJ9kYfTc3MXtWBz/fXjFkEU9kMr
	ld8JvPU+EAtF9gbFrTW6gwQHl+2Bclu/F+5tk06gWU+u8YSLGy6Fs+b+dl+oT7u7R+QUlz
	bCl15HE1EVvXEl60ida0PtVa2R2PD9q2BdCLGN1ph/WmXkFBIb+v2gs8Mz4niWS3c+WFNF
	s5L1oWts84MWkE5GzZSbShoQTqSPfKHvYz1OJVecgZ9cSrkKKIh7FoerX+WoXxVwtFF+8f
	hg7jFr8a/amVt5iCyOzW9R3BnRUIfT7WfuRnMScYGrUMlh6kWYjJybJPngonVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIZqQqreoVp4jL5VDlYmXNMQM5O5p/caA2tuy/ziotc=;
	b=5Q9BAPxIl6FXv9Um3lg8pwJD6tKmF767tMf3YrqRNLIA3fzOdbqDAtSMZ58ddEqhSk+iSa
	SWIkWgAern8ootAQ==
Date: Tue, 08 Sep 2026 08:33:35 +0200
Subject: [PATCH v5 01/24] elf, uapi: Add a header for relocation constants
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
Message-Id: <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=1348;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BNQHFvTY0jFJrlhn6+RVLpYSgcHasImekBzIK9bpThE=;
 b=ncJJdfJzUputRN+485gg2paJ/pNXo1aFgMnfr2+Vvf39fIyuFgtJ0VGn6HbawU4QQNwNU2xhl
 vPCs3Fdp7LyAWOKAaDyvzvlu+8V715tn72jQFoXKC+X5TMsa0Xr4m74
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

While the numeric constants for relocations are architecture specific,
it is still useful to get access to them from other architectures.
Also the definitions are useful for userspace in general.
For example tools processing elf files during a kernel cross-compilation
can make use of them.

Introduce a dedicated header for them, similar to the elf-em.h header.
For now the header is empty but it will be filled step by step in
upcomming commits.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf-r.h | 5 +++++
 include/uapi/linux/elf.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
new file mode 100644
index 000000000000..2c382c8a4807
--- /dev/null
+++ b/include/uapi/linux/elf-r.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_ELF_R_H
+#define _UAPI_LINUX_ELF_R_H
+
+#endif /* _UAPI_LINUX_ELF_R_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index ee30dcd80901..b3e312255552 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/elf-em.h>
+#include <linux/elf-r.h>
 
 /* 32-bit ELF base types. */
 typedef __u32	Elf32_Addr;

-- 
2.55.0


