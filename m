Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A37C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 14:42:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C679E2081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 14:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="X73Hfy+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C679E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FYJ3269JzDqDb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 01:42:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="X73Hfy+j"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FYGC6llRzDqDM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 01:40:51 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id s1so17293636qte.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Mar 2019 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=o+Bdw4J7jteKQc6pumb4pNEyFr19MhGJj322ozeVKAE=;
 b=X73Hfy+jKgTjuqzFVd28M5ioPkJ9mXwmLTOSTZrYdEQUA5TVop/Ot2ZfW00VcWXpMZ
 r3TbYV2DQ9hrPMiaouaaEBvRLuaWPu/vcpWnNk8xR65mN49cyMKCE+NNplfwy/vrgmjB
 XyE1y2kl6/PfRWfHlTEfqVoTXzJAEBW59Rjwgz/BHgW5jy3bZUK24SDws7Bl1ATmcfZy
 MoP1gzHmdEZJoeYcUiLsyh0ES3MUjdUggeggXz/JXLCKvF9AwVmSNBltlc+1XwjaUsbD
 znSBf7BpnWwadIF5jX4RSE2S56VimVV3oYP5PKzEs01d71I85Dtloq7fSGNazwVY8eFN
 QUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=o+Bdw4J7jteKQc6pumb4pNEyFr19MhGJj322ozeVKAE=;
 b=hKxqIvEuYaAF/WT9N71eLeApJ/nDeYGLgvqdmWksg9ZvDcYe1Bd4hKy4aB559UoFPT
 3TVwMsOau3CS3QMbX+qwDM18MqgoVkd5VlvXLK0ECQEK3W+FSZlEv9Lll/KjsluBiHyL
 V5Qotm32KXOtZ1WrmGuBwK4bpTMv9XXdAQfI6drNI2ZR1PRnvc4UULitS4GUqGRhNnMS
 TTLLqb0JpsFMoqNz2U8cL65jEfzH9KBAVbBCi/K9IaWAWW5ZfAnBHaZUZnV8sI79TQQJ
 FZUPCvfPdGLQYfo+SDl1rBp0mbzIr8LtiDkGy6GSW/X/1p9IWzAgKIFgio7lMlwsYPbj
 v+fQ==
X-Gm-Message-State: APjAAAUSVJC4yV1NSToFBXJJjr+EUADIRt7J0g2brfPbY0NHbHxbuwpa
 m0P6ihmI2DGL8f320Fwxva2o2Q==
X-Google-Smtp-Source: APXvYqwu4MSml3H1uDeihUyFRS/RjLs9Ov7p9x56I0MUlRQpOvBPZS/PJGIOvIAQHBOQG4cl4Ij1kw==
X-Received: by 2002:a0c:bd15:: with SMTP id m21mr10857078qvg.246.1551969647614; 
 Thu, 07 Mar 2019 06:40:47 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id b83sm2642067qkg.12.2019.03.07.06.40.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Mar 2019 06:40:46 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH v2] powerpc: silence unused-but-set-variable warnings
Date: Thu,  7 Mar 2019 09:40:31 -0500
Message-Id: <20190307144031.52494-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
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
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

pte_unmap() compiles away on some powerpc platforms, so silence the
warnings below by making it a static inline function.

mm/memory.c: In function 'copy_pte_range':
mm/memory.c:820:24: warning: variable 'orig_dst_pte' set but not used
[-Wunused-but-set-variable]
mm/memory.c:820:9: warning: variable 'orig_src_pte' set but not used
[-Wunused-but-set-variable]
mm/madvise.c: In function 'madvise_free_pte_range':
mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]
mm/swap_state.c: In function 'swap_ra_info':
mm/swap_state.c:634:15: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: make it a static inline function.

 arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
 arch/powerpc/include/asm/nohash/64/pgtable.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 868fcaf56f6b..d798e33a0c86 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1006,7 +1006,8 @@ extern struct page *pgd_page(pgd_t pgd);
 	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e77ed9761632..0384a3302fb6 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
   (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
-- 
2.17.2 (Apple Git-113)

