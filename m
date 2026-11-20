Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAC606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNxza/ux
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tQ2XZDz308Q;
	Fri, 20 Nov 2026 15:04:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147454;
	cv=none; b=CiVWma8EKxhCqIMITz6VQ0P15vYpBP4I6zGqFtOuMBVvKK8ukj4a9e7RvKf3gjBa+zZa3inmHTfCnwo8wYlSwNigwdDCE1KkqDAjl2iDJbgFrcOM02NEsBHVtW2Yi6PCs0ZDZ2G+o3HaDp9lG/jiAdtXtLACzLkwxLIzjvV4q5wCaZ94gs0t2XkT5xmw6xAQ7LtwAWPE/HTh/ki7/lfDugOKwz85Laowy9Ut+yrwGhHJwE92PUr4kOAyoIMt079plt6Uasf5oG4u+lObnyBPIxJyKV5JVU0O8UsJVUT7zXWY8dGvZmfSgbSu1b+mRhZrI/LAJ8FX99+8XjYIW6UHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147454; c=relaxed/relaxed;
	bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTnAX00cy/U/jur8ebJqf3r7jomONaynGRErNHkElbRZlWCmB2zPntirEwHbc/+c0aKisuBDX4ivWAnsyr7lm0Suih/pzdQm3askv+xIZdVCWE3Y+rM8C/VSDEH872KZgPWENZKTHZqgmSTbFy48YeySST4RVRKvuot6UwUivC0Bx1+9c8R7fkV0jyj3/OXPRlQwW/FtACfbtjRySb0v5kI+0GXCBELzjGcmbXS1JOM20iBviAvLH3hZ9Nb51emIXNbk/QkSuDOJGu67GxbdJ6JOmVEALBlNTgp+HnIX4B3SuItKitLb2VZaCPArPIuQOoEX+UAH6tH3hL/LPc9BHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNxza/ux; dkim-atps=neutral; spf=pass (client-ip=74.125.82.169; helo=mail-dy1-f169.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNxza/ux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.169; helo=mail-dy1-f169.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tP5Y1sz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:13 +1100 (AEDT)
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3712b6d9843so373085eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147451; x=1795752251; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
        b=gNxza/uxM5Wv51p1PYUckRgsQBpy7W6GqVeCG1hKzmNqpOHabm05auwUrWM643L1tU
         5N/dBxAGj0pxGaZUSUomeWVu2Vt7f6QA9DUTE4EUIbchYceioGWqf9gc6kWdIzeX1Ben
         UMoSVKdTufn2/CtwQb7206DY516YAN0TsVRIWqaM0/MzoGGKh1+URkoEzbwJGTg7O/th
         jD84BqGel/adthjm2sBg8AoAqi+pVHJ71q5wznASV8R1srgqHtO5XyDBcPHV9G95JKww
         8ICb7t4yFeVpwdx1mydC7u1ALxphlWSRW6SpR/yjemnJR+yF994pSLVNyY84p4fFRjU+
         cQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147451; x=1795752251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
        b=Fe6CGLdiKlcOl/9blIqyh6GFBerfZ8lavXjoLU30OEQJB1RwgB2n6qBk2Hcfu2mf/M
         MO9A0MMLK2cSqPlpMeQFCo9eNTx0stHpQS2erl2Y7rSH9iRJa404w9b2JFHgPDtISbXs
         D6WzCGh8AbCfDG6jmPkkf8WJeDp/VBnyquWkNl7NJtM6HMbG3prfhLZCyBqBy5VfiBIA
         kJ6F7s6z7GJTCGqhX0CzPYrC4nGeL/PO1fDO/zPE0TCrWIdplti1gbEfuVBLx8k17Yhm
         HEc99aQVBO7dFqWHmTa2xC4N9Mdu7E/nYvGocUqfTllQjO9vwDi5QQsv0z7Owk+mnEeX
         GL2A==
X-Gm-Message-State: APuU4Z90wFMC2JW6BhHQXY+fvF5vosx98dfW9ZfXUxsXcLI2baN4FUlj
	e8+fiAoMrHtEULGXkVULFmD07QjzYPbRFB9a5bHlth6obegEZItyFbuzXzmXfQ==
X-Gm-Gg: AZFdTZcc6iPQN6e2qw72R8EE4fu0VsoDFYoGTa4sOay+nO3+dgEepUFtuAmW8274YGh
	Wq3nzom1MPGyl+0Xt8AHw0zohfgsE6A95/+/cnADzttFNx7aw9g6aqvZERDXm/INLiAKbiGZUdi
	s2zcFKeRBhWMYuWW2Uondd/g48pFI7zp8Hv/lTGxiZGB2eMs4aJYu3D0Z5jKZSWJwMGUx2phcCi
	rHfnHUQU+4SgVn0cOa2/YLCETQmdy9rco/9o9KCG82Tz1SX9bUfUZrDeUdCxCS9JPzDt8gR9U+y
	J33ApoUdiWwNYpnY0U80ec7sUHym58kGapzBqxG8ePnvkGGhIC+4mxjnOdKHifD8efAMkdk8e++
	grdnlFhMhSqND+BsqGadK3Zzf2BxNDe1CfUl+wbhc2iMegaaWOSU+dkRL7VrEMLsgBImSikBX7w
	Q9UTVr6vLZXgk939HW/KIaDaJ7q9LDfI5yKPjhsxWo0+GGJcT80dMj1WFE0Gtkvp71JNV6vIZMB
	N0JYNxLMfQS/ooQ8oxlnmx1R/hdgcNhgH/wTqgBBGRoWI5qZ6J/gYFcVlvsp5IskP9f98iT/ye2
	34E9fWUEh8sQaEK0pSaHg6ee6t9ANnYnLA==
X-Received: by 2002:a05:7300:3e93:b0:36c:a390:8907 with SMTP id 5a478bee46e88-3857015eaedmr1563624eec.21.1795147450757;
        Thu, 19 Nov 2026 20:04:10 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:10 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 10/19] powerpc/pseries: Rework hash flush to remove conditional locking
Date: Fri, 20 Nov 2026 09:33:09 +0530
Message-Id: <03832ac89faab1cbd16d0e9503ed44ed38b82cd0.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's compiler based static context analysis does not work with locks
that are conditionally taken like in pSeries_lpar_flush_hash_range().

This also simplifies the function definition in my opinion - so this
is also a win.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 31 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index abd77c45cbf4..5dbf447d3a83 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1526,28 +1526,19 @@ void __init pseries_lpar_read_hblkrm_characteristics(void)
 					bpsize, idx, hblkrm_size[bpsize][idx]);
 }
 
-/*
- * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
- * lock.
- */
-static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+static void pSeries_lpar_flush_hash_range_unlocked(unsigned long number, int local)
 {
 	unsigned long vpn;
 	unsigned long i, pix, rc;
-	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
-	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
 	unsigned long index, shift, slot;
 	real_pte_t pte;
 	int psize, ssize;
 
-	if (lock_tlbie)
-		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
-
 	if (is_supported_hlbkrm(batch->psize, batch->psize)) {
 		do_block_remove(number, batch, param);
-		goto out;
+		return;
 	}
 
 	psize = batch->psize;
@@ -1587,10 +1578,24 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 				  param[6], param[7]);
 		BUG_ON(rc != H_SUCCESS);
 	}
+}
 
-out:
-	if (lock_tlbie)
+/*
+ * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
+ * lock. Firmware with MMU_FTR_LOCKLESS_TLBIE does not need it.
+ */
+static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+{
+	unsigned long flags;
+
+	if (!mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE)) {
+		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
+		pSeries_lpar_flush_hash_range_unlocked(number, local);
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
+		return;
+	}
+
+	pSeries_lpar_flush_hash_range_unlocked(number, local);
 }
 
 static int __init disable_bulk_remove(char *str)
-- 
2.39.5


