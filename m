Return-Path: <linuxppc-dev+bounces-19502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC01073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMBP0h3bz2yjp;
	Wed, 08 Apr 2026 22:02:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649741;
	cv=none; b=bezNK5GMOozjXEqwxw37/Ei+7k5klSAmbyJAWznZkT4t/cb2ep93pyEb/V0zJtyC5LLaIXVgqdXITCR8EtV7qGLXWPVlalMl3WBJHCbW3QIECw9hOhF3IFDDsDxTOyvwA+A1JrSzcU7x0Skl0MssqYlAC3/fQY2gkpfJwNGuhgMPJiwne68Lbl0NLcA2Q/P7EgVs2GGIOmwDsWRVg3U//ktcCWEcATCuanZCYDXPRSMLHWE4/dhTPip2l2Tu0ZNtTzGhg2Dmm0ExAnTvkBcS2jM630TRmW0XRzhPPbInf3cW1wLV3nIueJIPxpmPaVFwWJmCk0znYyLFxTLTdKt6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649741; c=relaxed/relaxed;
	bh=LxoXdEEXs0w/jw6jTRsQHNSCF81gwq53jiJYY0lS3Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/CxojqV32T+7g5/Q+3Ai0iEDxnd/hKCo0iPibZqsKBMNEQ3cc9u8nTKdrCL3hFpQ2U2A4QzLIhqKdiwclGzBbLLc5AVjHpIqMp0r93ImQivIIT4jsKdkNb3UC9ecIge5etWryd1TDSqZLKBWBoB7XflurbGBurApdjaVnyM3zeIUPPglqhA9EHvYTbKtHSukxgGKC5y+qDxrQS5Gh+n5hkLFB9w8kfczA5dFpUZElXgm6EDYp0u1eK2xJwq81zqv0T2NQ0G4jpCBdO3bFCvSE4t7nxlUI/tJmIVuRkg0TQcma4/RkcuLRittMl2VYJg3YG17vClZqWTqk5wXlSyjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MHptm+dF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MHptm+dF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMBN35FDz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:20 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso4244844b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649738; x=1776254538; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxoXdEEXs0w/jw6jTRsQHNSCF81gwq53jiJYY0lS3Rw=;
        b=MHptm+dF3FQlMb4ChkuojvUZJvJusCf3sjatP1/Jem4m3prMLKMlS7OZV7gvWpoovG
         WrAcLlLPnloHAv98D1caHK1mPbkTQ6PZmxWEI7dReG8xAygI/1SxN8cjSPTf4Z0kYK2s
         jCtvb4JHQdZtdKAPT9vQGQl0hQ2tUh18IC/Q2CroGGUf1VtFfwcQqQidCZRc1dVSvZ0w
         S9P2ZrES2XtHbV5rSStd6ckdDdHGIasiUUuoC/Hko6swgwpeOz7jjZbUkLaTjsfV+iG/
         usmjT0XbXBQTeWbZZ459eRO8qgC05BCN7VYfM3zcNFHI9NGMl47G7aSq89lXqISWhsUG
         Fgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649738; x=1776254538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxoXdEEXs0w/jw6jTRsQHNSCF81gwq53jiJYY0lS3Rw=;
        b=NV9muboLRwN69F4KStJJ4x2PbE6QkOW0EIgBA1DYhNWCYy0kgk2FnvAVsbZD8c0mJt
         v9QYL2pbT66AewoPWFdZWkyiq+W1fjGjtM4F16YTc8P7vUyeS3Sfd32BNjp4zc+h/E6k
         Aq03hqyFGZKcOPC6A4cIcaMy4x5cabKzpnxZlBhbWlm571+VOlvkmq4WMGx97N6D4GTh
         Lbx8hSaHqs5/OoX3Y6D2WnUoyRvYXokvnYwusZoYwBuYhjRfza0HS+IRZ7s1kzYZeVfo
         Qwv66XVsilYPOAncqmWcz3L9Gz9St7Q2jJ/N3GDWRt6MiLK3aTS9JX22UJVG0GhE4rUW
         uiIg==
X-Gm-Message-State: AOJu0YxUT9SjWMROyjtnUERRxPJG7sNB2A3v6lhHJepWJpyFkMW6MmQ4
	sRppqEhHB1eg5Rf/cuKYro56qdCIYhxwBSk3o8PE3LIarAKv+YB7qo97wsX62Q==
X-Gm-Gg: AeBDiet9v76A+z1FMIF3qfFS1VAHRIkZ06qcTffQbBH/ppwTMicdG8tMlaqw/NZQJ3j
	HjAJYPSOBokMLYBDhRMgJZf/yzum7EG0TRNaRDRZk0psDbml3I39pEDQod0FMQnj7OgSd7cIZd0
	4b/XD7KSC0pHsgWXcuatxCaO4LhAuqFHGDgL1esOgcHirtmlgiPuoaxVprrh3B9rN/GaiRiiJ65
	XGgBFX6A7Oa5DSKKuYXhnW+dOufEKjGMo4k9qZV19G83ReYFRjkxl/85Ve1hjHNH02qJCO3CpTB
	CkkcH/3U3I/lFii37GLjpGPb5zP8gBTVn1XRA3WAb2EOweRIYjxACcn7WzIlhgYGyUBLN10+tWp
	GkXDP6Ck1iBStcLYXTH2sxAXk1BKAqra87mrS+RmlUq2VVjdVahxJYSy48WBNH13g2ukyWQ1X+K
	nU4hOUHxBgrVHdccAxK5JL1gXXIufEKUHGz/Sl2AZYXHS+
X-Received: by 2002:a05:6a00:4fd6:b0:82c:df25:fbc4 with SMTP id d2e1a72fcca58-82d0dbcce73mr22490656b3a.52.1775649737668;
        Wed, 08 Apr 2026 05:02:17 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:17 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 06/10] pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_source_info
Date: Wed,  8 Apr 2026 17:31:36 +0530
Message-ID: <47f37e9d782b8e87566c4f2da065569f319d1b3c.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't really use task_struct pointer for anything meaningful. So just
kill it for now, and we can bring back later if we need this for any
future debug purposes.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 ++---
 arch/powerpc/platforms/pseries/papr-hvpipe.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 7d05d6dcdb79..41958ed8ee97 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -493,7 +493,6 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		return -ENOMEM;
 
 	src_info->srcID = srcID;
-	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
 	/*
@@ -503,8 +502,8 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	if (hvpipe_find_source(srcID)) {
 		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
-		pr_err("pid(%d) could not get the source(%d)\n",
-				src_info->tsk->pid, srcID);
+		pr_err("pid(%s:%d) could not get the source(%d)\n",
+				current->comm, task_pid_nr(current), srcID);
 		kfree(src_info);
 		return -EALREADY;
 	}
diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.h b/arch/powerpc/platforms/pseries/papr-hvpipe.h
index c343f4230865..4bdf7bb2fc4d 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.h
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.h
@@ -21,7 +21,6 @@ struct hvpipe_source_info {
 	u32 srcID;
 	u32 hvpipe_status;
 	wait_queue_head_t recv_wqh;	 /* wake up poll() waitq */
-	struct task_struct *tsk;
 };
 
 /*
-- 
2.39.5


