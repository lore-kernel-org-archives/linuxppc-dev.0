Return-Path: <linuxppc-dev+bounces-9985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B5DC83038
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jul 2025 12:20:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bWhvD04Rjz2xPc;
	Tue,  1 Jul 2025 22:20:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.236.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751372439;
	cv=none; b=QrCHxBmU0JjfzwBBBCUvisVqimLIh1KkJHbkr3lSG7pcK6DbpNpULCXJnM5Zbv0OeapdQdN2FfRUDJ9LU5Q5fogffCuUE6n+0bfaWXXzf0TKDyvGeZyDjnDVMocCxtDG54ms+I4ZSOKPxwyCjNxFzQDZheLwbHxhYybXkLjxsfLJEaxskdKt+YQMeVAU49qmkWTXwT2FYXNYwULc8MnWnyScpqZWhH49WB1LRjoqtL2BfW3YHSlDXfKA8XtozHg5OKHs/BcN3fI4peuo5LtgNZl6PNdtFljPBfMjVUCm/LQU1SJyQMgyk0isiXidQNs6Lq2adXt3WIKlCgENM6CrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751372439; c=relaxed/relaxed;
	bh=hYp0iUKhGPZWFIOMPciT4d/0/X9DjsGwgULw/SajdFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljfROI22R3Vb3i7GDI0wiFqwMFD7c0y94874nuUUgrLAd50YE6ZyUTXK7SjncNyjDVC59xBBB3ZKqWmLj9g9k350FN1MpV97dlq72wdXT014Gv0myByd0veku0irjFA8ROY3m/2nE4zW9iICiMYYv2rq3hmVax8m+dPp2mo29cHNjH1OO7JeMu9a4eMFaKdv9tSFpmRJ4BMXYXtDjWfsMeq9LAfXnAQK8EcUL83FIll8ZxuzvuWZhu6SEBzgY/r5ADRbI3uNsZb5p6P+A/b1yR9r3/ExLT+d7cQ1rrumf3rZ3I6lDZpV6x2c8i3tgDwM1eMsLwTy3BxV4VrUsFhrdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bWhvB3TmSz2xCd
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2025 22:20:37 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bWftm1SCKz9v6s;
	Tue,  1 Jul 2025 12:50:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZjP7bqju4rm; Tue,  1 Jul 2025 12:50:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bWftm0rDHz9v6d;
	Tue,  1 Jul 2025 12:50:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17B0C8B765;
	Tue,  1 Jul 2025 12:50:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id XdqZhR-nxYqf; Tue,  1 Jul 2025 12:50:08 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AB5E48B763;
	Tue,  1 Jul 2025 12:50:07 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] arch/powerpc: Remove support for older GCC and binutils
Date: Tue,  1 Jul 2025 12:50:07 +0200
Message-ID: <b6b94cba7492c8581e8d5d25b15962e5ad7a37c2.1751366979.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751367007; l=1618; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Fmh/oUteSMJXBwASChJwBISKL4lDdtXTv5z370N0ZhY=; b=em+8ziEW8wo/UJ208nB+/sKg9HEwdRL83AvMPAfM06pEayyHy/vcuDHEd/uGf/UuyUM1w/fRE cQI0OzWzOY5CGFcZiLtT0DgcNJiHgc5dffaHH0OVFbmtnkKvS1VHC5c
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 118c40b7b503 ("kbuild: require gcc-8 and binutils-2.30") raised
minimum GCC_VERSION and LD_VERSION.

Simplify powerpc build accordingly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig      | 2 +-
 arch/powerpc/boot/wrapper | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc83f120..cd35d90dfb49 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -252,7 +252,7 @@ config PPC
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
-	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
+	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3d8dc822282a..a75baefd1cff 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -226,11 +226,7 @@ ld_is_lld()
 
 # Do not include PT_INTERP segment when linking pie. Non-pie linking
 # just ignores this option.
-LD_VERSION=$(${CROSS}ld --version | ld_version)
-LD_NO_DL_MIN_VERSION=$(echo 2.26 | ld_version)
-if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
-	nodl="--no-dynamic-linker"
-fi
+nodl="--no-dynamic-linker"
 
 # suppress some warnings in recent ld versions
 nowarn="-z noexecstack"
-- 
2.49.0


