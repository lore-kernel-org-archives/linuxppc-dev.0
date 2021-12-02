Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEC9C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Dec 2021 12:02:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4ZMS686Mz3djC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Dec 2021 23:02:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4ZKj4cqbz3c5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Dec 2021 23:00:57 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4J4ZKP17H8z9sSM;
 Thu,  2 Dec 2021 13:00:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yqGuCkCgJx3c; Thu,  2 Dec 2021 13:00:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4J4ZKL6dNzz9sSf;
 Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D42778B7BB;
 Thu,  2 Dec 2021 13:00:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dBMsSNlTptcz; Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.163])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 537DB8B7CA;
 Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1B2C0WLX177261
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 2 Dec 2021 13:00:32 +0100
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1B2C0WoU177260;
 Thu, 2 Dec 2021 13:00:32 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v1 06/11] powerpc/code-patching: Fix patch_branch() return on
 out-of-range failure
Date: Thu,  2 Dec 2021 13:00:22 +0100
Message-Id: <8540cb64b1f06710eaf41e3835c7ba3e21fa2b05.1638446239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
References: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638446425; l=751; s=20211009;
 h=from:subject:message-id; bh=/zfKL65k3KITgblezhVW3gnjds50a2eaegBNYovWWCA=;
 b=gdS+G5709O4oCAmv3K8O0B0lFt4bz66LN61fcOu/Qc24xqVGj9mR9ND3GHz7H4qcIByXrkkfwpZS
 ihgx3onIDxu5kv9y2jHRnRtWEhYfiwcuHghGcS3soRvq7RvgXxys
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Do not silentely ignore a failure of create_branch() in
patch_branch(). Return -ERANGE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index a43ca22313ee..e7a2a41ae8eb 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -191,7 +191,9 @@ int patch_branch(u32 *addr, unsigned long target, int flags)
 {
 	ppc_inst_t instr;
 
-	create_branch(&instr, addr, target, flags);
+	if (create_branch(&instr, addr, target, flags))
+		return -ERANGE;
+
 	return patch_instruction(addr, instr);
 }
 
-- 
2.33.1

