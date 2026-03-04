Return-Path: <linuxppc-dev+bounces-17672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D3DEDEC1B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 07:49:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQlDY4gyKz3cG5;
	Wed, 04 Mar 2026 18:49:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772610557;
	cv=none; b=ZzKlkDn7jJkqKWxbgnfpfk4tDQudUib1b2XazILkEn7/M0kMnDq85Z35aDrpK8dxqiDIEUjfFGfLr5rpoBbTpS8/cWtVG9s0Ns6dIIBnQq+4TQix+KTB+GzleDRa6faae8LZCwP/CZJVKttPdtcoGYclXz6HtZLjzp51HVVtc+sfO3xLj4pM9lTvpiHTIZ5fvof73lbwpd14cMkrznoGtkukiIokoMpNCKJFFmfCEMY3L7WO+xMOLtW+2vbV2BqpgY0RkHWf/agSBc9pJfkzCuJqM2vPuYeGyVjwFOTu9sPKaJ0eEe6OUcrUXfOk9UJYJStBVdm6jB2YpPjpoOrrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772610557; c=relaxed/relaxed;
	bh=Hnj7NK9+EESQajO58zJziHpx6y/buUwM86V1gnS791w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mN8FSnuJ9j8sQglD1YMV5xE8gnGLovAk9Um00mprY27YPaS4lMAe31+6gNHuHv8qbBVrk6cgrocOYqOzD2cnZRAdqcQxikudrrkx6X42nKrHsOz58F01U1SsIs7MX3q4+LKzAh+FNBkZQ0Z8+LPikD4m01OgMNAXzRQHDcvkjp0F0ZXGbsBvGJD7u9zhlcDf7jQDx7gSNyebVI1vT3LYGvJ9C5mC1yRwMcvHymFGoN+jkNfbsE2zC2ZVR0c11Ll76lrSMfJuoPLFRmiUxWD6gJk01EGvoeHeBREnQ9Jib1LZzaf7R1qHUO9LaY0So/PcOkQ5axOBtm4rJPrDm+mjjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ip/nm1Xq; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Jt07OPnU; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ip/nm1Xq;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Jt07OPnU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQlDY0Bf1z3cDg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 18:49:17 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772610553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hnj7NK9+EESQajO58zJziHpx6y/buUwM86V1gnS791w=;
	b=ip/nm1XqyI7wcCjokpOSiXYv2n4lYU7fwSpV26RLy9siZObCvemuLW2RP4YD1tdRMAI0S8
	m+pQAaNqdYQ+QygPxVgvdAGCXk+06s3gMrKpXuEh7+flyTwmqsyaD2gML2Ee/87aOwrZMe
	rkT21vqFiQ+eSMbBUCWSEJcvY2EtBXdR+uFvI30sCEhASj3CYKT6VwpRcNe2RjqfcoevWC
	6Gy7UfRjSV5D94MjpJ7b/NaJ4APifgGovw2Hepb7xHBR+mJW15Wwj9n+xidp4akBsLGnF/
	6KJn/Nt73SmPkpUD52uMOGRcrLgn4rC4amrE3fxiLeEM1pUuTjpdlB5wVP4oFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772610553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hnj7NK9+EESQajO58zJziHpx6y/buUwM86V1gnS791w=;
	b=Jt07OPnU+KT/z86+XHVkhIv4Yw0F2z4/1pj2e1Zuj+DMBO/23sXm5rdimCt979Ch6i0Lum
	FZuSOtNue8YM41Cw==
Date: Wed, 04 Mar 2026 08:49:02 +0100
Subject: [PATCH v6 05/14] sparc64: vdso: Remove obsolete "fake section
 table" reservation
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
Message-Id: <20260304-vdso-sparc64-generic-2-v6-5-d8eb3b0e1410@linutronix.de>
References: <20260304-vdso-sparc64-generic-2-v6-0-d8eb3b0e1410@linutronix.de>
In-Reply-To: <20260304-vdso-sparc64-generic-2-v6-0-d8eb3b0e1410@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>, 
 Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772610551; l=2603;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=oQUOtMJuNveW+RclD59fWViVXCPJwVTHt+8MLrC6gp0=;
 b=ONjGMauf8t71olRAN5ufRU1QPoFqmeZuj0jaVTXePVPM/+6cJ1aj+IcJKK9s9JN0YdCHpDCxu
 e00adRtTraRBTXyKxFnAHlW8bX79J2+hczfZ7oL9CPomYAMSfq5sEXH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When the vDSO logic was copied from x86 to SPARC some unused remnants of
the fake section handling were copied, too. In x86 the original fake
section handling had already been removed incompletely in commit
da861e18eccc ("x86, vdso: Get rid of the fake section mechanism").
On x86 the reservation was only cleaned up in commit 24b7c77bbb24
("x86/vdso: Remove obsolete "fake section table" reservation").

Remove the reservation for SPARC, too.

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/vdso/vdso-layout.lds.S | 21 ---------------------
 arch/sparc/vdso/vdso2c.c          |  8 --------
 2 files changed, 29 deletions(-)

diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.lds.S
index d31e57e8a3bb..9e0804789d11 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -4,16 +4,6 @@
  * This script controls its layout.
  */
 
-#if defined(BUILD_VDSO64)
-# define SHDR_SIZE 64
-#elif defined(BUILD_VDSO32)
-# define SHDR_SIZE 40
-#else
-# error unknown VDSO target
-#endif
-
-#define NUM_FAKE_SHDRS 7
-
 SECTIONS
 {
 	/*
@@ -47,19 +37,8 @@ SECTIONS
 		*(.bss*)
 		*(.dynbss*)
 		*(.gnu.linkonce.b.*)
-
-		/*
-		 * Ideally this would live in a C file: kept in here for
-		 * compatibility with x86-64.
-		 */
-		VDSO_FAKE_SECTION_TABLE_START = .;
-		. = . + NUM_FAKE_SHDRS * SHDR_SIZE;
-		VDSO_FAKE_SECTION_TABLE_END = .;
 	}						:text
 
-	.fake_shstrtab	: { *(.fake_shstrtab) }		:text
-
-
 	.note		: { *(.note.*) }		:text	:note
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index dc81240aab6f..b97af5ec9f35 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -61,8 +61,6 @@ const char *outfilename;
 /* Symbols that we need in vdso2c. */
 enum {
 	sym_vvar_start,
-	sym_VDSO_FAKE_SECTION_TABLE_START,
-	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
 
 struct vdso_sym {
@@ -72,12 +70,6 @@ struct vdso_sym {
 
 struct vdso_sym required_syms[] = {
 	[sym_vvar_start] = {"vvar_start", 1},
-	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
-		"VDSO_FAKE_SECTION_TABLE_START", 0
-	},
-	[sym_VDSO_FAKE_SECTION_TABLE_END] = {
-		"VDSO_FAKE_SECTION_TABLE_END", 0
-	},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))

-- 
2.53.0


