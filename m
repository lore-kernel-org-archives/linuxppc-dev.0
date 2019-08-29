Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B9C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 08:49:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1362189D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 08:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dmJ58rZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1362189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Jx9S47cLzDqHx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 18:49:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="dmJ58rZy"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Jx5B4pYFzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 18:45:18 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46Jx550VJxz9tyrQ;
 Thu, 29 Aug 2019 10:45:13 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=dmJ58rZy; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uLQ2da6dch8H; Thu, 29 Aug 2019 10:45:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46Jx546RwKz9tyrN;
 Thu, 29 Aug 2019 10:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1567068312; bh=PNFuI+n1ZPaNxn5/Zi9ps1C4AGZwoaIqpFEYMkABCKo=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=dmJ58rZyvWKspJm7PztRHXgdKzS8Co5zDrMxPXfqAmIEB0tmb2TMlhnnaYCeMqhVn
 4sK2qzx9KXlZgo8z7XLEKh5HB7DjeYDghnKNZm/H0+37Jeri0PtalqX5eC8SCJOFrT
 EEUGLyS/Ia/kjnd6/udFUOxQbMjWwGlCllckpjO0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F0CF58B8AC;
 Thu, 29 Aug 2019 10:45:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id aJ2MWNxz1Yux; Thu, 29 Aug 2019 10:45:13 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.204.43])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 97DAB8B7B2;
 Thu, 29 Aug 2019 10:45:13 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 58D77696C1; Thu, 29 Aug 2019 08:45:13 +0000 (UTC)
Message-Id: <a28a20514d5f6df9629c1a117b667e48c4272736.1567068137.git.christophe.leroy@c-s.fr>
In-Reply-To: <dd82934ad91aab607d0eb7e626c14e6ac0d654eb.1567068137.git.christophe.leroy@c-s.fr>
References: <dd82934ad91aab607d0eb7e626c14e6ac0d654eb.1567068137.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/2] powerpc: cleanup hw_irq.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 segher@kernel.crashing.org, npiggin@gmail.com
Date: Thu, 29 Aug 2019 08:45:13 +0000 (UTC)
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

SET_MSR_EE() is just use in this file and doesn't provide
any added value compared to mtmsr(). Drop it.

Add a wrtee() inline function to use wrtee/wrteei insn.

Replace #ifdefs by IS_ENABLED()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: Changed wrtee()/wrteei() to a single wrtee() inline which uses wrtee
    or wrteei depending on the constness of the argument (Nick's idea).

v3: no change
---
 arch/powerpc/include/asm/hw_irq.h | 57 ++++++++++++++++++---------------------
 arch/powerpc/include/asm/reg.h    |  8 ++++++
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 32a18f2f49bc..e3a905e3d573 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -226,8 +226,8 @@ static inline bool arch_irqs_disabled(void)
 #endif /* CONFIG_PPC_BOOK3S */
 
 #ifdef CONFIG_PPC_BOOK3E
-#define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory")
-#define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory")
+#define __hard_irq_enable()	wrtee(MSR_EE)
+#define __hard_irq_disable()	wrtee(0)
 #else
 #define __hard_irq_enable()	__mtmsrd(MSR_EE|MSR_RI, 1)
 #define __hard_irq_disable()	__mtmsrd(MSR_RI, 1)
@@ -280,8 +280,6 @@ extern void force_external_irq_replay(void);
 
 #else /* CONFIG_PPC64 */
 
-#define SET_MSR_EE(x)	mtmsr(x)
-
 static inline unsigned long arch_local_save_flags(void)
 {
 	return mfmsr();
@@ -289,47 +287,44 @@ static inline unsigned long arch_local_save_flags(void)
 
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-#if defined(CONFIG_BOOKE)
-	asm volatile("wrtee %0" : : "r" (flags) : "memory");
-#else
-	mtmsr(flags);
-#endif
+	if (IS_ENABLED(CONFIG_BOOKE))
+		wrtee(flags);
+	else
+		mtmsr(flags);
 }
 
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags = arch_local_save_flags();
-#ifdef CONFIG_BOOKE
-	asm volatile("wrteei 0" : : : "memory");
-#elif defined(CONFIG_PPC_8xx)
-	wrtspr(SPRN_EID);
-#else
-	SET_MSR_EE(flags & ~MSR_EE);
-#endif
+
+	if (IS_ENABLED(CONFIG_BOOKE))
+		wrtee(0);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_EID);
+	else
+		mtmsr(flags & ~MSR_EE);
+
 	return flags;
 }
 
 static inline void arch_local_irq_disable(void)
 {
-#ifdef CONFIG_BOOKE
-	asm volatile("wrteei 0" : : : "memory");
-#elif defined(CONFIG_PPC_8xx)
-	wrtspr(SPRN_EID);
-#else
-	arch_local_irq_save();
-#endif
+	if (IS_ENABLED(CONFIG_BOOKE))
+		wrtee(0);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_EID);
+	else
+		mtmsr(mfmsr() & ~MSR_EE);
 }
 
 static inline void arch_local_irq_enable(void)
 {
-#ifdef CONFIG_BOOKE
-	asm volatile("wrteei 1" : : : "memory");
-#elif defined(CONFIG_PPC_8xx)
-	wrtspr(SPRN_EIE);
-#else
-	unsigned long msr = mfmsr();
-	SET_MSR_EE(msr | MSR_EE);
-#endif
+	if (IS_ENABLED(CONFIG_BOOKE))
+		wrtee(MSR_EE);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_EIE);
+	else
+		mtmsr(mfmsr() | MSR_EE);
 }
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index b17ee25df226..a18e629d9951 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1362,6 +1362,14 @@ static inline void mtmsr_isync(unsigned long val)
 #define wrtspr(rn)	asm volatile("mtspr " __stringify(rn) ",0" : \
 				     : : "memory")
 
+static inline void wrtee(unsigned long val)
+{
+	if (__builtin_constant_p(val))
+		asm volatile("wrteei %0" : : "i" ((val & MSR_EE) ? 1 : 0) : "memory");
+	else
+		asm volatile("wrtee %0" : : "r" (val) : "memory");
+}
+
 extern unsigned long msr_check_and_set(unsigned long bits);
 extern bool strict_msr_control;
 extern void __msr_check_and_clear(unsigned long bits);
-- 
2.13.3

