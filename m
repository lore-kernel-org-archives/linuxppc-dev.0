Return-Path: <linuxppc-dev+bounces-20358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36128FF885A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:13:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Hh02W2Wz3bd0;
	Fri, 01 May 2026 14:12:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608768;
	cv=none; b=eb8GPu5QPEDK4xT3HK0N1DDujMbMG8oCz1gamFkdxe3ixA4dWLkQFRRrlzcKfZ0t0R/I5qEzD0r3Agf8qbzZ2X+CtqP3mDY6mZZ/0UgP73Ccp50EtcmK6+mRLWRwbOIi68nTy/igo0QCnCLbQAzDQzmZWLa5W8Eehs1/3GSfZ2PXUumLOMN3R8vRHxOeK+xgUg9iPR4CWCqJvVPKoBbWayNkmNzNkcv3Qwzy0nlrHJYuy9TlO7GR5iOhx0VEmKwTaVSNYpyGVZqHskmqRk8ZAxt4caPyjevWr6N5v8q7j04/jDbwwfSZ9umxCKTll2miyU81bs3lh1M4IcW/o+lo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608768; c=relaxed/relaxed;
	bh=QMCX/8Rx1DH/VKMyWagi6FXZnymSiiQzOS5vntFU8d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmNTkZ4gdU73YixC6UBJCGaHG+oDHdvUZ0trIYAz0bdjORNcTLnwBqwvP2+AgMZPGnAd9hOPwkFq6/McJSMu+jcxRx96EE3aGWPx5/zpc6pQMUcqQpJ12gzroU09+dcb1EpmIVPk6Mn/Np4u5KuL7o3DfOIdC9l/Ed7aGCHJZebj7k0AXL1reW5vRGglWArmunGsI9UcfcIQA+jYjuxXgazED17wHbzYSi5Cc84w8jdtG4z6kFqHAIvR1AvNj1H+t9Py8Anos30ItGDQkXwTU7I8YqyMY1Pj2uv2nhQw+NUBMjWfSTjzNx6YnI8JcQ/MY/+PQ9D6FfBRL6+GkP0Dqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RNwZw9LH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RNwZw9LH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Hgz5SQDz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:47 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso1099937b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608765; x=1778213565; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMCX/8Rx1DH/VKMyWagi6FXZnymSiiQzOS5vntFU8d4=;
        b=RNwZw9LHKBIxcPJV0c032bBSjkYvPAkltv5G1LNj95XXOI25GTtqE29qXJrrAazvsp
         Qo8YBHFeewOzWDQ4KmP+tKTycgQ5grnrklhjCnWrwNWfkTHTpgYu2crUm6EFvY7lyWiB
         C1mH3hZCP7nVW3rfftL+Kjz6vgBvhqJmY3UE9mRd0bbR8Opo4rw5m46j/vl+nk3kIKpW
         5y1/6wy2ZVU1VRkcER3upnJMqbXdchwaaQEDHgZA1XerbmHERc0NDzW+WHyFv34vqfMD
         tQI71VhjyiGJPUKJAtNRS2BuiROVxwaC1l9ZAyKk16JRe+VoMNew2xcIGyW6GIIrwDHb
         0LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608765; x=1778213565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QMCX/8Rx1DH/VKMyWagi6FXZnymSiiQzOS5vntFU8d4=;
        b=QCnivYUggNf+n883u2gRxhj4v4DRv3RN5itVF5KS8wgpFfEjaHvWDMoFcdVWNtgxfH
         ap5uLJNPOM4YG7zSMe9tZckGChSJAN+QEd+mDHm+aoWEA6o32qfOpZg0s47747Zidjnx
         5k4FjHs/LBYfN74bS64pKNfcj0MWmjRZsNd9Gz1n57U6ZmFlKQ5FYrSx9qD0tMU9/J+G
         tsi/fKxBBeumQpatWqeZsM6ZXaTRqA4clDQWlFEkOKe0hO8tSjg4FV3CtCB+ZS6HIij4
         8EU8lIvoJJndZiCdTXIcyP8PaFR4qlWi1VFBjPwyKDAtj095vyrIBz0wpHg7xJ8MHJQg
         UGhA==
X-Gm-Message-State: AOJu0YxmJFTu2Pluo+9rKiQcigL6i22oVRw6fJhggBMag0oXMqFH9BsJ
	5y9z6xvdS/dNiKuzkblhD46okNAjv4VROaNaL8xekrb5ofw+3Yy8VyY1BgOhTMec
X-Gm-Gg: AeBDiet2Cgvka3bIxGjJxI7akgiTqFRHlNWKMgoFLik+X5nXdHsmQggbT5xYzVe/qZe
	pMx8pWvxq/h5hTom3yxTStuAM93u9B0MOQ5wK0Z64ne7HCdyfFrPWWeMUgFTUN6WNu+Oaf/720h
	/JWWX+f9sUJij0jbkzfJ/VHt/wqLiMl/ffjHoCnkcyCZi6M2KMfYcM8xG1od6oyWt27lYDcN9tr
	jiN/z6P2Y4PdxBGYwe3CPkwD5Hf5Fj++MYf1Pd72lwnzFbfQyyB2u3ZZEY1dc4VjrmG1rZ3IqLV
	aHpzDq3PBdSk65iJRStTlSKJLukTMGBGgJb2Z6S/gji4/IHccsJg5fKUbB52g248gCH4LOiJBN/
	zrjB5LK9qI75T1j7ahifaW1cxgyu04ZcXbmTklgrfoqASk4+JdhkmvfgrZjJ08ZOdEqLWneiFbc
	B7yHimswVkj0i/ZN4sU6uCsd4oMnKhseyDrKrs8PP91SuMvzejF5aHAifbUEgmt84=
X-Received: by 2002:a05:6a00:4f92:b0:82c:70a8:faee with SMTP id d2e1a72fcca58-8351a0a52acmr1599525b3a.6.1777608765440;
        Thu, 30 Apr 2026 21:12:45 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:44 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 7/9] pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_source_info
Date: Fri,  1 May 2026 09:41:46 +0530
Message-ID: <895e061e45cdc95db36fa7f27aa1922b81eed867.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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
index 5aa37f6ad8c9..46159f1c1cf1 100644
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


