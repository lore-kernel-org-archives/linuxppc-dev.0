Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B0C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Sep 2021 09:23:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0B96113A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Sep 2021 09:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE0B96113A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HBQNW1zJGz308C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Sep 2021 19:23:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HBQN13NH2z2xXV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Sep 2021 19:22:56 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HBQMw75JKz9sTp;
 Sat, 18 Sep 2021 11:22:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDXvAXDFgcxi; Sat, 18 Sep 2021 11:22:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HBQMw655Qz9sTK;
 Sat, 18 Sep 2021 11:22:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BBC698B768;
 Sat, 18 Sep 2021 11:22:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id i9VziOO7HdnQ; Sat, 18 Sep 2021 11:22:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.70])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 734A48B764;
 Sat, 18 Sep 2021 11:22:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18I9MgmB785790
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 18 Sep 2021 11:22:42 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18I9Mclb785789;
 Sat, 18 Sep 2021 11:22:38 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/476: Fix sparse report
Date: Sat, 18 Sep 2021 11:22:32 +0200
Message-Id: <aa6055769b92a5d8685b8d0adab99c48a0b0ef4b.1631956926.git.christophe.leroy@csgroup.eu>
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
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

	arch/powerpc/platforms/44x/ppc476.c:236:17: warning: cast removes address space '__iomem' of expression
	arch/powerpc/platforms/44x/ppc476.c:241:34: warning: incorrect type in argument 1 (different address spaces)
	arch/powerpc/platforms/44x/ppc476.c:241:34:    expected void const volatile [noderef] __iomem *addr
	arch/powerpc/platforms/44x/ppc476.c:241:34:    got unsigned char [usertype] *
	arch/powerpc/platforms/44x/ppc476.c:243:17: warning: incorrect type in argument 1 (different address spaces)
	arch/powerpc/platforms/44x/ppc476.c:243:17:    expected void volatile [noderef] __iomem *addr
	arch/powerpc/platforms/44x/ppc476.c:243:17:    got unsigned char [usertype] *[assigned] fpga

Mark 'fpga' pointer as __iomem.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: ab9a4183fddf ("powerpc: Update currituck pci/usb fixup for new board revision")
Cc: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/44x/ppc476.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index 07f7e3ce67b5..fb7db5cedd4e 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -219,7 +219,7 @@ static int board_rev = -1;
 static int __init ppc47x_get_board_rev(void)
 {
 	int reg;
-	u8 *fpga;
+	u8 __iomem *fpga;
 	struct device_node *np = NULL;
 
 	if (of_machine_is_compatible("ibm,currituck")) {
@@ -233,7 +233,7 @@ static int __init ppc47x_get_board_rev(void)
 	if (!np)
 		goto fail;
 
-	fpga = (u8 *) of_iomap(np, 0);
+	fpga = of_iomap(np, 0);
 	of_node_put(np);
 	if (!fpga)
 		goto fail;
-- 
2.31.1

