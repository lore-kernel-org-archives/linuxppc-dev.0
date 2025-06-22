Return-Path: <linuxppc-dev+bounces-9609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFD8C7115C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Jun 2025 10:20:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bQ6fs2JG4z30TY;
	Sun, 22 Jun 2025 20:20:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.236.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750587637;
	cv=none; b=K0fu/cXMfdynuRu03gU/8SVdHYOI5XxcpYdgyWsY+YEZas08JbTQrIc9U5NuZbvXnsPpnVngFWWMfMYBbCtuJsnzaBrSzy/cKuKooMHvS2sfF6v2TQd4DUOIfFBTSN/PD+F4I3BMEbXP8Pv/vsdPS8Y3O/1U+nZkZk2IQXf2foE23+FVU4LfoLsemxF7SW1ThOmZsDZSDtMuM9J/4mOiZIvGDGngcyglrpJH79eUFi52dSsdmzDfJiDxwqcU6a7FrFFkgDhgsqXqBg3X6WSrFXKsMs4Ci+FewE0u3KoRSQKT80tT8DTetw2bHS8NXiWxgOwuc8pYzmAkrRCp4i9rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750587637; c=relaxed/relaxed;
	bh=dsSLcFcY8EBQzJto4Z1EfPen5dqTb2XkbMRFiem70/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjT+xmstoBv0up9OzYPxwYxLErVuWhGrFEis6c51MEcTpXGM3tJZWIyknjHHU7Tw/WCbPpYEskE7YeTekVQjdXgbcAtlHXM4IUgVCtR6fUZ7PZyxSnhQNjFbBMk9uh/CrTzBR/K+I17ABXRv4ymtd9ipJi9d+bWL8inntIf5XQ1rKBSVLBe9ijdsw4NZthvtTsItP2DGYOzTiGcWd/Tpa37BMhijoSHJ253F1+Pqk3VAXVGvTw+TRTcsD6togbicU58RFzMA+3AS53Xzjof3Or8pNljqJDS3Czrpvz5l674imFL6NYmCzQy2ZnAkO9e48l+PaIKWjc77l2spI0y0WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bQ6fr4Q52z2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jun 2025 20:20:35 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bQ62q2tJCz9sbF;
	Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OYHyRMeMBap9; Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bQ62q20ksz9sXD;
	Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CD248B764;
	Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ItRVmE4jH7_E; Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E5C18B763;
	Sun, 22 Jun 2025 11:52:50 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] uaccess: Add speculation barrier to copy_from_user_iter()
Date: Sun, 22 Jun 2025 11:52:40 +0200
Message-ID: <f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750585958; l=1183; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=UYxQJS6ZJHCmE3zbSwM0x0YAEUS01DTZiXJZEvopO2E=; b=CZDMdcFmnufRcPRhMzoZv84scqPZFsLBFe6GrnY1YvrDPqC/h/DYWJVikSKeIb35hKqIXPgrn /bJG+wBOUX6CLrIA00TjhTQhNdgXy5elmLQw6y5gHEPFOZkqvKJl1vx
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The results of "access_ok()" can be mis-speculated.  The result is that
you can end speculatively:

	if (access_ok(from, size))
		// Right here

For the same reason as done in copy_from_user() by
commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
copy_from_user()"), add a speculation barrier to copy_from_user_iter().

See commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
copy_from_user()") for more details.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/iov_iter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f49..ebf524a37907 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -50,6 +50,13 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 	if (should_fail_usercopy())
 		return len;
 	if (access_ok(iter_from, len)) {
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
+
 		to += progress;
 		instrument_copy_from_user_before(to, iter_from, len);
 		res = raw_copy_from_user(to, iter_from, len);
-- 
2.49.0


