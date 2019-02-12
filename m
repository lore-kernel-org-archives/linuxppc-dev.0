Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B9EC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 23:31:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F30D222BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 23:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlQU6pte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F30D222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zf7X2ljnzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 10:31:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=rashmica.g@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mlQU6pte"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zf5R4r1hzDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 10:30:03 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so199382pfh.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 15:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TDjrIj0j0nQ5CjozTNS/KzSJpbsPKXQT8R6kPlNyIaE=;
 b=mlQU6ptej24Q3MYsyzgFW46ttOdU0mkRuqYWUew2ZtWWiWxUExfJu0HRRe3CZIV/Oa
 VFpcmhLYphZjOXXYYUSyMVXMZ1qx48ry6FD5ykMQLGlhCpNHu0MOuzT8Sf8jWRSB+BOc
 MUZCrcYNbuRRieumEBqegO0uUaUQvxZbwEv8M22M5FfyYFIKR8S/0qKFjCxy4Dw2h2WQ
 X02hF6GKMl9ruynVsnD9DsR0AqibF6IhfVCi+eKxLwjAKKCrOkLg/LMtxip9oGGHpwjA
 L88ALAhCUCbIsBz6RWR891hNDfz3eAsLAP0Wf1j8m8/zH0d4Yx6wJJDXvCk/9l6670ML
 zo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TDjrIj0j0nQ5CjozTNS/KzSJpbsPKXQT8R6kPlNyIaE=;
 b=WfHCr3RPKgoOkRS7GQBy9sDj+R+Ef+Y7p1OFRmCxJu6d8eIZcUddCeeHZEoNON2BoR
 ujNjQZ3YlkIEMxBnmqsvs2IPRE8WNqLJGFNNgN6iqjIlm0qcQuN+s7nvVngi8zx0ds/n
 oukAeLe+cf0Nusod/oqmrYFSCKlo9vijlM8gmB/YO8n1bBXYAbldTkasCR9w2Wv8QYBz
 8Ah7k+b10FoCKPdILYJQ7vy20QYJSmPqdAETe+b4BJ/54JObaAX9k9uUasF2slo3ofEu
 tnYvpS8pADTMj4hNIQcLI+cI1KLH5YdL7MArZqQTZ1ib9gOOzZa+BDRMnLMwxnEluS6k
 QgeQ==
X-Gm-Message-State: AHQUAuYUMQmPj8jlD7OCn+iYZnOrBfGyRxWdL3CZsZUJ5SlNuERlN1JM
 JJKHjoIT0OUqufi4k/fjSDoDxolJ
X-Google-Smtp-Source: AHgI3IYpSPiv8sOGcHpLn5E+8E9WHlnKztJ7/nR10vduYgekmHaLzvv9HoQGHHNf+tVtGWITZJMIDg==
X-Received: by 2002:a63:1e12:: with SMTP id e18mr6014471pge.76.1550014201476; 
 Tue, 12 Feb 2019 15:30:01 -0800 (PST)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id c4sm37102656pfm.151.2019.02.12.15.29.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 15:30:00 -0800 (PST)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: Check secondary hash page table
Date: Wed, 13 Feb 2019 10:29:49 +1100
Message-Id: <20190212232949.21118-1-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.17.2
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
Cc: Rashmica Gupta <rashmica.g@gmail.com>, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We were always calling base_hpte_find() with primary = true,
even when we wanted to check the secondary table...

Fixes: 1515ab932156 powerpc/mm: Dump hash table

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---

Thanks Paul for spotting this :)

 arch/powerpc/mm/dump_hashpagetable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index 869294695048..b430e4e08af6 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -342,7 +342,7 @@ static unsigned long hpte_find(struct pg_state *st, unsigned long ea, int psize)
 
 	/* Look in secondary table */
 	if (slot == -1)
-		slot = base_hpte_find(ea, psize, true, &v, &r);
+		slot = base_hpte_find(ea, psize, false, &v, &r);
 
 	/* No entry found */
 	if (slot == -1)
-- 
2.17.2

