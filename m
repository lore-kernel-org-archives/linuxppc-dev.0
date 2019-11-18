Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7E7C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:04:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D63820692
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Rct02fRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D63820692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Gq0w54vtzDqZN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 00:04:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::341;
 helo=mail-wm1-x341.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="Rct02fRb"; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47GmnK6MdgzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 22:24:21 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so15696870wmk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eE07ibGSDrEk6FGW5gzY56tX8GUaE+lcVDXiPEzKSX8=;
 b=Rct02fRbEV75Q68bIBJnNMzHc2dQompqDFFv9haZQOUWM9Lvn4Mq8BNiD1zfZD+J/6
 epPCO8pxqXOY4dqGXzavSIAp7alvhE+YUzcbnZRmd3AgorgJrbU9IOStLtIpKTMhQh4s
 ARaj8jMTLks1vZPiYZ4PuL7eWSvpabN1VfSCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eE07ibGSDrEk6FGW5gzY56tX8GUaE+lcVDXiPEzKSX8=;
 b=btgz5xuBUszJQSKPqQjx2lewXRydyxjEtz24w6tEleHOpvOe1CMeqDzi3Pxx9gld/4
 QJtcII8RJTOzfX5gnJlbknMhL9n6WfYpdDsYfECjhESU2Y4Aa08Nu9YIkPFNPg5Rz0ok
 UOYcY/fyyVWWVd+QLDIHFYLZUaRbQLvwSt9PtnNbsta3+Q1tQHFEaLaNt9BGsNVO/Htv
 KWuCpb2PENuuRb5CLM/9tacgMCd6tKUbe6TUFa//7/kvSz8cxnuGaV1pdM/q1R/OYy0e
 hxMKaNSu8tTe7nCRbrcKEdHzXCt+vQJogrb99kOBLca0FouQcZW+6v/JIhCimDE0pgrN
 CVjw==
X-Gm-Message-State: APjAAAWo2X2erzzn/Xwz4SpfGh/UgKM+kWTafdCwrLHbgkK9FdiW9cg8
 IrC1E1NbNPqWi4xsCvYCAaohyQ==
X-Google-Smtp-Source: APXvYqyA4aLZb9WhkWPOJwV8B2AwkWpU3y58LlCtzGy5k1rBPDFTwthAyOojKHmhWtaSRCahOyGBuQ==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr29456811wmb.53.1574076258820; 
 Mon, 18 Nov 2019 03:24:18 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:24:18 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 36/48] soc: fsl: qe: make cpm_muram_free() return void
Date: Mon, 18 Nov 2019 12:23:12 +0100
Message-Id: <20191118112324.22725-37-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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
Cc: Timur Tabi <timur@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nobody uses the return value from cpm_muram_free, and functions that
free resources usually return void. One could imagine a use for a "how
much have I allocated" a la ksize(), but knowing how much one had
access to after the fact is useless.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 +--
 include/soc/fsl/qe/qe.h        | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 84c90105e588..962835488f66 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -170,7 +170,7 @@ EXPORT_SYMBOL(cpm_muram_alloc);
  * cpm_muram_free - free a chunk of multi-user ram
  * @offset: The beginning of the chunk as returned by cpm_muram_alloc().
  */
-int cpm_muram_free(s32 offset)
+void cpm_muram_free(s32 offset)
 {
 	unsigned long flags;
 	int size;
@@ -188,7 +188,6 @@ int cpm_muram_free(s32 offset)
 	}
 	gen_pool_free(muram_pool, offset + GENPOOL_OFFSET, size);
 	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-	return size;
 }
 EXPORT_SYMBOL(cpm_muram_free);
 
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index f589ae3f1216..e282ac01ec08 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -99,7 +99,7 @@ int cpm_muram_init(void);
 
 #if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
 s32 cpm_muram_alloc(unsigned long size, unsigned long align);
-int cpm_muram_free(s32 offset);
+void cpm_muram_free(s32 offset);
 s32 cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
 void __iomem *cpm_muram_addr(unsigned long offset);
 unsigned long cpm_muram_offset(void __iomem *addr);
@@ -111,9 +111,8 @@ static inline s32 cpm_muram_alloc(unsigned long size,
 	return -ENOSYS;
 }
 
-static inline int cpm_muram_free(s32 offset)
+static inline void cpm_muram_free(s32 offset)
 {
-	return -ENOSYS;
 }
 
 static inline s32 cpm_muram_alloc_fixed(unsigned long offset,
-- 
2.23.0

