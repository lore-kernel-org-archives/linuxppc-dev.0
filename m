Return-Path: <SRS0=WT2w=V6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3076BC32750
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 11:48:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969E220880
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 11:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2AjTn2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969E220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460QQg2lDbzDqlw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 21:48:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="f2AjTn2+"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460PMj114kzDqWQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 21:00:33 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id t16so35832360pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2019 04:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xEsxeG444yzcJtuWUSv56xRP6n++uc8jNpqEvnRlTIU=;
 b=f2AjTn2+IOWE0UhlSuUjzHp4uy4E0MPJuwhwSfld2DbvLnW3aZ0Bwiu85RKx4LjYY/
 LrvbFPPF1go/0ozBTGtV9H/hZbH+DyEnxm8+jsWC4M90e0l/K4pr+ftBVyqEbE0PRon6
 5kdWrb9dmvtA5CHyn7lwwnabhJAB4TbeSDQ8HJ4AyC2o+z6uFb6sTJyImOV7vG/pKpRI
 lRLbfJhy0GFknvXKIDfZGHCKDsQ+xmfGA384qYwh9F1eODarjDg1b7QzhuWHI3dc07De
 uyXIiIQCNLRk9BqP4j0tK4y+Sq55H7IuiL+ESnu83zJ8242l+4AzWNBz95gtcALklUZc
 mK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xEsxeG444yzcJtuWUSv56xRP6n++uc8jNpqEvnRlTIU=;
 b=HuSrTYKVk9plIUaNb7PzP00cFNWTPSin+xXzVs3Tv81k6Zf7oqvPAHaVSdXMmMNdeP
 en+a3U163O3LI2ylI0glO2z31CGv47787dQZq5ktJ/co+eHcTWzaLNuALeNQCg105rb1
 TeyRqDHEWPn1MF76qhGzjtFGbcM6Eo1WwW9FGrqKWArQNzl9BuiSu8m8Xf1nuBF4cDU2
 zG3ycgYAVqAY1rqAvdp5RNpsgIziTDnYDzZI+Fc4hwN8KuilvQUG5PII+bvklb01+0lv
 qm7OGkXX6FFabtpdYpIdLyJ9wOMT6DavhKLFgRt3Rz4COVfAfxZb5Fp2Ix3oU8FgEbSF
 jfNw==
X-Gm-Message-State: APjAAAUvOOX6iF7QDurEGv5ifdKsyN/AmgrU8nGW3HQTG1h5hdbQwSrP
 ruHtVxRfk3fEabYS/woN9xzow3eigt0=
X-Google-Smtp-Source: APXvYqy2nvn9s6X6CvZc/j4KYlnDIZEdQZKGZr/6UUcaBOpu3/Micjr3kWlzqdEXWObdOiJIYigREQ==
X-Received: by 2002:a63:3203:: with SMTP id y3mr125223050pgy.191.1564743630045; 
 Fri, 02 Aug 2019 04:00:30 -0700 (PDT)
Received: from bobo.local0.net (193-116-68-11.tpgi.com.au. [193.116.68.11])
 by smtp.gmail.com with ESMTPSA id t96sm7377118pjb.1.2019.08.02.04.00.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 02 Aug 2019 04:00:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 21/44] powerpc/64s/exception: remove 0xb00 handler
Date: Fri,  2 Aug 2019 20:56:46 +1000
Message-Id: <20190802105709.27696-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802105709.27696-1-npiggin@gmail.com>
References: <20190802105709.27696-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This vector is not used by any supported processor, and has been
implemented as an unknown exception going back to 2.6. There is
nothing special about 0xb00, so remove it like other unused
vectors.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 723c37f3da17..9c407392774c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1563,10 +1563,8 @@ EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 #endif
 
 
-EXC_REAL(trap_0b, 0xb00, 0x100)
-EXC_VIRT(trap_0b, 0x4b00, 0x100, 0xb00)
-TRAMP_KVM(PACA_EXGEN, 0xb00)
-EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
+EXC_REAL_NONE(0xb00, 0x100)
+EXC_VIRT_NONE(0x4b00, 0x100)
 
 /*
  * system call / hypercall (0xc00, 0x4c00)
-- 
2.22.0

