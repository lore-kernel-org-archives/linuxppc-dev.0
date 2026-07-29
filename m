Return-Path: <linuxppc-dev+bounces-25042-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DA6C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 20:58:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9PnJ1Sltz2yjw;
	Thu, 30 Jul 2026 06:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785358708;
	cv=none; b=YzPwMpgiNOaKTu6Du4w2WWr+5WIRfocEH9+5/lftzG3G0Zy755JgSPJ6IftuJqjS5b7i+bInxJ4jeemBiHe0lsNojqVAcDA0AWICXTjhyeoN2cBKUQhx+jAZUQ3KyZ8RZy2SXvOGLCohIvabbstXVzgqR+wDJJ7RS3mxxVxcsCFvb+h5KqZfEhkQJy6voMho11hiXIyv+GNNgdOTrZKIVQoAhj/u46yLvUpoYae1/iy7t3hFrSFcCXZ7pziVsL58C2Ck9oy7MhegXErRag8CdGysHJvDQl2gQjl+jQ05KrVXBSowpOezHIz1/2X7jPxZ69652Yin6/4IdMaFRrMZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785358708; c=relaxed/relaxed;
	bh=s3Qt2yUiPmkw2c1ehV+2BIGV3QCB1XwX3v/X3w/CcvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRaN/8HymswP2dcrMb5EUaR2IsFiWnzso1tDgXYa9BbkkgFKmXJaUBiwNcHYt1nzvTzYMVaen7OfoyLI9nNU0Z8Njp7O7M9u6ipA989zGplxnfatCqaXmO6FAgYGMLRsJfzFLHjcseT40ECGI22csatyKJKpKctnausonkFiMjK1vtpF1MkSWegSLqy4GDLFeakMutsi9I5wNSz7dLZyKY4BBJPBw0oxbYfOMLQ946EeF/2/bcO//ggSUXKksFO4GkO35/+pmu4Y8FNQFd7SP3YhbJyoEvJfEUYmailRYvQvyp7G1yWxRjtVE6cpLDe4exFwnbP1lfA0ONFYQmYGwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9PnG5pB0z2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 06:58:26 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 8ADA770932E9; Wed, 29 Jul 2026 22:50:03 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH 2/2] =?UTF-8?q?powerpc/sstep:=20Don=E2=80=99t=20define=20v?= =?UTF-8?q?ariables=20we=20won=E2=80=99t=20be=20using?=
Date: Wed, 29 Jul 2026 22:49:56 +0200
Message-ID: <20260729204958.755143-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729204958.755143-1-linkmauve@linkmauve.fr>
References: <20260729204958.755143-1-linkmauve@linkmauve.fr>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It seems this function has only compiled without warnings on PPC64, not
on PowerPC, so before this commit it would fail with:
```
../arch/powerpc/lib/sstep.c: In function 'analyse_instr':
../arch/powerpc/lib/sstep.c:1350:28: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
 1350 |         unsigned int word, suffix;
      |                            ^~~~~~
../arch/powerpc/lib/sstep.c:1346:38: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
 1346 |         unsigned int opcode, ra, rb, rc, rd, spr, u;
      |                                      ^~
cc1: all warnings being treated as errors
```

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 arch/powerpc/lib/sstep.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 597a0d841fe8..c866e4337f94 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1342,16 +1342,20 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 {
 #ifdef __powerpc64__
 	unsigned int suffixopcode, prefixtype, prefix_r;
+	unsigned int rc;
+	unsigned int suffix;
 #endif
-	unsigned int opcode, ra, rb, rc, rd, spr, u;
+	unsigned int opcode, ra, rb, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
-	unsigned int word, suffix;
+	unsigned int word;
 	long ival;
 
 	word = ppc_inst_val(instr);
+#ifdef __powerpc64__
 	suffix = ppc_inst_suffix(instr);
+#endif
 
 	op->type = COMPUTE;
 
@@ -1469,7 +1473,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (word >> 21) & 0x1f;
 	ra = (word >> 16) & 0x1f;
 	rb = (word >> 11) & 0x1f;
+#ifdef __powerpc64__
 	rc = (word >> 6) & 0x1f;
+#endif
 
 	switch (opcode) {
 #ifdef __powerpc64__
-- 
2.55.0


