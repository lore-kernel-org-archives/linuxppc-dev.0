Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D13C433FF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 04:04:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365EA2147A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 04:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="TktXLfId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365EA2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xmKb0YpczDqRv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 14:04:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.b="TktXLfId"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xmDp4YfNzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 14:00:26 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id n9so21289949pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jul 2019 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QEGm5RO370+1d5IRbqWLncN9g8dMNoXOhptUJSSSVGY=;
 b=TktXLfIdMPz/+Bjgtn5c0ycVGKS9Y7wSHxpO/a+O71rjQAzWhK12tGj5OR/ZqnbemN
 zNUwWdc/AOrcYszNB7f7fIGi344D/K87A/M6kNHxV6OS87FPOGgwrL4JZxdU9pgpVOq4
 x4LOJrwqpnxhzGVSoMFxE5SjafY0XDa9eanCC05N63udkJOcYOO2ov+I+6cS717oDJqf
 KR6h9IOlNMIu2jRmO75HsycJGekZqdnZdrIbxvhZTYDXD+bxcU+aXM/v7CsJz9eUr6Nm
 UCaoJML9mAVyD13/6H2wfZIfpw7CRFlWD+i6QNqet4fs7gSLw66wXa4mLdaNXiOs+BPn
 VTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QEGm5RO370+1d5IRbqWLncN9g8dMNoXOhptUJSSSVGY=;
 b=O/064mzxGGIPYTthqcwAfav+nJ1/OHdI5i9oHPuYj1+K8HA6kBRoI6hPp33vf37Wtg
 vy2hb5OZFOrs4W/bM+8Qol1VXcnXOzqmmiMy0GwRX9s8U1Qg7hII4i1sAfFsWH0xCH75
 DU7Pfm247EAcUw3vpwKBcSRHFS921P7DHR4wkOTmmv4T6PvPI2fG/dbSqfowCf/quyoq
 Kc0gYffG7Tape2pUxJEwXM+eskpJzgfQtcMEDJ6e8oe9ig7MQ6ZzKtnK2uH7z0M2QQ/6
 waChc6T6wHQKTAx0ixKj8Sly7HgpN6lYP4LZibctG5TTrGz97tOACP5cyEJPTqWvpXIw
 b2Jw==
X-Gm-Message-State: APjAAAVXUps7Mnhg1yn5hhDtMlntU68y3DRsV9FowPMqlN1ZaQIFQVoq
 0dOvFa5KJN4iAC5+cOvtPeww1SfBSEM=
X-Google-Smtp-Source: APXvYqyeOtCjd7IFnPjeLrei396o9gxgYCqFus+m2Ph6YPME9ayUrsVbW4Hbd17abtRLpGeoRHDIzw==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr105420085pgr.52.1564372823983; 
 Sun, 28 Jul 2019 21:00:23 -0700 (PDT)
Received: from santosiv.in.ibm.com ([183.82.17.52])
 by smtp.gmail.com with ESMTPSA id g1sm100033948pgg.27.2019.07.28.21.00.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 28 Jul 2019 21:00:23 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
Subject: [v6 1/6] powerpc/mce: Make machine_check_ue_event() static
Date: Mon, 29 Jul 2019 09:30:06 +0530
Message-Id: <20190729040011.5086-2-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729040011.5086-1-santosh@fossix.org>
References: <20190729040011.5086-1-santosh@fossix.org>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Reza Arbab <arbab@linux.ibm.com>

The function doesn't get used outside this file, so make it static.

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b18df633eae9..e78c4f18ea0a 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,7 +33,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
-void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -203,7 +203,7 @@ void release_mce_event(void)
 /*
  * Queue up the MCE event which then can be handled later.
  */
-void machine_check_ue_event(struct machine_check_event *evt)
+static void machine_check_ue_event(struct machine_check_event *evt)
 {
 	int index;
 
-- 
2.20.1

