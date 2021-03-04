Return-Path: <SRS0=6LlZ=IC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00BC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 04:34:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D260164EE4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 04:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D260164EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrdLw6T6mz3d35
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 15:34:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=rHqw52UX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=menglong8.dong@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rHqw52UX; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DrdLR4gQDz30hv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 15:34:22 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id n10so18054745pgl.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Mar 2021 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A2hLtjNljNetAkSmo/iHqzzoKnA6pftypZoUWx6FurU=;
 b=rHqw52UXPF+xdckDBtcyZS3CUYmrMbR3cobcppf35CgyssREqhhCCwzCsoQZc4NiZk
 thNRdQ4UpMHDphFBeVbcomsCvqOTzmIkp5EV5AmHo23rKGxgVtKNpQQrh7cEzlKrOw6I
 DEANoc+W9nbATxuLvHTLq54zAAz2jQkvmUJ76Nw/RtPA/5GSq8350zOWNp4fiWBte4/u
 uuvPjOWfas7a1qQt7pIrIdaaMM+H2o+TChOUmpOhj49HGc9KBDQkciKtQu1on9O23+8f
 NXSz0J9ZOM3Tf5Er0EkGVlbCpOuTA3XRxI8b3KTG/oxlIRbaPvdlTqYGAkZDHIcs64nt
 fVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A2hLtjNljNetAkSmo/iHqzzoKnA6pftypZoUWx6FurU=;
 b=tDnvfApquzgrTcVJ8YpuYCGScfdfYyxbmBWzPlDyZ+dOZar14gLhqf/ih1OEp5rByD
 PP8MNrwqtnOjgV00r1vxAySn9yganQ3fLl5avXpNef0xUGZaeQpG+Qws4DWHkqncNb6Z
 k03T0hCGFeWk1xApK/a5m1jTaU62gkaGSAA0A0GPx6bEcGeW08QVkbRlCUqTPcKs2ZHR
 D5Na+0MZ3NCJ8t7xZ8MB4CFyBRew5cEkp84Fe4fuiu5qM1IRPFzU4QLOGE4XGYugxrWP
 /EVCW8agYagjQyzpByMPg2KESFhs2mPcP6pVZtxN/XRVA7YgAzZzmwpNpU4YmAmeNSKS
 +k2w==
X-Gm-Message-State: AOAM5318aAKJd3tcrCcD4mTE3uAOJ1bMss6RxcEHbGZudnpRTp7kP22l
 FburKBcxCBBXA1trKPyWPhM=
X-Google-Smtp-Source: ABdhPJxq/ac63Tv3Iihf95Hb63XawyRjE/7qX7mVuyui7LWCpQaK9Sh8ZV3ZihWeAmnZyTRACyOg4Q==
X-Received: by 2002:aa7:900e:0:b029:1ee:14ea:f719 with SMTP id
 m14-20020aa7900e0000b02901ee14eaf719mr2115641pfo.46.1614832460444; 
 Wed, 03 Mar 2021 20:34:20 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
 by smtp.gmail.com with ESMTPSA id ha8sm7709078pjb.6.2021.03.03.20.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 20:34:19 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To: svaidy@linux.ibm.com
Subject: [PATCH] arch:powerpc:kernel: remove duplicate include in setup-common
Date: Wed,  3 Mar 2021 20:34:12 -0800
Message-Id: <20210304043412.190085-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Zhang Yunkai <zhang.yunkai@zte.com.cn>,
 paulus@samba.org, aneesh.kumar@linux.ibm.com, ganeshgr@linux.ibm.com,
 akpm@linux-foundation.org, jniethe5@gmail.com, elfring@users.sourceforge.net,
 rppt@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/udbg.h' included in 'setup-common.c' is duplicated.
It is also included in the 61th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/kernel/setup-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bee984b1887b..7221f11acf04 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -69,7 +69,6 @@
 #include "setup.h"
 
 #ifdef DEBUG
-#include <asm/udbg.h>
 #define DBG(fmt...) udbg_printf(fmt)
 #else
 #define DBG(fmt...)
-- 
2.25.1

