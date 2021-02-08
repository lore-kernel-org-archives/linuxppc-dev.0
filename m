Return-Path: <SRS0=fNlO=HK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138CAC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 06:37:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2607364E59
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 06:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2607364E59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DYxCZ5G9LzDr3b
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 17:37:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635;
 helo=mail-pl1-x635.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=o8ulvJ2x; dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DYx7s5V1XzDsqM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2021 17:34:17 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id j11so7261297plt.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Feb 2021 22:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A5rizOXW4dqC+bufM3Tr8OQnOdP81xoMYV/zbnkwIQ0=;
 b=o8ulvJ2xQ94gW+/prh5LYSZcHaGLxRIeJkxJOVpkz65pJMMgyzHa7YWBws/2mclq1E
 BLx66CXxHQqxfph35oE0NsNMNO8rvRganIEd0Fb+XLGNXSBxbtfSLdt7soE27hSf09Ib
 h2W3Qc/alYIBo3cbnLRnEHC4hWgIGdwyiZXAfN79nrBcBipI4PsvioGvz6tCpCFdKxPb
 PCMJfTYz1Q5l2FXs1yjPKHGUwbo2Ao2cT0N9hgdSXijsoeIbSzGqsPF3HcX0PleYFE8R
 /uJpM1PEiDBtowcEVsrib/C9h9UVhscbm+P7pfh/uP4HZ32ymgvOV+JJrS8CgNH8Riwj
 5CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A5rizOXW4dqC+bufM3Tr8OQnOdP81xoMYV/zbnkwIQ0=;
 b=N8+lSAxdeVWqekjyR+0hgH8RxsBm21uXCOYIQ+xxoSuA2WtNSAgUa/CuuQoOBNqHB8
 q0pwL3/JuSnFY0c60lCcD5GHyQpQKgceTTZaemAD0es3Ydm2VGAPO4DnCD8onUsfdh1D
 vZzAhAcvf9UO9qko+DqoEYAGnSKiCD5IV97aQ2bZGDVC9gYgxg0fCbZwHUfvuuE2FFhc
 4UbfLvDoXeOGaWOb+0II39p+UOTCzaSiqpJSrC4M5OCGYooqlAflpZuwoY9l1G3VePpr
 0VnGPjS4odZf33+5cLcQXc/tI+crIEhUO3nNXOzBJ+6KC/XShMpjn95YdPNxsnvqfb0P
 EMDA==
X-Gm-Message-State: AOAM531wEkFM4PYnrOpqiSRQc3jQkMzda+GDFlLnnMiO6n3BT9j3IiTU
 z/xcSsli7u9CXyG9P0gayQ86KVpOpx4=
X-Google-Smtp-Source: ABdhPJxhpXD220BRmjjPsthfhpIYlEdUb2KYk4hKzIGyL4mf61Hnh/EC+kDxTmz7PHJEEqlQ5Go3MA==
X-Received: by 2002:a17:90b:955:: with SMTP id
 dw21mr729128pjb.19.1612766054454; 
 Sun, 07 Feb 2021 22:34:14 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.132.134.221])
 by smtp.gmail.com with ESMTPSA id hi15sm15032835pjb.19.2021.02.07.22.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Feb 2021 22:34:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s: Remove EXSLB interrupt save area
Date: Mon,  8 Feb 2021 16:34:06 +1000
Message-Id: <20210208063406.331655-1-npiggin@gmail.com>
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

SLB faults should not be taken while the PACA save areas are live, all
memory accesses should be fetches from the kernel text, and access to
PACA and the current stack, before C code is called or any other
accesses are made.

All of these have pinned SLBs so will not take a SLB fault. Therefore
EXSLB is not be required.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paca.h      | 3 +--
 arch/powerpc/kernel/asm-offsets.c    | 1 -
 arch/powerpc/kernel/exceptions-64s.S | 5 -----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 9454d29ff4b4..be0b00cb9fbb 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -108,8 +108,7 @@ struct paca_struct {
 	 */
 	/* used for most interrupts/exceptions */
 	u64 exgen[EX_SIZE] __attribute__((aligned(0x80)));
-	u64 exslb[EX_SIZE];	/* used for SLB/segment table misses
- 				 * on the linear mapping */
+
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
 	u8 slb_cache_ptr;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b12d7c049bfe..31edd9bbce75 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -255,7 +255,6 @@ int main(void)
 #endif /* CONFIG_PPC_MM_SLICES */
 	OFFSET(PACA_EXGEN, paca_struct, exgen);
 	OFFSET(PACA_EXMC, paca_struct, exmc);
-	OFFSET(PACA_EXSLB, paca_struct, exslb);
 	OFFSET(PACA_EXNMI, paca_struct, exnmi);
 #ifdef CONFIG_PPC_PSERIES
 	OFFSET(PACALPPACAPTR, paca_struct, lppaca_ptr);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index dad35b59bcfb..27fa80248406 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1392,13 +1392,9 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
  *   on user-handler data structures.
  *
  *   KVM: Same as 0x300, DSLB must test for KVM guest.
- *
- * A dedicated save area EXSLB is used (XXX: but it actually need not be
- * these days, we could use EXGEN).
  */
 INT_DEFINE_BEGIN(data_access_slb)
 	IVEC=0x380
-	IAREA=PACA_EXSLB
 	IDAR=1
 	IKVM_SKIP=1
 	IKVM_REAL=1
@@ -1481,7 +1477,6 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
  */
 INT_DEFINE_BEGIN(instruction_access_slb)
 	IVEC=0x480
-	IAREA=PACA_EXSLB
 	IISIDE=1
 	IDAR=1
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-- 
2.23.0

