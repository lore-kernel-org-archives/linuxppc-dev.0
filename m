Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD35C004D2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:54:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE8A20666
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqhNRiZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE8A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PhxS4RC4zF3Hl
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:54:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VqhNRiZp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VqhNRiZp"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMg4hmrzF3G3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:15 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id b5-v6so1711444plr.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0ge2Ls5nJleiboCDA6W63/fjdCr4a4PrN+QTNJmYig4=;
 b=VqhNRiZpREVSYZ54XJ2PiJeXf/2RflO42axPfciRWaAx1PFyoCbtQ6RkP4gRjXgNKJ
 vcXYgzX1nidzV5AJ8ffHrs3y/SHzIoC5ddHB77PyAzM1Uoy02EeJ+Poxtyzv4LqDiKtN
 LpdhF9HU7tWy8XSqzCE3HmLmmPLLchAbsyzquDIVj5HyePhXhz/11LMMCHoRgo80H8lQ
 BnPYWPqAdW/MgyJlv/fPTEgSTep/gwcxQAJQeevkkHbO2JqFXHj8vcHj4yKSO/Q/jyII
 rqIOZ9BZR10rKoazrQs1m8e/BzQKAARHDuLoxnaXqG0g9y7pc08fxiVm8AEtSE95oV8/
 aMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0ge2Ls5nJleiboCDA6W63/fjdCr4a4PrN+QTNJmYig4=;
 b=dM9yT7iCttNtbBhRLw7lM9xpXvAilRr+nODThu4Rwxy3zP4B3Q+Xq38qh0y8u5R7vS
 or9P1Guf6vnHPa6AoFILwDeqh897Ai6Xke7Fspm0tEvOQsRe4H3B+tOT++dUqg76cUC/
 RTa3hTTFuDj7XNbwxDtNolBegOjvaSr623LTrXnAiFRrhkuwM2FArMo4DEiYqM8MJSXy
 kSzwAtRQ7za/cY3KPjlxk4ffgjeUoPvG38JWud1GJX0bB0JFSGQWEpoYUAyr9Tw8aybF
 2LkAbVOcaPV3gzsjinuUS92t0v7X/1AIOu0+NtXRzNObHmHZz8AmW/D1BMig9JBFu1+7
 WaTQ==
X-Gm-Message-State: ABuFfoh3YuvwmecdjYXEL+CoZIFNlqE3KJNLDLtxIc+K+qHa3QyHlyM5
 pYxd1KlG3YYW/hf3/9lZx5DEXN+L
X-Google-Smtp-Source: ACcGV62brs+83hvK6XNXBrcEoY9Y6UUYM55fwaf8vSwUkWpmqZqE8uvSjZRQ008eSoRoBWWsN2i/+Q==
X-Received: by 2002:a63:64c2:: with SMTP id
 y185-v6mr14703851pgb.411.1538490493055; 
 Tue, 02 Oct 2018 07:28:13 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/9] powerpc/64s/hash: Fix preloading of SLB entries
Date: Wed,  3 Oct 2018 00:27:54 +1000
Message-Id: <20181002142759.6244-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181002142759.6244-1-npiggin@gmail.com>
References: <20181002142759.6244-1-npiggin@gmail.com>
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
index 74c3b6f8e9b7..a5bd3c02d432 100644
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

