Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C097C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:19:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE6720833
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WP5Us3dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE6720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qx6K3JBDzDqbW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:19:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="WP5Us3dr"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwtZ4M7DzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:08:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwtV2zYrz9tyx9;
 Thu, 31 Jan 2019 11:08:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=WP5Us3dr; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id f_Cx-BALeWtb; Thu, 31 Jan 2019 11:08:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtV1wpQz9tyxG;
 Thu, 31 Jan 2019 11:08:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929330; bh=2AIBksWfuLJ4qYgayWNoPI2SAljH0iKAyuSsmU07n+w=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=WP5Us3drivsgS2YVCq9tdD0EeiPVQ6pcxfNGVle4zPJ9D8QXYZxE63d+ol1ZRfHpu
 L/EXFrpDcao9NR3+tBixyqoR+dUvagEuUS3RrIQTWJMK9kjxTAEmqFZws9mjlvnVAo
 19JDSeln+qAFx1g+tLo0u0bQHwOUW/L+rS27FViU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 45ABA8B814;
 Thu, 31 Jan 2019 11:08:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id pA6xrcIFLW1H; Thu, 31 Jan 2019 11:08:51 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F0D928B78D;
 Thu, 31 Jan 2019 11:08:50 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 959B872E14; Thu, 31 Jan 2019 10:08:50 +0000 (UTC)
Message-Id: <d349e5fc66cfe43aa9f37fa57e4728e980766449.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 04/13] powerpc: Only use task_struct 'cpu' field on SMP
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 31 Jan 2019 10:08:50 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When moving to CONFIG_THREAD_INFO_IN_TASK, the thread_info 'cpu' field
gets moved into task_struct and only defined when CONFIG_SMP is set.

This patch ensures that TI_CPU is only used when CONFIG_SMP is set and
that task_struct 'cpu' field is not used directly out of SMP code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/head_fsl_booke.S | 2 ++
 arch/powerpc/kernel/misc_32.S        | 4 ++++
 arch/powerpc/xmon/xmon.c             | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 2386ce2a9c6e..2c21e8642a00 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -243,8 +243,10 @@ set_ivor:
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
+#ifdef CONFIG_SMP
 	CURRENT_THREAD_INFO(r22, r1)
 	stw	r24, TI_CPU(r22)
+#endif
 
 	bl	early_init
 
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 57d2ffb2d45c..02b8cdd73792 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -183,10 +183,14 @@ _GLOBAL(low_choose_750fx_pll)
 	or	r4,r4,r5
 	mtspr	SPRN_HID1,r4
 
+#ifdef CONFIG_SMP
 	/* Store new HID1 image */
 	CURRENT_THREAD_INFO(r6, r1)
 	lwz	r6,TI_CPU(r6)
 	slwi	r6,r6,2
+#else
+	li	r6, 0
+#endif
 	addis	r6,r6,nap_save_hid1@ha
 	stw	r4,nap_save_hid1@l(r6)
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 757b8499aba2..a0f44f992360 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2997,7 +2997,7 @@ static void show_task(struct task_struct *tsk)
 	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp,
 		tsk->pid, rcu_dereference(tsk->parent)->pid,
-		state, task_thread_info(tsk)->cpu,
+		state, task_cpu(tsk),
 		tsk->comm);
 }
 
-- 
2.13.3

