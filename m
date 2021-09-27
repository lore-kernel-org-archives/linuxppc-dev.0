Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D35C433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Sep 2021 15:13:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0268D61058
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Sep 2021 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0268D61058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJ5kF3Pm3z2yWG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 01:13:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJ5jm2h5dz2xsm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2021 01:12:58 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HJ5jg2nltz9sXx;
 Mon, 27 Sep 2021 17:12:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xJnomytv_UBi; Mon, 27 Sep 2021 17:12:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HJ5jg1sp6z9sXp;
 Mon, 27 Sep 2021 17:12:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CB358B76E;
 Mon, 27 Sep 2021 17:12:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KIprEdTxWZXS; Mon, 27 Sep 2021 17:12:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 149EB8B763;
 Mon, 27 Sep 2021 17:12:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18RFCfR01436371
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Sep 2021 17:12:42 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18RFCfeD1436370;
 Mon, 27 Sep 2021 17:12:41 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/40x: Map 32Mbytes of memory at startup
Date: Mon, 27 Sep 2021 17:12:39 +0200
Message-Id: <89b5f974a7fa5011206682cd092e2c905530ff46.1632755552.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
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
Cc: cp <carlojpisani@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As reported by Carlo, 16Mbytes is not enough with modern kernels
that tend to be a bit big, so map another 16M page at boot.

Cc: cp <carlojpisani@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Add missing header and missing @h
---
 arch/powerpc/kernel/head_40x.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 7d72ee5ab387..e783860bea83 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -27,6 +27,7 @@
 
 #include <linux/init.h>
 #include <linux/pgtable.h>
+#include <linux/sizes.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -650,7 +651,7 @@ start_here:
 	b	.		/* prevent prefetch past rfi */
 
 /* Set up the initial MMU state so we can do the first level of
- * kernel initialization.  This maps the first 16 MBytes of memory 1:1
+ * kernel initialization.  This maps the first 32 MBytes of memory 1:1
  * virtual to physical and more importantly sets the cache mode.
  */
 initial_mmu:
@@ -687,6 +688,12 @@ initial_mmu:
 	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
 	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
 
+	li	r0,62			/* TLB slot 62 */
+	addis	r4,r4,SZ_16M@h
+	addis	r3,r3,SZ_16M@h
+	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
+	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
+
 	isync
 
 	/* Establish the exception vector base
-- 
2.31.1

