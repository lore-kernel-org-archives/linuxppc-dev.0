Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96524C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:38:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CA82086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnr+8LIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CA82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YKKz3wLxzF0yj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:38:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wnr+8LIC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wnr+8LIC"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YK3y2jq2zDrqN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:26:06 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id f26-v6so8753689pfn.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2V0SSjUhWRPC5W4OdqGfdKbaaGUGCT0NLhr5UzIi3kQ=;
 b=Wnr+8LIC1PVd+cR+XFwtzb94AQJUTHPMc8z1qC2M9v2nyrBF3I8nvB/v5WeMstwlbi
 bT9o5Nj1pzNAlrctIxXg/qgHTW6nmUP91nwKfhb89hBFcFRV/kR6VkFbEqu84RE/Qb+f
 Z3wMG8+CNokXVeDAKI6DkMkgHNdShb8wUimvnKxigjyyHKG3OFb52pGyA+VWh4Iux2gB
 8sy9WQ7YbxYCOwNWNN27/zXeGVZw99HSBA2mp5jyxNn/LJB0uPAA24+zh7w1jLsGpXSB
 QKsWwpBdnYMzoEomC5a8IBDfq/kdYB321XO9DRY/n/8YfolwKAw8SC4SFn2R8iwyLGo5
 PSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2V0SSjUhWRPC5W4OdqGfdKbaaGUGCT0NLhr5UzIi3kQ=;
 b=iI6tkJEbh49c0OZbULrXHkKhb7X/tBx2X+zocBnJQfx9Kl2kygG5Gy9DN89aPlN4L8
 rTJE0mu60BHhCTskGHE0kul/ebK+3AhPB4OU9mF2uoH+fzEVEl3xHpl1Qz1XBM9OBABL
 d+VVaB/HyUN5vrqaQWBmvZPFtCo5+EnGyZATrBLcpflssmw8ZCr6nUJ0mp0YEgjZp0pd
 pdHrLJBIJq0jQi5iHyvQKX/xManrIu6r1jSA11aYJBJ/ZXMymTUglZdAMsiAAijsKoED
 gdB4j9AltleaEEzFzgScdpFhrVFlI5td3S9uIqh+tgKIxJtuKDV9aM9OyL6YE1Hb4h4x
 dOLw==
X-Gm-Message-State: ABuFfohC4eaOfMtU7S+GIt0wToDFBQN+SGhFMm2swjtOIaUmNhDwNwST
 BVu5BMD3MSbcoxODE+3gK8A=
X-Google-Smtp-Source: ACcGV63YiTii26iv8CTGNE+zWkdSWeEpJc2NTAH/PvOKTanhSexqc2OmDQ8I9YpIfVUaG6/8G+cXiA==
X-Received: by 2002:a62:7501:: with SMTP id
 q1-v6mr15164034pfc.225.1539563164629; 
 Sun, 14 Oct 2018 17:26:04 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Oct 2018 17:26:04 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Sun, 14 Oct 2018 17:24:16 -0700
Message-Id: <1539563070-12969-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

"of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
added a missing of_node_get() to __of_attach_node_sysfs().  This
results in a refcount imbalance for nodes attached with
dlpar_attach_node().  The calling sequence from dlpar_attach_node()
to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..e3010b14aea5 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

