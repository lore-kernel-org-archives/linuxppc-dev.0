Return-Path: <SRS0=0kbc=FX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A12C4361B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Dec 2020 23:57:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDAB23407
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Dec 2020 23:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDAB23407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cz2hh5232zDqWT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Dec 2020 10:57:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e;
 helo=mail-pj1-x102e.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Ve9Rmq4e; dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cz2Vn3fb7zDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2020 10:48:32 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id z12so3682726pjn.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2020 15:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YkWZE9sjUg9xxYL4ZcA+07tjebgpZAPhGBWV+5f2kKY=;
 b=Ve9Rmq4el4TAX9ersDo7lFAQUnAEDCVJyoCGeoIR/si+qQUPgTg+lBuKJd7tls8qvT
 q08UTOqu2szrN5E7MeyTdnwKsObPb97Fl38R5hDgvDxDNPKGOqdzK/3RaDTmvsk4uxW9
 DBE8/C+wCmeFMMEYnDtt5rz3Iqo5qzxMNgI3mhQmysTJf8Uxd16UaosTIQ+dTGmlbmlf
 IWkPMeemtbO4RtgZDPawdxB0Ys18IsPgKAHCEd7cQ4TsWnH0+PwZ7eQVT5t//0crluYd
 XO9TpDJB6AgH5K0SfOOGzTqvtzIkXDOzLBcSUK7t5ufKLfT4ws6FMqVM5sH12vcbQnc+
 Ketw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YkWZE9sjUg9xxYL4ZcA+07tjebgpZAPhGBWV+5f2kKY=;
 b=QHIbzr4jqFc3I/MT3B14687I6YA4wKpCGihOv6Kcy+QBy2l+4JGoznQPGl40XcOJJq
 ZFyK/cQNQJG+iYuDR4BudwjVEtbvrm5APsUezkwUSgSzfIVxP70CvFeQ1EWOsk+4Ehur
 FInD0pssEVPVM9QJFLwktFWXa/26LwjnxTYDJCSsBGBuY8yXW2d8+MdIoPMqKFEY0+Lk
 xTgZS6mPDdiOeBjm/0WMbNi05sETLLYlIonwBcqeWQFpwW85/umDQ++5b9qS6YLNu5tY
 cm8vHYPzgHgSRQsNFaGUf4lboU0y88sjGmOmSISutrtz74OskvWc+6xNK6LZBnEWr6Ny
 aRMA==
X-Gm-Message-State: AOAM533GFN6Dw2SNroxqFcojWFzquBAPBExkDmCGU4LQBSK4nL2X37NR
 LMm/IQRnr1RSNcD1fJWkzY5qqzOwEPk=
X-Google-Smtp-Source: ABdhPJz4BgNMLAj2Ud5jARxXQcadx0cO0xKzaz6UjrjbxfwUJwlp9ZgzMR8jr2jb1xVjZNR6Koc2hQ==
X-Received: by 2002:a17:902:7c92:b029:da:d86b:78be with SMTP id
 y18-20020a1709027c92b02900dad86b78bemr10576044pll.0.1608421710375; 
 Sat, 19 Dec 2020 15:48:30 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-97-30.tpgi.com.au. [193.116.97.30])
 by smtp.gmail.com with ESMTPSA id k15sm12729275pfh.40.2020.12.19.15.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Dec 2020 15:48:29 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 4/5] powerpc/64s/radix: implement complete
 radix__ptep_get_and_clear_full
Date: Sun, 20 Dec 2020 09:48:12 +1000
Message-Id: <20201219234813.830747-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201219234813.830747-1-npiggin@gmail.com>
References: <20201219234813.830747-1-npiggin@gmail.com>
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

Currently the radix variant is only called when full=true. Allow
radix to take over the entire function.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++-------
 arch/powerpc/include/asm/book3s/64/radix.h   |  4 ++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 058601efbc8a..410a917c0c60 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -483,14 +483,10 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 					    unsigned long addr,
 					    pte_t *ptep, int full)
 {
-	if (full && radix_enabled()) {
-		/*
-		 * We know that this is a full mm pte clear and
-		 * hence can be sure there is no parallel set_pte.
-		 */
+	if (radix_enabled())
 		return radix__ptep_get_and_clear_full(mm, addr, ptep, full);
-	}
-	return ptep_get_and_clear(mm, addr, ptep);
+	else
+		return ptep_get_and_clear(mm, addr, ptep);
 }
 
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index c7813dc628fc..2491f3befda0 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -185,6 +185,10 @@ static inline pte_t radix__ptep_get_and_clear_full(struct mm_struct *mm,
 	unsigned long old_pte;
 
 	if (full) {
+		/*
+		 * We know that this is a full mm pte clear and
+		 * hence can be sure there is no parallel set_pte.
+		 */
 		old_pte = pte_val(*ptep);
 		*ptep = __pte(0);
 	} else
-- 
2.23.0

