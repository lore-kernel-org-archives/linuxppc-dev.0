Return-Path: <SRS0=3O72=4C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E9FC35242
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 06:54:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6852082F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 06:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LhTXZqO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6852082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Jkdf1sZhzDqWn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=LhTXZqO/; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Jkbh5Z9dzDqWn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2020 17:53:04 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48Jkbc3MLZz9tyVn;
 Fri, 14 Feb 2020 07:53:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=LhTXZqO/; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id tLPVScggPYMq; Fri, 14 Feb 2020 07:53:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48Jkbc2KX3z9tyVm;
 Fri, 14 Feb 2020 07:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1581663180; bh=PznlyhTfVjsLdMRcw5jtGZY9T5cbjSYoG6t4AKdJfBI=;
 h=From:Subject:To:Cc:Date:From;
 b=LhTXZqO/+RdZvQAIo7mr/JLoI7+aitamijtkPi08C01RM3H/k9qbnNvev/fYvIc8a
 MXJ5Rpdrbd6ePIjyo6BaV48wKWBAFXD4BBfpfwpBlRQPY3GN2FjcHV6q4MK/yZfgpF
 QsWvysu4KoaSuNZRI3tKCwSuKvuvY2saCQ20UTwQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 344608B878;
 Fri, 14 Feb 2020 07:53:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xk75eBqZoejo; Fri, 14 Feb 2020 07:53:01 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 057048B874;
 Fri, 14 Feb 2020 07:53:01 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A1580652F5; Fri, 14 Feb 2020 06:53:00 +0000 (UTC)
Message-Id: <7bce32ccbab3ba3e3e0f27da6961bf6313df97ed.1581663140.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/6xx: Fix power_save_ppc32_restore() with
 CONFIG_VMAP_STACK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Larry Finger <Larry.Finger@lwfinger.net>
Date: Fri, 14 Feb 2020 06:53:00 +0000 (UTC)
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

power_save_ppc32_restore() is called during exception entry, before
re-enabling the MMU. It substracts KERNELBASE from the address
of nap_save_msscr0 to access it.

With CONFIG_VMAP_STACK enabled, data MMU translation has already been
re-enabled, so power_save_ppc32_restore() has to access
nap_save_msscr0 by its virtual address.

Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 arch/powerpc/kernel/idle_6xx.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 0ffdd18b9f26..433d97bea1f3 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -166,7 +166,11 @@ BEGIN_FTR_SECTION
 	mfspr	r9,SPRN_HID0
 	andis.	r9,r9,HID0_NAP@h
 	beq	1f
+#ifdef CONFIG_VMAP_STACK
+	addis	r9, r11, nap_save_msscr0@ha
+#else
 	addis	r9,r11,(nap_save_msscr0-KERNELBASE)@ha
+#endif
 	lwz	r9,nap_save_msscr0@l(r9)
 	mtspr	SPRN_MSSCR0, r9
 	sync
@@ -174,7 +178,11 @@ BEGIN_FTR_SECTION
 1:
 END_FTR_SECTION_IFSET(CPU_FTR_NAP_DISABLE_L2_PR)
 BEGIN_FTR_SECTION
+#ifdef CONFIG_VMAP_STACK
+	addis	r9, r11, nap_save_hid1@ha
+#else
 	addis	r9,r11,(nap_save_hid1-KERNELBASE)@ha
+#endif
 	lwz	r9,nap_save_hid1@l(r9)
 	mtspr	SPRN_HID1, r9
 END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
-- 
2.25.0

