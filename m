Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0483C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 16:11:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A67220666
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 16:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usUtejKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A67220666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MGrk0mdnzDrJD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 02:11:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="usUtejKp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="usUtejKp"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MGcw0FpTzF3JS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 02:01:19 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id c10-v6so4790867pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gHHpt6lscz/bQihG0q4foWAWXPtzguwIZ4WhlltZ9do=;
 b=usUtejKp+U4wXXps23EV2uIdMqM5CswYgwcucYBDWB8uX1+JzR8V7OeinHwrtHJa6e
 uQjndwFFl6bGzADvBzoTC7rA9nv4wCRGhDOs1R6ovfHF0VNiOyAYPZyWgS5IDFyv7jLS
 QofeVt9lth21TQ6vAld/iCgCqTiVA/Pfcm3IBT3NyilV3DtxLp5S6KW8x1ZlKI2VzrZu
 pZtwaEiY/6RLVRMgmg87R33wpPoWRQoWOLgjOt44eJJnv/dwVBQoAA/IQRve/OnGyBQW
 lj+iQQyd5HwM4fcme8LA7mA0aG03GwZ90sQb0ksPTQA4g44AOSrrV1v9iKQFGWtWLSXG
 67OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gHHpt6lscz/bQihG0q4foWAWXPtzguwIZ4WhlltZ9do=;
 b=BQwAPrYUHnyiUnGW9mkypu0kiLK7yx4/NzMIewiqQP1bsPMgX/0ozPgz/72ENx/8tS
 Tx0CqcjeOb2Yifo4SR4wgE1MxkB2LP9VA+w0dHcwhlN24fzRFYw+iXzNGpgBM5TN+JJx
 ENfsaqgCXco2bGIscug3AFW8FADtgOLq/JViljWtS1HldVERbPugdWpRP08B23bfNnUd
 nqI8kkuDxzHfwn8zVnorhQ4k5H9J07eNOc/zIF2r2ZHuYqbbJEO8Y9M7QlT1OF8Nd4nd
 ncKyxk8ZO08R254C8i7sbw5T1T8NtIneCM+EMRnCPE0ZpA7ycBdx7ZqZMGNDynZTTwQK
 kU9g==
X-Gm-Message-State: ABuFfoipn2sPW2UjfKd4Vh87545AJY+m28byLtXbB7cat0mm77shf9Ap
 Ja4TAKMiWcTaI31cOwPSedCIerX2
X-Google-Smtp-Source: ACcGV63o4yp0VrN1M0It/ya+ShXKWXK92b/ZQGoPQYMILpHyLM+azG3FkKyTZ+aNAOgzn0beexoL8A==
X-Received: by 2002:a62:ff09:: with SMTP id
 b9-v6mr17357484pfn.46.1538150477123; 
 Fri, 28 Sep 2018 09:01:17 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id u79-v6sm11969725pfd.117.2018.09.28.09.01.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Sep 2018 09:01:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/64s/hash: Fix preloading of SLB entries
Date: Sat, 29 Sep 2018 02:00:57 +1000
Message-Id: <20180928160058.18700-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180928160058.18700-1-npiggin@gmail.com>
References: <20180928160058.18700-1-npiggin@gmail.com>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

slb_setup_new_exec and preload_new_slb_context assumed if an address
missed the preload cache, then it would not be in the SLB and could
be added. This is wrong if the preload cache has started to overflow.
This can cause SLB multi-hits on user addresses.

That assumption came from an earlier version of the patch which
cleared the preload cache when copying the task, but even that was
technically wrong because some user accesses occur before these
preloads, and the preloads themselves could overflow the cache
depending on the size.

Fixes: 89ca4e126a3f ("powerpc/64s/hash: Add a SLB preload cache")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index b438220c4336..c1425853af5d 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -311,6 +311,13 @@ void slb_setup_new_exec(void)
 	struct mm_struct *mm = current->mm;
 	unsigned long exec = 0x10000000;
 
+	/*
+	 * preload cache can only be used to determine whether a SLB
+	 * entry exists if it does not start to overflow.
+	 */
+	if (ti->slb_preload_nr + 2 > SLB_PRELOAD_NR)
+		return;
+
 	/*
 	 * We have no good place to clear the slb preload cache on exec,
 	 * flush_thread is about the earliest arch hook but that happens
@@ -345,6 +352,10 @@ void preload_new_slb_context(unsigned long start, unsigned long sp)
 	struct mm_struct *mm = current->mm;
 	unsigned long heap = mm->start_brk;
 
+	/* see above */
+	if (ti->slb_preload_nr + 3 > SLB_PRELOAD_NR)
+		return;
+
 	/* Userspace entry address. */
 	if (!is_kernel_addr(start)) {
 		if (preload_add(ti, start))
-- 
2.18.0

