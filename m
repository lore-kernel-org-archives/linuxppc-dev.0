Return-Path: <SRS0=vMbJ=5Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333AEC2BA2B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 02:01:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFFD2084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 02:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pM3IoEWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFFD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48yPWc6FMgzDqp7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 12:01:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pM3IoEWX; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48yPTN49BXzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2020 11:59:19 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id g2so3262771plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2020 18:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=pHHeO3C2EEknzZuTDSUmQQTL7mKzoEOghQeiMw8EiaE=;
 b=pM3IoEWXLXsOHp/DesUtxf+KuLOnVMI4Ah/oVvgVKIO5mOzEOGGNmtwoDqsWN2k/NS
 lseLuGfhdcMuDljiCO2R29LVBcM6w5GDNv/z/fWZr4892g+SiPpUtiHMPiQDheCuSdCt
 O3Nf1dk97doUAxbq073A6IcwVk5/MjwAloArdM7+adDr5sg+q8tINy/lR33yGxZyag+R
 Fe1WNciLDInkSlUqVBkh+/YXvgwK+xsXGCjg7IUzSQIFJ7yVG7d/0GuFJXkef6q6fh+n
 ztsQwOXeZmttWARtDyMi29lfEIH1bKxJMv1mR4kDcmUnpsR6djbkrQ3/Ymz3oEIDyLx+
 x13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pHHeO3C2EEknzZuTDSUmQQTL7mKzoEOghQeiMw8EiaE=;
 b=l03JtC9snSNei9poEBazC8gepCQvREVBMfC+vSgMvbNh5rkiSYziQ8zZoKsgfEsO3Q
 nZv4aXts1+Tj4AG2ZN1u5VHF8hs7GiIsjEGOv75zkyQrF3NC6P86KTjQHu7hj1hW0ld0
 RQWUvypEg931bSJhOZBQTgfzk7VHqTV3MiXx2UvaLNdOA2EkoIgW/+zupWSV4hLfEwyf
 0ErXmJ6rowvw/H2YNt0zxQ/aoB/8zRL9/a3t/m7sL7pEpbpcQslr1MDtqEIijwaK32wg
 S0LiUyLpTmPo6Z4erp5Esbju0J3vNvOCyad6Cx4ik3E0Pvp+9x/GXL1bSM2FzYjISu8u
 3j9A==
X-Gm-Message-State: AGi0PuYjDMTeLd7eeHKph/Mh/M7bHR7Z+kMOVnE9EWYTYKuujR8oWy6P
 VKJC78hJj83fSd+4fhkj4vLjnVJA6A==
X-Google-Smtp-Source: APiQypKcLikeRBtEMrcQWrlbgFG9m7hN4PXtQ0JDaRdlKyy55/Gez/Y1AaPlsXgigthtA9eVbGFEbA==
X-Received: by 2002:a17:902:bd4c:: with SMTP id
 b12mr10238556plx.41.1586397556260; 
 Wed, 08 Apr 2020 18:59:16 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w27sm17822530pfq.211.2020.04.08.18.59.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Apr 2020 18:59:15 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 1/2] powerpc/pseries: group lmb operation and memblock's
Date: Thu,  9 Apr 2020 09:56:50 +0800
Message-Id: <1586397411-24259-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
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
Cc: Libor Pechacek <lpechacek@suse.cz>, Pingfan Liu <kernelfans@gmail.com>,
 kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch prepares for the incoming patch which swaps the order of KOBJ_
uevent and dt's updating.

It has no functional effect, just groups lmb operation and memblock's in
order to insert dt updating operation easily, and makes it easier to
review.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Libor Pechacek <lpechacek@suse.cz>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 26 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b2cde17..4bd9004 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -377,7 +377,8 @@ static int dlpar_add_lmb(struct drmem_lmb *);
 static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 {
 	unsigned long block_sz;
-	int rc;
+	phys_addr_t base_addr;
+	int rc, nid;
 
 	if (!lmb_is_removable(lmb))
 		return -EINVAL;
@@ -386,17 +387,19 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 	if (rc)
 		return rc;
 
+	base_addr = lmb->base_addr;
+	nid = lmb->nid;
 	block_sz = pseries_memory_block_size();
 
-	__remove_memory(lmb->nid, lmb->base_addr, block_sz);
-
-	/* Update memory regions for memory remove */
-	memblock_remove(lmb->base_addr, block_sz);
-
 	invalidate_lmb_associativity_index(lmb);
 	lmb_clear_nid(lmb);
 	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
 
+	__remove_memory(nid, base_addr, block_sz);
+
+	/* Update memory regions for memory remove */
+	memblock_remove(base_addr, block_sz);
+
 	return 0;
 }
 
@@ -663,6 +666,8 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 	}
 
 	lmb_set_nid(lmb);
+	lmb->flags |= DRCONF_MEM_ASSIGNED;
+
 	block_sz = memory_block_size_bytes();
 
 	/* Add the memory */
@@ -674,11 +679,14 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 
 	rc = dlpar_online_lmb(lmb);
 	if (rc) {
-		__remove_memory(lmb->nid, lmb->base_addr, block_sz);
+		int nid = lmb->nid;
+		phys_addr_t base_addr = lmb->base_addr;
+
 		invalidate_lmb_associativity_index(lmb);
 		lmb_clear_nid(lmb);
-	} else {
-		lmb->flags |= DRCONF_MEM_ASSIGNED;
+		lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+
+		__remove_memory(nid, base_addr, block_sz);
 	}
 
 	return rc;
-- 
2.7.5

