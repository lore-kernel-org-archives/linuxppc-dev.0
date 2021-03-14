Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B3DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 11:17:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396DF64EB0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 11:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396DF64EB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dyxpl53nhz3cKh
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 22:17:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=tVTDfqE0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531;
 helo=mail-pg1-x531.google.com; envelope-from=yashsri421@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tVTDfqE0; dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dyrl62fZ5z30Qm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 18:28:49 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id x29so18604424pgk.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Mar 2021 23:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=2DBxZZzfpEFBGCSvP78Nj8qEZTByky+nxFzM0e7NOU8=;
 b=tVTDfqE0cBMhb8ob+K4J60TmYSzRkEIXIPnQkneHTl+dSSjZlI+oZSkesA28WPTVOV
 rhRD4ohwdPEbVVd/EwakNGExHbs7aAe3zEz7FDP75xhuWAEv4q5PCWKNRbpzjLwjqi69
 xnMiM57qD5oqae2NJRcHMQ3R689JrmPVXmX4nuMPOuwhKfMyUbrIECDGkpBt0jXu4yog
 gk8iQs6jIaYIvntqh8pJjW7tbQiJuymop3sZF4WdKnblyypGCcTrAgVd0eaMj6xU/2Tb
 O4IRYDsw6kh1VRWF7uTfI94JGQ0IDRho61JrRc+ku4t9yAzTD4wYAUfHO1xhmur6o+30
 FdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2DBxZZzfpEFBGCSvP78Nj8qEZTByky+nxFzM0e7NOU8=;
 b=pyPGFIy6o/gpWzihtX1Txxs3xKij2WIamtaoi4KC1EOZKGTOuPCkUaUzUM2WU87+Iz
 9GMfDjgPCLCObclXIqxBJnExA99VoPJMOwchmThZ+P97Qiq/KFWsGbOCW6UEJqc+Y0S2
 lJku1oPgQbj5QGPDgms9ZE+BZRZV11S9RDAM8DvJl4r2Fs4VP6LvRWB3zpRX9tRJFN3T
 /t+bSMGP7+7j4Hy2+6oXPQBBWnX0eoa+e7pZO9NxzFfcdq25xp4NPPg8WgrSdVKlfky6
 9cl2uHiuZKGxMJOFGhpvQneGuP25YxdTaghNdaKJ5EmIIFzKYernAVtK78xrcOpCm9kp
 6iOg==
X-Gm-Message-State: AOAM533JJrZTnrJMaepldr6is4PBY+Di4Jsd4ZBmVQDvw32bkrXMzPaR
 2xtcMEwIqXW7ubY5djENAk8=
X-Google-Smtp-Source: ABdhPJxYVgYx5WkBx3nd4L116cSq9pHykQvc+OkFZFrhoXbwJG25Q2EixNaR4oaRP0JNMU3Ce1ssPA==
X-Received: by 2002:a63:905:: with SMTP id 5mr18502662pgj.337.1615706919762;
 Sat, 13 Mar 2021 23:28:39 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:ed50:78e5:473:ed82])
 by smtp.googlemail.com with ESMTPSA id
 gm9sm6823247pjb.13.2021.03.13.23.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Mar 2021 23:28:39 -0800 (PST)
From: Aditya Srivastava <yashsri421@gmail.com>
To: leoyang.li@nxp.com
Subject: [PATCH] soc: fsl: guts: fix comment syntax in file
Date: Sun, 14 Mar 2021 12:58:28 +0530
Message-Id: <20210314072828.9270-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Sun, 14 Mar 2021 22:16:54 +1100
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
Cc: yashsri421@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The opening comment mark '/**' is used for kernel-doc comments.
There are certain comments in include/linux/fsl/guts.h which follows this
syntax, but the content inside does not comply with kernel-doc.

E.g., opening comment for "Freecale 85xx and 86xx Global Utilties
register set" follows kernel-doc syntax(i.e., '/**'), but the content
inside does not comply with any kernel-doc specification (function,
struct, etc).

This causes unwelcomed warning from kernel-doc:
"warning: expecting prototype for Freecale 85xx and 86xx Global Utilties register set(). Prototype was for __FSL_GUTS_H__() instead"

Replace all such comment occurrences with general comment format,
i.e. '/*' to pervent kernel-doc from parsing these.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210312

 include/linux/fsl/guts.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index 0ac27b233f12..fdb55ca47a4f 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * Freecale 85xx and 86xx Global Utilties register set
  *
  * Authors: Jeff Brown
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
-/**
+/*
  * Global Utility Registers.
  *
  * Not all registers defined in this structure are available on all chips, so
-- 
2.17.1

