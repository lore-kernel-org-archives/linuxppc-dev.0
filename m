Return-Path: <SRS0=k87x=4T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8656C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 01:08:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F29B24699
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 01:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhR93sV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F29B24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48W27x6YPXzDqt0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 12:08:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rhR93sV7; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48W25j3HtXzDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2020 12:06:17 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i13so4720495pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2020 17:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3n6Mg05RsiWbegkZ8ne7xswmXHbsiqnCeIaB9X/zSk0=;
 b=rhR93sV7XTZMopqdSO7ACjn2L7yzbt3oASDnp6lzpGrNZQ0szvkoH7GqNN2skfon5c
 c2tPC2+REbKdWKmTeRG8JSpiuJWWPRO5aWVwPZcPijeyQul7r/8KtHxSj0YTz3TJnGxp
 XQlb75DtdPPn8tC7Wpn8zgA5ugcQ07FKHeLQCvBNW/hU79bpPqS7/1aFySdg8fpbzTGT
 oMg/bBBR2dJ6JeB/w0FuHz7WRg4lHJ/ByJ7P1hJKK0JyK5Ji5nbqEMhpZG1xHeCEEmWm
 iGqlFwDHJfm61cgE/CBvTZtcwOFlnnFl013Hhvu1W20txaEsKoCAxWpio103rhskwiRT
 spdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3n6Mg05RsiWbegkZ8ne7xswmXHbsiqnCeIaB9X/zSk0=;
 b=W8MJSN2NCY6oK14dQueth5pWXi+9WlefLRL1bO36+Q2Lv7R4/We4jQSdWSNkFGPZbi
 4shBWW6iy3kOb+znpqu/3k/rZ5Or68/Sg6VH5z7DaIk+Uz7knzhBD4hkBazCeWMFVAlG
 kEQAdI3Z+LGTgU8/OlwrpCHOMB9yjfk78mWIoW3lkgbGt58u2GW2Nl62Q3AOgNJQr+sa
 CSZUAXLTB6/sPdKutMTlCoiPaSEj/AsF77KmH208UpKMN09sADI6MY99d45aMFDGjDMl
 O84JS+Tg5SHBtRzhp+PwnxccPIkAxAP++T43rb+asqL28Xi+7+zYphObJP0f7ZsvatKN
 YVaA==
X-Gm-Message-State: APjAAAUy22FWt6bhSDELWXl7XVUIsL7xmhGGqp0o9awrMHAC1hNM1BpL
 d4kYE8aubWC/Ebf8eMsEnFsvRGZZ
X-Google-Smtp-Source: APXvYqx4WNv7F1V9qmjMjqEV5/nwDgeleZLF4NYc0z9m4M35WKkj9olJz9k0/ucRc9e1iWfONSrpWg==
X-Received: by 2002:aa7:84c6:: with SMTP id x6mr14928207pfn.181.1583111174107; 
 Sun, 01 Mar 2020 17:06:14 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-117-248.tpgi.com.au.
 [193.116.117.248])
 by smtp.gmail.com with ESMTPSA id f124sm2176274pfg.9.2020.03.01.17.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 17:06:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/radix: Fix !SMP build
Date: Mon,  2 Mar 2020 11:04:10 +1000
Message-Id: <20200302010410.2957362-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 1 +
 arch/powerpc/mm/book3s64/radix_tlb.c     | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index dd1bea45325c..2a9a0cd79490 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -26,6 +26,7 @@
 #include <asm/firmware.h>
 #include <asm/powernv.h>
 #include <asm/sections.h>
+#include <asm/smp.h>
 #include <asm/trace.h>
 #include <asm/uaccess.h>
 #include <asm/ultravisor.h>
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 03f43c924e00..758ade2c2b6e 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -587,6 +587,11 @@ void radix__local_flush_all_mm(struct mm_struct *mm)
 	preempt_enable();
 }
 EXPORT_SYMBOL(radix__local_flush_all_mm);
+
+static void __flush_all_mm(struct mm_struct *mm, bool fullmm)
+{
+	radix__local_flush_all_mm(mm);
+}
 #endif /* CONFIG_SMP */
 
 void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
@@ -777,7 +782,7 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 EXPORT_SYMBOL(radix__flush_tlb_page);
 
 #else /* CONFIG_SMP */
-#define radix__flush_all_mm radix__local_flush_all_mm
+static inline void exit_flush_lazy_tlbs(struct mm_struct *mm) { }
 #endif /* CONFIG_SMP */
 
 static void do_tlbiel_kernel(void *info)
-- 
2.23.0

