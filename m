Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84324C282D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 01:55:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B299320989
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 01:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFCR1gvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B299320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qjxR6zXtzDqW5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 12:55:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LFCR1gvC"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qjvZ3xCMzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 12:54:02 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id 101so717665pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 17:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iSwJVF0akr2kVYJppTgvIyWL79BXicuVcEgnc3zIsas=;
 b=LFCR1gvCt7VgAvXOY092LW3oC1Ypi0k84WXZrf61a2DR2T3hkE8VdATF2prGZ17h5R
 hME/nZ3HGgnu/q/aWzYz+A63Jjs7ULxreEbHupjdWr3BEtCCgUIUhNNcjJ9Enp/ykL/f
 cVTYcRxzYwl2kmGRbAlcxtjKwzCu3OufCYT7J2mAGgl+PS9eQV+xjtbQe1RG42PBmGVN
 e68cZ9VGM/Jb3mOtl0GlR/STKRqnb7QR9GI+/sgfnn9j6cpduA7vwsbHZKy2QBWN9qwU
 cfarce1QOWzAqXF5LcZyWqEli8o7DgUf5g98PvOxvAh5DB0PzLzaGqD07qYJwf66C1Ad
 EkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iSwJVF0akr2kVYJppTgvIyWL79BXicuVcEgnc3zIsas=;
 b=BhGrGrYetQMHUKTH5TfRL9vMkPfwxobbwApKpuyu1y47uQhY+Rt8ljy33h0+94t/7T
 nKkRm/O9AdRuIegPtFPnM+OWfZsew6wRW5OPq9S9k8/khnzkn4Na7XZhyjlpSzAP83u7
 Ge6KjaBC6dEzHC+w6GcZw8JPOMZHOY0pQCH9Y7qgBHe/VC5+j5wADoByCm9U9+QXdmEP
 /KZOHzthqVwMjLb8e5mx6UTjg8/o7382bUzcQQyVLkikwlftfJSkmWNicRzpn8NtPJFa
 Dmz+uJ5AchFcicW3d4FoNkeZjDXb926XBK6xbZgeJmZ5i6D8zhr9Sq2RidNqJd1aUt+A
 wePQ==
X-Gm-Message-State: AJcUukccS0tbdsZft5adtfp9QM5AI3azVPQlGwdScvMQxu0PWAjx0sE8
 Px6SXDXO9PZi/04LMg+qBma4Jswj
X-Google-Smtp-Source: ALg8bN7sQo+G9SoV+f59SYzq9x8NFo7VObZz9hKM0VS1BpQjnnmsD3OANjUSX8o458be9Sv3cWntiw==
X-Received: by 2002:a17:902:714c:: with SMTP id
 u12mr32466424plm.234.1548899640226; 
 Wed, 30 Jan 2019 17:54:00 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id p64sm4322108pfi.56.2019.01.30.17.53.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 17:53:59 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/papr_scm: Use the correct bind address
Date: Thu, 31 Jan 2019 12:53:47 +1100
Message-Id: <20190131015347.21674-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When binding an SCM volume to a physical address the hypervisor has the
option to return early with a continue token with the expectation that
the guest will resume the bind operation until it completes. A quirk of
this interface is that the bind address will only be returned by the
first bind h-call and the subsequent calls will return
0xFFFF_FFFF_FFFF_FFFF for the bind address.

We currently do not save the address returned by the first h-call. As a
result we will use the junk address as the base of the bound region if
the hypervisor decides to split the bind across multiple h-calls. This
bug was found when testing with very large SCM volumes where the bind
process would take more time than they hypervisor's internal h-call time
limit would allow. This patch fixes the issue by saving the bind address
from the first call.

Cc: stable@vger.kernel.org
Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 7d6457ab5d34..bba281b1fe1b 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -43,6 +43,7 @@ static int drc_pmem_bind(struct papr_scm_priv *p)
 {
 	unsigned long ret[PLPAR_HCALL_BUFSIZE];
 	uint64_t rc, token;
+	uint64_t saved = 0;
 
 	/*
 	 * When the hypervisor cannot map all the requested memory in a single
@@ -56,6 +57,8 @@ static int drc_pmem_bind(struct papr_scm_priv *p)
 		rc = plpar_hcall(H_SCM_BIND_MEM, ret, p->drc_index, 0,
 				p->blocks, BIND_ANY_ADDR, token);
 		token = ret[0];
+		if (!saved)
+			saved = ret[1];
 		cond_resched();
 	} while (rc == H_BUSY);
 
@@ -64,7 +67,7 @@ static int drc_pmem_bind(struct papr_scm_priv *p)
 		return -ENXIO;
 	}
 
-	p->bound_addr = ret[1];
+	p->bound_addr = saved;
 
 	dev_dbg(&p->pdev->dev, "bound drc %x to %pR\n", p->drc_index, &p->res);
 
-- 
2.20.1

