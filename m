Return-Path: <SRS0=3gej=EX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69743C71155
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 14:02:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177FC20A8B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 14:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmLjpiBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177FC20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cb71Q5XT0zDqSY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 01:02:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PmLjpiBQ; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cb6tR4wr2zDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 00:56:30 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id a18so17333276pfl.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t4SJB4YbRl5B4MeSiy1HFdk1USDyn/nEsoq1u8bjNIo=;
 b=PmLjpiBQuy/dWIkb1kpYuV9XtHFFZg7Qosc6YZ7mcWTdXLIU5CkkVhg5D0YEIxdlHK
 OcatU2VPPlZZlpDD1Lr310UjbB5FY93+H8/wBBswbWW95RD8esZ87r3PvFk/GAvGEAzX
 rG3iBZSoFnKzYgcBFpOnn406iiWWjufjS8a3GxnvZudS64WggpxyLFbdcELenjNwB8uS
 TIs/llb+TmzETNqfbUOvUjrJUyckPbaVFno354a4uR4RSg/pAL5agi7XJCGAOV5SiCTD
 n7heo1oQApPtB8gEwvSK+8dgKc57SjC776RnJtS4OvRxCZA8nzkf+unikxZwjsn35Btp
 JIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t4SJB4YbRl5B4MeSiy1HFdk1USDyn/nEsoq1u8bjNIo=;
 b=DBbqrOKDPnB9k/pr9M4xNtksZf8TpxenAAjh3UQfIxVmr28soS8hKnxM4GdMh8D6wL
 PXxGuc+wktE0lI0eEbljDGiUdm+DaKt8g2Rzhva63EgA4wpuOantDX7TUzHJABdH7NTN
 J4//Ko9qIXSYeOGc+z+INjzhjf5Dcg8jkPLee3KabDggWpYfob6nVdz6zucR+y91opIx
 Q4Cao87WNWZUF9aWhnz8C6TGnJZCl0t5rmmlcxJoSSZTXz6gqgg+xKpS8dchWwJuRPFv
 77iPKfWXpmcsS2brtJFzNMWKPXCY1aeDBjzrxg4Ie5MerDAcPNi78yzE2qgkVwVfPg9v
 Fm0A==
X-Gm-Message-State: AOAM533Xa3/z70Hn37RIlAIBwkSZrY68geaiRhjno8oOgNa+lQu++JMP
 Xr4Kwgq7vDQfC+Ag1NAR8gcLFO1jjA0=
X-Google-Smtp-Source: ABdhPJyECMDo82Nu+OwdOhisuYPhda2UPM3DJ35r6/6BMeDv9ttUKUrgGuVVUsfsHJqHqPkDFGk8ew==
X-Received: by 2002:a63:cc50:: with SMTP id q16mr3790165pgi.246.1605621386711; 
 Tue, 17 Nov 2020 05:56:26 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id q12sm21965535pfc.84.2020.11.17.05.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 05:56:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/exception: KVM Fix for host DSI being taken in
 HPT guest MMU context
Date: Tue, 17 Nov 2020 23:56:17 +1000
Message-Id: <20201117135617.3521127-1-npiggin@gmail.com>
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
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 2284ffea8f0c ("powerpc/64s/exception: Only test KVM in SRR
interrupts when PR KVM is supported") removed KVM guest tests from
interrupts that do not set HV=1, when PR-KVM is not configured.

This is wrong for HV-KVM HPT guest MMIO emulation case which attempts
to load the faulting instruction word with MSR[DR]=1 and MSR[HV]=1 with
the guest MMU context loaded. This can cause host DSI, DSLB interrupts
which must test for KVM guest. Restore this and add a comment.

Fixes: 2284ffea8f0c ("powerpc/64s/exception: Only test KVM in SRR interrupts when PR KVM is supported")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f7d748b88705..b67892e2c9f5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1412,6 +1412,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
  *   If none is found, do a Linux page fault. Linux page faults can happen in
  *   kernel mode due to user copy operations of course.
  *
+ *   KVM: The KVM HDSI handler may perform a load with MSR[DR]=1 in guest
+ *   MMU context, which may cause a DSI in the host, which must go to the
+ *   KVM handler. MSR[IR] is not enabled, so the real-mode handler will
+ *   always be used regardless of AIL setting.
+ *
  * - Radix MMU
  *   The hardware loads from the Linux page table directly, so a fault goes
  *   immediately to Linux page fault.
@@ -1422,10 +1427,8 @@ INT_DEFINE_BEGIN(data_access)
 	IVEC=0x300
 	IDAR=1
 	IDSISR=1
-#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_SKIP=1
 	IKVM_REAL=1
-#endif
 INT_DEFINE_END(data_access)
 
 EXC_REAL_BEGIN(data_access, 0x300, 0x80)
@@ -1464,6 +1467,8 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
  *   ppc64_bolted_size (first segment). The kernel handler must avoid stomping
  *   on user-handler data structures.
  *
+ *   KVM: Same as 0x300, DSLB must test for KVM guest.
+ *
  * A dedicated save area EXSLB is used (XXX: but it actually need not be
  * these days, we could use EXGEN).
  */
@@ -1472,10 +1477,8 @@ INT_DEFINE_BEGIN(data_access_slb)
 	IAREA=PACA_EXSLB
 	IRECONCILE=0
 	IDAR=1
-#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_SKIP=1
 	IKVM_REAL=1
-#endif
 INT_DEFINE_END(data_access_slb)
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-- 
2.23.0

