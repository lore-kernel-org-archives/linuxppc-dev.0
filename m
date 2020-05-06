Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3193C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:12:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F31720757
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy4pwgcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F31720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49H38f4KPDzDqyf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 14:12:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Qy4pwgcn; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49H2ZB6RKmzDqTK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 13:46:10 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id f15so2884plr.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2020 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=I8r3rh8yGT5ITz5RvW4M38n2GxW9bveAn6a518ltq34=;
 b=Qy4pwgcnSycgno1eoF0Nm8rAg7LIrLoVmE7gcSenyW2aIXcY+yGST4YK8QpKfP/j7F
 Es9r2Iypo4xmi+vO2OnxV5b42v1cuTE1nW5vOrix7fpNWC0KeUEGilpZO7FaTY0QHhro
 V2O6h5c7fOtoOVoh+aox7Y4OZPoxuqGnlZS2EZmmX67kCECcbBH4Jzt5HFeVJpjF9QzR
 54JnUwxXZYAlMrC2vO1SGSTXwMkpiiH/58fTBE5g1UkqLj1bT/8dlKr2O1SB9kV4JlOI
 RmRiP7gmP8KxH0oN54FuCMOCau0PJGwqnfLjDZbnHgCInYTiGAFSBB+gawDRKN8xaX/w
 YR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=I8r3rh8yGT5ITz5RvW4M38n2GxW9bveAn6a518ltq34=;
 b=C05e/qYNdXII6g/KRcLd1ic9xuDLxSy63HOUGwOuzUfd7++nByCRYKVu5O/eIILEqK
 XOha97St4W9n1UT/0CkFG+3ZeET4sDEXIBHwe9IPjbn3kw4MvFRr4PwKXtFwHec5YXIX
 iOmkQl8M/PRj1IOrBBsTF0RFMDZvgo+2z5R21hu9DMLoYch/Nib+8mF4jDhAcRlQJIxv
 j9WQf9W+NUdNhA2Jsn1l2xtHC7Let2QQ+qUISiquBYqnwoFw0g8nUQpedJfUIE3C+hAY
 YPcIXBYfKXQaMRN1vcQ1kLJiwozPUqHWPUJkoNqrzFPdXssM9e8+o4GzHxVWQGY10IGb
 p7fQ==
X-Gm-Message-State: AGi0Pua/qpyqRjMs5FBr1+kmOXYq5Jt0MNpGMUIO8H4yeVno2/li8NNO
 8RmXzoU9SNL/fnkCPXihMGuJ7UsMhwYp3Q==
X-Google-Smtp-Source: APiQypLVajnEd2VYoVD0GsUNp0uiETfPbamMf2qzzDt6Lm1ur0MJ7piBwYavDKzZLCzI7cxWoiWUsg==
X-Received: by 2002:a17:902:d697:: with SMTP id
 v23mr6072839ply.262.1588736767894; 
 Tue, 05 May 2020 20:46:07 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id k4sm465676pgg.88.2020.05.05.20.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 20:46:07 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 15/30] powerpc/kprobes: Use patch_instruction()
Date: Wed,  6 May 2020 13:40:35 +1000
Message-Id: <20200506034050.24806-16-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506034050.24806-1-jniethe5@gmail.com>
References: <20200506034050.24806-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, Jordan Niethe <jniethe5@gmail.com>,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Instead of using memcpy() and flush_icache_range() use
patch_instruction() which not only accomplishes both of these steps but
will also make it easier to add support for prefixed instructions.

Reviewed-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v6: New to series.
---
 arch/powerpc/kernel/kprobes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index f64312dca84f..a72c8e1a42ad 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -125,11 +125,8 @@ int arch_prepare_kprobe(struct kprobe *p)
 	}
 
 	if (!ret) {
-		memcpy(p->ainsn.insn, p->addr,
-				MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+		patch_instruction((struct ppc_inst *)p->ainsn.insn, insn);
 		p->opcode = ppc_inst_val(insn);
-		flush_icache_range((unsigned long)p->ainsn.insn,
-			(unsigned long)p->ainsn.insn + sizeof(kprobe_opcode_t));
 	}
 
 	p->ainsn.boostable = 0;
-- 
2.17.1

