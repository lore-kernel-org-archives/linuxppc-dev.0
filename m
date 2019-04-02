Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151CC10F00
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 09:17:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27912084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 09:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="P2x5Ph6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27912084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YNrV25P9zDqMX
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="P2x5Ph6h"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YNfy5vP5zDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 20:08:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44YNft2vhPz9v0Zk;
 Tue,  2 Apr 2019 11:08:38 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=P2x5Ph6h; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ftmQvr-74cau; Tue,  2 Apr 2019 11:08:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44YNft1nrKz9v0ZY;
 Tue,  2 Apr 2019 11:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554196118; bh=f1NH52KDwlxCG2X+m7ZotoQ0rAUSw3Nc7DpOwVnBcDE=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=P2x5Ph6hsQfVJeO40Sp7IPTppt6gpv4IlX4jkKLV/FhlFGnrAAS/OnNDPMKQJcHQL
 wrG91/FyIz7VObrYYMia6eNGfn4KFUNDMFmwdQOadwWFMrJHVHelRWdNv2rKtB/cWp
 E7ocRdFTz3n/qTJlMO9eZUybjmcYLBRicFJYdJXY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C0B18B8C4;
 Tue,  2 Apr 2019 11:08:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id puBK2H34Ay-R; Tue,  2 Apr 2019 11:08:39 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B3898B8C3;
 Tue,  2 Apr 2019 11:08:39 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id E7047661D9; Tue,  2 Apr 2019 09:08:38 +0000 (UTC)
Message-Id: <5ad9ed13155f55e1715274561354aa7ab57973fc.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/9] powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 danielwa@cisco.com
Date: Tue,  2 Apr 2019 09:08:38 +0000 (UTC)
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
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PROM_SCRATCH_SIZE is same as sizeof(prom_scratch)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/prom_init.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a6cd52240c58..d4889ba04ddd 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -154,10 +154,8 @@ static struct prom_t __prombss prom;
 
 static unsigned long __prombss prom_entry;
 
-#define PROM_SCRATCH_SIZE 256
-
 static char __prombss of_stdout_device[256];
-static char __prombss prom_scratch[PROM_SCRATCH_SIZE];
+static char __prombss prom_scratch[256];
 
 static unsigned long __prombss dt_header_start;
 static unsigned long __prombss dt_struct_start, dt_struct_end;
@@ -1486,8 +1484,8 @@ static void __init prom_init_mem(void)
 		endp = p + (plen / sizeof(cell_t));
 
 #ifdef DEBUG_PROM
-		memset(path, 0, PROM_SCRATCH_SIZE);
-		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
+		memset(path, 0, sizeof(prom_scratch));
+		call_prom("package-to-path", 3, 1, node, path, sizeof(prom_scratch) - 1);
 		prom_debug("  node %s :\n", path);
 #endif /* DEBUG_PROM */
 
@@ -1795,10 +1793,10 @@ static void __init prom_initialize_tce_table(void)
 			local_alloc_bottom = base;
 
 		/* It seems OF doesn't null-terminate the path :-( */
-		memset(path, 0, PROM_SCRATCH_SIZE);
+		memset(path, 0, sizeof(prom_scratch));
 		/* Call OF to setup the TCE hardware */
 		if (call_prom("package-to-path", 3, 1, node,
-			      path, PROM_SCRATCH_SIZE-1) == PROM_ERROR) {
+			      path, sizeof(prom_scratch) - 1) == PROM_ERROR) {
 			prom_printf("package-to-path failed\n");
 		}
 
@@ -2159,14 +2157,14 @@ static void __init prom_check_displays(void)
 
 		/* It seems OF doesn't null-terminate the path :-( */
 		path = prom_scratch;
-		memset(path, 0, PROM_SCRATCH_SIZE);
+		memset(path, 0, sizeof(prom_scratch));
 
 		/*
 		 * leave some room at the end of the path for appending extra
 		 * arguments
 		 */
 		if (call_prom("package-to-path", 3, 1, node, path,
-			      PROM_SCRATCH_SIZE-10) == PROM_ERROR)
+			      sizeof(prom_scratch) - 10) == PROM_ERROR)
 			continue;
 		prom_printf("found display   : %s, opening... ", path);
 		
@@ -2362,8 +2360,8 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 
 	/* get it again for debugging */
 	path = prom_scratch;
-	memset(path, 0, PROM_SCRATCH_SIZE);
-	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
+	memset(path, 0, sizeof(prom_scratch));
+	call_prom("package-to-path", 3, 1, node, path, sizeof(prom_scratch) - 1);
 
 	/* get and store all properties */
 	prev_name = "";
-- 
2.13.3

