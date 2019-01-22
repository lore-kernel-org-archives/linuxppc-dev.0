Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F4C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:52:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7383220861
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSOrIepQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7383220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kJyX3XzYzDqMq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 17:52:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSOrIepQ"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kJqJ3pvVzDqMh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 17:46:36 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id g189so10584796pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 22:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=t5lBJ0rsrj4CyNHrj3kCOGblwu74q9YnudIM+f87H9A=;
 b=KSOrIepQqfk48ohUmhPO4YYGHuj0vOiLCNYm3QMQWrT5THImiwr6pNHkARYyuuD9+J
 y1ZIGnknhviC2H5yUVSwt3jfyWLma050MZCk8uAkDVeTHEoEHrn04r/StdUzEw4zqq+6
 jMXlg0Ax+bCD7SyWgtOVuGsXyZtdCaFWFUAVIBGkGTHAh2kyG5t3B4R0usnSRpZA+My0
 tfsg9pHiBM7PTsLwhwnh5Ky5pVtNCWwiVxfVyPvprqoAa91eWpcIqzppCxz6sEHG5wqJ
 VeYq3GHR0Kp0GFnY4IccPqJilJWpYAcroCxHa21dLIBZfZENDXPaI5vXg80DC0GskAla
 azIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=t5lBJ0rsrj4CyNHrj3kCOGblwu74q9YnudIM+f87H9A=;
 b=koyaklOWftSr1Lp53D5Xd+Rzig+LCa44UwiQMr6T8V/fW8f3YxYMYTxvip8dkzIL1U
 73rW90o/TvY6NNngScFLGqSzBH82osnYxxUOk8cK6La0rGXiveBPCBtk7G1ThbGMm3G+
 vdoyXgEzfNZ1PsOBzRXdI7RLS9peFdag+RMu2N9Ey9+q3XbLsJ6Tw4mKBbo4f4Eiwxfp
 fQVdykNXJlWX/7FPRfXJfhZg3aA/O7hhujfIw59eBBVoJ4riaVSfAk8X4ynl2844tOdU
 UAMH8SRfoiA/i8+w7gz3unMYfTonnPH0UZJcan8zJNwUKp3JKVvkc4reTeoNqgpBY6qT
 /PLg==
X-Gm-Message-State: AJcUukc+Lfx+d/rm20tc0B0LzYTF7w0X6dPtCg6TIuSRd0Tiq/Jjkmui
 aavYKLDGbVnXuPDvmaSLlfM0L/yB
X-Google-Smtp-Source: ALg8bN5bsqvr3p3gBJyuR528b/h7beXIyAoIz6cciepNHANdCzOQJuWN49vv/ts4JS8TFhNSN94N1g==
X-Received: by 2002:a63:5a08:: with SMTP id o8mr30570005pgb.185.1548139594737; 
 Mon, 21 Jan 2019 22:46:34 -0800 (PST)
Received: from roar.local0.net (193-116-118-220.tpgi.com.au. [193.116.118.220])
 by smtp.gmail.com with ESMTPSA id v15sm18341830pfn.94.2019.01.21.22.46.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 22:46:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/64s: Prepare to handle data interrupts vs d-side
 MCE reentrancy
Date: Tue, 22 Jan 2019 16:46:17 +1000
Message-Id: <20190122064618.1510-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122064618.1510-1-npiggin@gmail.com>
References: <20190122064618.1510-1-npiggin@gmail.com>
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

The subsequent patch needs to change data interrupts (those that set
DAR / DSISR) in order to cope with a recoverability bug with MCE
interrupts.

This patch prepares for the fix by removing a couple of layers of
macro indirection from the interrupt handlers, and also makes the
0x300 interrupt out of line (as required by the next patch).

Functionality should be unchanged, and code unchanged except for the
OOL change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 45 ++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..0d91d1c8aad1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -566,8 +566,23 @@ EXC_COMMON_BEGIN(mce_return)
 	RFI_TO_KERNEL
 	b	.
 
-EXC_REAL(data_access, 0x300, 0x80)
-EXC_VIRT(data_access, 0x4300, 0x80, 0x300)
+EXC_REAL_BEGIN(data_access, 0x300, 0x80)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	tramp_real_data_access
+EXC_REAL_END(data_access, 0x300, 0x80)
+
+TRAMP_REAL_BEGIN(tramp_real_data_access)
+EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x300)
+EXCEPTION_PROLOG_2(data_access_common, EXC_STD)
+
+EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x300)
+EXCEPTION_PROLOG_2_RELON(data_access_common, EXC_STD)
+EXC_VIRT_END(data_access, 0x4300, 0x80)
+
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
 
 EXC_COMMON_BEGIN(data_access_common)
@@ -596,11 +611,17 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-EXCEPTION_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, KVMTEST_PR, 0x380);
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXSLB)
+EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
+EXCEPTION_PROLOG_2(data_access_slb_common, EXC_STD)
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
-EXCEPTION_RELON_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, NOTEST, 0x380);
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXSLB)
+EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+EXCEPTION_PROLOG_2_RELON(data_access_slb_common, EXC_STD)
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
@@ -703,8 +724,20 @@ TRAMP_KVM_HV(PACA_EXGEN, 0x500)
 EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 
 
-EXC_REAL(alignment, 0x600, 0x100)
-EXC_VIRT(alignment, 0x4600, 0x100, 0x600)
+EXC_REAL_BEGIN(alignment, 0x600, 0x100)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x600)
+EXCEPTION_PROLOG_2(alignment_common, EXC_STD)
+EXC_REAL_END(alignment, 0x600, 0x100)
+
+EXC_VIRT_BEGIN(alignment, 0x4600, 0x100)
+SET_SCRATCH0(r13)		/* save r13 */
+EXCEPTION_PROLOG_0(PACA_EXGEN)
+EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x600)
+EXCEPTION_PROLOG_2_RELON(alignment_common, EXC_STD)
+EXC_VIRT_END(alignment, 0x4600, 0x100)
+
 TRAMP_KVM(PACA_EXGEN, 0x600)
 EXC_COMMON_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
-- 
2.18.0

