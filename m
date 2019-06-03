Return-Path: <SRS0=u7tn=UC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA1AC04AB6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E508A21904
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsobwIzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E508A21904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45HQYv75mkzDqPK
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 16:46:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qsobwIzl"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45HQWg4ftMzDqPK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2019 16:44:15 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id h17so7716970pgv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Jun 2019 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t6dd4hCNwQbpKL0MwPJ7GiGXjPkRi2/zbWZ1wOGORnU=;
 b=qsobwIzlhYVjVLzzqYEaDldV2VPnauhMjJrOG36Yx9gtSQiClFK9TufHZ3ZSDoZvYM
 p4dDdKFnlNsT8we0JN6bKuJclOPUEutZ0efZ42EvrhIkdu9uXD0NxHWJyHsGhtv/bcux
 ARJHtmjcUCouqnnWdHH+ZktuZ3/OJ02baLRbac2FhyfHf+j45dXhLBuopw21szm3Yk0Q
 mKbacOMoU4fo3noDPMzRD5OY0TGmR6zjf+tmFFi5C3IGt9JmYoEVaD4PjTESCbVkW3BA
 HU1DCEFL6Qkv7BKeb1wFi/YdsY9BzrrnoPleluGq8Y6U9juCFUvTt7Za5kQMWwkmzPeT
 SuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t6dd4hCNwQbpKL0MwPJ7GiGXjPkRi2/zbWZ1wOGORnU=;
 b=hTnmJDKC8gX7r9P8QCAlOxmYYu0six4UB7xANT6EAHUR2QSBIWzSxfQonf/3hv627w
 JT8c9BGumA070fIs0/IE7BKpAMKZt6kP0CiD9R5swXBiM+ltZLImcTSYgj6JCHYcAd17
 vSlR5Cm5CwBnG4Hp5T2T0zlReW3IT34uARAx9QyFpL19wpcINfyrXoqE0yF5W69VbEBm
 jqt+9K8h3cJWNfUIpqyEXjcsfN/T80eREm33GpSnnqTK/XO4qDtDg1Jaj+WADklahBDK
 glmthGNX6Ub3OwTzC2w2NMRexIH5C75C8w7sSzF22RAPztWw26fnrPYekLDiDkJye0eS
 Ha/g==
X-Gm-Message-State: APjAAAVtsz9tTNF4ytKfZsKT/20vGkFH/egicRgZ+FVQUpv2782IO3cw
 nn2lSZdTfS5xrKvtxJZddnyWAVap
X-Google-Smtp-Source: APXvYqwFeShqTVNvJ5/A+t5FwpNOurfl29L8bFzIEbnNZZttYDneTPdb2JzqoqPeaUbWcRN6UrrX7g==
X-Received: by 2002:a65:5304:: with SMTP id m4mr26343493pgq.126.1559544251339; 
 Sun, 02 Jun 2019 23:44:11 -0700 (PDT)
Received: from bobo.local0.net ([193.114.104.220])
 by smtp.gmail.com with ESMTPSA id d128sm10656116pfd.147.2019.06.02.23.44.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Jun 2019 23:44:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc/64s: __find_linux_pte synchronization vs
 pmdp_invalidate
Date: Mon,  3 Jun 2019 16:44:08 +1000
Message-Id: <20190603064408.14735-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pmd_none check does not catch hugepage collapse, nor does the
pmd_present check in pmd_trans_huge, because hugepage collapse sets
!_PAGE_PRESENT && _PAGE_INVALID (which results in !pmd_none and
pmd_present).

Aneesh noticed we might need this check as well.

---
 arch/powerpc/mm/pgtable.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index db4a6253df92..7a702d21400a 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -372,13 +372,20 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	pdshift = PMD_SHIFT;
 	pmdp = pmd_offset(&pud, ea);
 	pmd  = READ_ONCE(*pmdp);
-	/*
-	 * A hugepage collapse is captured by pmd_none, because
-	 * it mark the pmd none and do a hpte invalidate.
-	 */
+
 	if (pmd_none(pmd))
 		return NULL;
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (pmd_val(pmd) & (_PAGE_PRESENT|_PAGE_INVALID) == _PAGE_INVALID) {
+		/*
+		 * A hugepage collapse is captured by this condition, see
+		 * pmdp_invalidate.
+		 */
+		return NULL;
+	}
+#endif
+
 	if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
 		if (is_thp)
 			*is_thp = true;
-- 
2.20.1

