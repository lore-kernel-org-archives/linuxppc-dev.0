Return-Path: <linuxppc-dev+bounces-17537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89294EA4E08
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 14:10:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPgnf0tTcz2xc8;
	Tue, 03 Mar 2026 01:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0c:5a00:149::25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772460646;
	cv=none; b=fDBAK2JvoAWQ455Gi8eGScnL6l5hC5Vn8oLnjVUIX1hShcQSLvb8R6pppsXthdvm6zCfYQ8eVtHGc6hwyRN5PQuhkPhMR2BNlEdrfcAvRcaxk4om2WgiknUi4XU00uGee+bI1KfNl5KXmosixIEp7ASGyNfIY6+MvLPywnYqS0NVLKVhO8JQTXJlB73TtriwrS6HNHICpmER82RBeG38gewzx3KQNHakcVu04qiBZMIx1EQi4xdj2zbwgT9FFgiVZB9g/WIOmITIrmEsFuxbS5himjkWSvHLO4Y1LgarlI+Mnxlq1fqyr/148L/a9lMdtgGj1jqaSRzoMYCuDlkJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772460646; c=relaxed/relaxed;
	bh=D3P/KaCqbTVRLW734Le3jm//dWEzoj6aOdRHjsDkHB0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tpb2AFxC0RjugHUYe9B77xVE1u5JIPe1RpylYbZjUv45yxu40+JmvYpqvyHF57HTSwEchi/ILzB+uhA81mNdp+KomPWHPsJf3eeV6B+cKQtMExvea1rNfVmP0F59pFo98EqJbqrQLbpaEtObGLKhE59C7T/sRVYAcCu1GVAXjzAxjrqHNVqJQeKnm2waaxVIV8mowDgcSewf/9FWtwI/ZzkaWenuF4U8K4CO1shivUCV6pzUWNE7Gm3NF/jkiQRWZ5JtKLajfUWwwKUMoyUNXlh9M7dRBLyjB3Lkl6ezL2Fkp0NhRvStlRkZX/DAkVbVEUIwwfWpdNkeZc0CzMRFWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector2 header.b=dr2IYEGX; dkim-atps=neutral; spf=pass (client-ip=2a0c:5a00:149::25; helo=mailtransmit04.runbox.com; envelope-from=david.laight.linux_spam@runbox.com; receiver=lists.ozlabs.org) smtp.mailfrom=runbox.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector2 header.b=dr2IYEGX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=runbox.com (client-ip=2a0c:5a00:149::25; helo=mailtransmit04.runbox.com; envelope-from=david.laight.linux_spam@runbox.com; receiver=lists.ozlabs.org)
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPgnc3hfRz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 01:10:44 +1100 (AEDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jv-003ZDi-SM; Mon, 02 Mar 2026 14:28:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=D3P/KaCqbTVRLW734Le3jm//dWEzoj6aOdRHjsDkHB0=; b=dr2IYEGXpLn70YtwZCSevHlElv
	/BDRdlUO4zDGofnTsHi42LvbEdi3VipTLE3qO2jms6/GGfUGILr2ElGxq76Qqa1IVjSRbEvOAc1Ro
	pNaEyMGT7NC4B24epdTZtJNVCwBM3fXGAKN7d+4ezQMOiK4oex69VUMtEUOAjx+EPd5g+ct38316h
	qxQXAxcAiiKRb6oyp9RzKKLymdA7Gx+8gSGQAGBZIzLD4BxE+G55Ccnmk/qMfgl9N6JGa4es8sujn
	nzOnVNpMKlbluysxX5nsv82z0JQ/qI/Tt/bJCX331CVLx9DxsrepkWNzyJUPNhYsRNbEfHp1c25Sv
	5z427ECQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jv-0001hG-7S; Mon, 02 Mar 2026 14:28:23 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jh-008UTR-Jt; Mon, 02 Mar 2026 14:28:09 +0100
From: david.laight.linux@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org
Subject: [PATCH v2 2/5] compiler.h: Add generic support for 'autoterminating nested for() loops'
Date: Mon,  2 Mar 2026 13:27:52 +0000
Message-Id: <20260302132755.1475451-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302132755.1475451-1-david.laight.linux@gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Autoterminating nested for() loops can be used inside #defines to
declare variables that are scoped to the statement that follows.
These are used by __scoped_user_access() but may have other uses
and the gory details are best separated from the use.

Using 'with (declaration)' and 'and_with (declaration)' seems to
read reasonably well and doesn't seem to collide with any existing
code.

As an example the scoped user access definition becomes:
	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)) \
		/* Force modified pointer usage within the scope */		\
		and_with (const auto uptr __cleanup(...) = _tmpptr)

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/compiler.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index af16624b29fd..1098a91b5591 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -369,6 +369,32 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+/*
+ * Sometimes a #define needs to declare a variable that is scoped
+ * to the statement that follows without having mismatched {}.
+ *	with (int x = expression) {
+ *		statements
+ *	}
+ * is the same as:
+ *	{
+ *		int x = expression;
+ *		statements
+ *	}
+ * but lets it all be hidden from the call site, eg:
+ *	frobnicate(x, args) {
+ *		statements
+ *	} 
+ * Only a single variable can be defined, and_with() allows extra ones
+ * without adding an additional outer loop.
+ *
+ * The controlled scope can be terminated using return, break, continue or goto.
+ */
+#define with(declaration) \
+	for (bool _with_done = false; !_with_done; _with_done = true)	\
+		and_with (declaration)
+#define and_with(declaration) \
+	for (declaration; !_with_done; _with_done = true)
+
 #include <asm/rwonce.h>
 
 #endif /* __LINUX_COMPILER_H */
-- 
2.39.5


