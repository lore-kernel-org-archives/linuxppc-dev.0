Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286AC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF71206DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF71206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dDxj73w9zDqQd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:34:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dDvt4bpjzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:32:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43dDvt3CqZz9s9h; Mon, 14 Jan 2019 11:32:58 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43dDvt2nlWz9sD4; Mon, 14 Jan 2019 11:32:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/4xx/ocm: Fix fix for phys_addr_t printf warnings
Date: Mon, 14 Jan 2019 11:32:55 +1100
Message-Id: <20190114003255.22005-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: chunkeey@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

My recent commit to fix the printf warnings in ocm.c got the format
specifier wrong, because I copied it from the documentation without
realising the square brackets are not meant as literals.

This results in the address being suffixed with a literal "[p]".

Actually tested this time:

  # cat info /sys/kernel/debug/ppc4xx_ocm
  PhysAddr     : 0x0000000400040000
  ...
  NC.PhysAddr  : 0x0000000400040000
  ...
  C.PhysAddr   : 0x0000000000000000

Fixes: 52b88fa1e8c7 ("powerpc/4xx/ocm: Fix phys_addr_t printf warnings")
Reported-by: Christian Lamparter <chunkeey@gmail.com>
Tested-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/4xx/ocm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index a1aaa1569d7c..f0e488d97567 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -237,12 +237,12 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
 			continue;
 
 		seq_printf(m, "PPC4XX OCM   : %d\n", ocm->index);
-		seq_printf(m, "PhysAddr     : %pa[p]\n", &(ocm->phys));
+		seq_printf(m, "PhysAddr     : %pa\n", &(ocm->phys));
 		seq_printf(m, "MemTotal     : %d Bytes\n", ocm->memtotal);
 		seq_printf(m, "MemTotal(NC) : %d Bytes\n", ocm->nc.memtotal);
 		seq_printf(m, "MemTotal(C)  : %d Bytes\n\n", ocm->c.memtotal);
 
-		seq_printf(m, "NC.PhysAddr  : %pa[p]\n", &(ocm->nc.phys));
+		seq_printf(m, "NC.PhysAddr  : %pa\n", &(ocm->nc.phys));
 		seq_printf(m, "NC.VirtAddr  : 0x%p\n", ocm->nc.virt);
 		seq_printf(m, "NC.MemTotal  : %d Bytes\n", ocm->nc.memtotal);
 		seq_printf(m, "NC.MemFree   : %d Bytes\n", ocm->nc.memfree);
@@ -252,7 +252,7 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
 							blk->size, blk->owner);
 		}
 
-		seq_printf(m, "\nC.PhysAddr   : %pa[p]\n", &(ocm->c.phys));
+		seq_printf(m, "\nC.PhysAddr   : %pa\n", &(ocm->c.phys));
 		seq_printf(m, "C.VirtAddr   : 0x%p\n", ocm->c.virt);
 		seq_printf(m, "C.MemTotal   : %d Bytes\n", ocm->c.memtotal);
 		seq_printf(m, "C.MemFree    : %d Bytes\n", ocm->c.memfree);
-- 
2.20.1

