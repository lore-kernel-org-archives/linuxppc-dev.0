Return-Path: <linuxppc-dev+bounces-25076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB5FC54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:50:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fwD0kqpz2ynC;
	Thu, 30 Jul 2026 16:50:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785394220;
	cv=none; b=kt4/E9prwa+V9SdRuBE+QkvFAkwUwFl5zxyZ+/2dIkV4SLJFyonwaF7hGOLJjlD5Xq8IxbMI92D7LSVP+Ti2Nl5bkVK9GDhpuh+J1yX++UllMoKU4o5RUfsOikRH3DYhCRc09tWJdt+u8ctFHIMiCcqq1aYN4tmPtqLhbQJgWxx0Q+DlGnlnINe2MiD8MEdVTCfU4oD1U2E5Sm9CoYNPqg/bmSfFtAbjr2dOaPh0tMUZNXeyrGYmJ+VLIfIs2RNBednG3vgjDtOkB7t7jZgSKZNA16bqsekYhsjz03hyfpqRGhQvj2jjd0JBnQnunEZcx3VFf1DlIbtBhKGcWEGrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785394220; c=relaxed/relaxed;
	bh=xyb4CY9N2nHF288ZKaVoRUr1PANrq+3OEvoYhf2d0nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHmjcwo0w7g5NSGAgyQN2/QfA9vCIUJDN/bbygXwiHYySYAwMd8tFDKSTV6NTzCIyXXbUPcwrK/H9tsOaT8S6WGZ0TsIv+y3GT5GVqHLviYMT2TYDN1+SJh/mP8YBML8PVxLFi9riqcPhEeZT94l/dN8oTFMVXf0JtOXxDQ6ahkL/Wh72mJyyC4bb75LZyeIinN9x3j9ZjLO58cu6r76kwr45AwbccZZ3j6GKuKS7278SezZTBoGjSQzgf9zid78XyP3mFCwgcXzfoPM2x4T4GUkb8cKN5mcl/7F98xbR8LUP8J++HDVTfGrwDh/6kd7FypKnbX3sVKTobe8O5lavw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fwC0ZRfz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:50:18 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 03AB57099370; Thu, 30 Jul 2026 08:50:16 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: Christophe Leroy <chleroy@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] =?UTF-8?q?powerpc/sstep:=20Don=E2=80=99t=20define?= =?UTF-8?q?=20variables=20we=20won=E2=80=99t=20be=20using?=
Date: Thu, 30 Jul 2026 08:50:06 +0200
Message-ID: <20260730065007.964703-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730065007.964703-1-linkmauve@linkmauve.fr>
References: <20260730065007.964703-1-linkmauve@linkmauve.fr>
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

When compiling with W=1 on 32-bit PowerPC, -Wunused-but-set-variable was
set, and alongside -Werror caused the build to fail with this error:
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
 arch/powerpc/lib/sstep.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index fd57b748cd2b..d49b2ef5d763 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1342,16 +1342,19 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 {
 #ifdef CONFIG_PPC64
 	unsigned int suffixopcode, prefixtype, prefix_r;
+	unsigned int rc, suffix;
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
+#ifdef CONFIG_PPC64
 	suffix = ppc_inst_suffix(instr);
+#endif
 
 	op->type = COMPUTE;
 
@@ -1469,7 +1472,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (word >> 21) & 0x1f;
 	ra = (word >> 16) & 0x1f;
 	rb = (word >> 11) & 0x1f;
+#ifdef CONFIG_PPC64
 	rc = (word >> 6) & 0x1f;
+#endif
 
 	switch (opcode) {
 #ifdef CONFIG_PPC64
-- 
2.55.0


