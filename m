Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D26C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:55:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06236205F4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPS840HF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06236205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448WK24qpgzDqJY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 20:55:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=himadri18.07@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPS840HF"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448WF32Zc7zDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 20:52:23 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id q206so7710858pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 01:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Mq05DlQWgAAhQB0YKmFCrwjAzMG8GDqjEen6K7LMNG4=;
 b=mPS840HFZvcmCeDdfoju/6I9b7pJtgtiMo5dyXLARuWBH6WVNZEwO6bMp454OCzcq4
 0wXk/UM4CqIJExR9maAULeuq22jRM8k2CsAjnPJh8/VDUKctVxTzKFfeKrU9cIRL0SWu
 Cb/9CNgZ79fvTcyO/H61PYoRAtwI6M/eS5zKpBrYBhwCWOwtjBG8DC7s/PS3zLhEinMr
 5ovkgnA7J1K403S8cDjYLXXILB2EKNufE4MS72BPqyEHzT6OkFkJ3/DCZqbgk9I5i+rG
 +CGKlbF9etoWVHr/KMHx9SL9VwHOpOD5GOukUPxobV8f0aAOp6bTd3TtvZ8A1oZU+wQf
 dciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Mq05DlQWgAAhQB0YKmFCrwjAzMG8GDqjEen6K7LMNG4=;
 b=o6YmWK7jH0k/AsAqpLtCPx2MbKWTqMwuq93aeixIArApjPOLqromlDoWidJIpp7RFS
 pAKvCRixOG/zuZob360/v8CgGfvco2yYWRMlso92Fq0lq6K7IXa9hq1fuxxL+hHlOgt+
 eUAIKdPspQhoZchWQoGybDFTQ5dpWMTDg2oG/nzAivcU1vBygnQh8kZJDNc49NJvzqkq
 y3Kv4v73L9I22YfFrLTqetP+q5wYdDcPHhY0V5lBhxCv4oYrCZdBjjT0qVn15wKDZiO9
 yCvTFZjTT0poeguVHWwmprZcnfROpRa2c3G1NmDvcxPwhPaedw6HC1G7nObgwCa/oM84
 /6fg==
X-Gm-Message-State: AHQUAuYTZ71G+s6i/AsIpn+QL/SFYKum+36d93lAtaSY7H+BF2gzp3oz
 +CleDqKkIdBeaH7FWbl6OReBcI6WmAE=
X-Google-Smtp-Source: AHgI3IaI8vrHMjPrjSEpWKz8qMzMfg2MJpXCIiIjbHdMsMFMLHrEhF66Jcewcfd8CbWUYsr95EJWOA==
X-Received: by 2002:a62:e11a:: with SMTP id q26mr737694pfh.187.1551261140730; 
 Wed, 27 Feb 2019 01:52:20 -0800 (PST)
Received: from localhost.localdomain ([157.32.131.196])
 by smtp.googlemail.com with ESMTPSA id m24sm15797303pgv.1.2019.02.27.01.52.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 01:52:20 -0800 (PST)
From: Himadri Pandya <himadri18.07@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tyreld@linux.vnet.ibm.com
Subject: [PATCH v3 2/2] arch: powerpc/hlwd-pic: Add missing of_node-put() in
 hlwd_pic_probe()
Date: Wed, 27 Feb 2019 15:21:38 +0530
Message-Id: <20190227095138.30263-2-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227095138.30263-1-himadri18.07@gmail.com>
References: <20190225090056.19055-1-himadri18.07@gmail.com>
 <20190227095138.30263-1-himadri18.07@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Himadri Pandya <himadri18.07@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Decrement the reference count on device_node "np" while breaking out of
the loop. Issue identified by Coccinelle.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
Changes in V2:
	- Change subject line
---
Changes in V3:
	- Do not remove the blank line at end of the file
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 8112b39879d6..df098989e373 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -220,6 +220,7 @@ void hlwd_pic_probe(void)
 			irq_set_chained_handler(cascade_virq,
 						hlwd_pic_irq_cascade);
 			hlwd_irq_host = host;
+			of_node_put(np);
 			break;
 		}
 	}
@@ -232,7 +233,7 @@ void hlwd_pic_probe(void)
  *
  */
 void hlwd_quiesce(void)
-{
+{i
 	void __iomem *io_base = hlwd_irq_host->host_data;
 
 	__hlwd_quiesce(io_base);
-- 
2.17.1

