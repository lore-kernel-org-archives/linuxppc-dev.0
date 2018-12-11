Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7171AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:00:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1779520851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1779520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DNS54hJLzDqwT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 13:00:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DNPj5q41zDqhl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 12:58:01 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wBB1vmqJ010864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 19:57:50 -0600
Message-ID: <61ad3646674e6bf541a8f7fb420cdf556d0b2152.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix bogus usage of MSR_RI on BookE and 40x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 11 Dec 2018 12:57:48 +1100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

BookE and 40x processors lack the MSR:RI bit. However, we have a
few common code places that rely on it.

This fixes it by not defining MSR_RI on those processor types and
using the appropriate ifdef's in those locations.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg.h       | 2 ++
 arch/powerpc/include/asm/reg_booke.h | 4 ++--
 arch/powerpc/kernel/process.c        | 2 +-
 arch/powerpc/kernel/traps.c          | 8 ++++++--
 arch/powerpc/lib/sstep.c             | 2 ++
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index de52c31..41d0b2e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -110,7 +110,9 @@
 #ifndef MSR_PMM
 #define MSR_PMM		__MASK(MSR_PMM_LG)	/* Performance monitor */
 #endif
+#if !defined(CONFIG_BOOKE) && !defined(CONFIG_4xx)
 #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
+#endif
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
 #define MSR_TM		__MASK(MSR_TM_LG)	/* Transactional Mem Available */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index eb2a33d..06967f1 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -46,10 +46,10 @@
 #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
 #define MSR_USER64	(MSR_USER32 | MSR_64BIT)
 #elif defined (CONFIG_40x)
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
+#define MSR_KERNEL	(MSR_ME|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #else
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
+#define MSR_KERNEL	(MSR_ME|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f3473..77679a7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1359,7 +1359,7 @@ static struct regbit msr_bits[] = {
 	{MSR_IR,	"IR"},
 	{MSR_DR,	"DR"},
 	{MSR_PMM,	"PMM"},
-#ifndef CONFIG_BOOKE
+#if !defined(CONFIG_BOOKE) && !defined(CONFIG_40x)
 	{MSR_RI,	"RI"},
 	{MSR_LE,	"LE"},
 #endif
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9a86572..2d00696 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -429,10 +429,11 @@ void system_reset_exception(struct pt_regs *regs)
 	if (get_paca()->in_nmi > 1)
 		nmi_panic(regs, "Unrecoverable nested System Reset");
 #endif
+#ifdef MSR_RI
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		nmi_panic(regs, "Unrecoverable System Reset");
-
+#endif
 	if (!nested)
 		nmi_exit();
 
@@ -478,7 +479,9 @@ static inline int check_io_access(struct pt_regs *regs)
 			printk(KERN_DEBUG "%s bad port %lx at %p\n",
 			       (*nip & 0x100)? "OUT to": "IN from",
 			       regs->gpr[rb] - _IO_BASE, nip);
+#ifdef MSR_RI
 			regs->msr |= MSR_RI;
+#endif
 			regs->nip = extable_fixup(entry);
 			return 1;
 		}
@@ -763,10 +766,11 @@ void machine_check_exception(struct pt_regs *regs)
 	if (check_io_access(regs))
 		goto bail;
 
+#ifdef MSR_RI
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		nmi_panic(regs, "Unrecoverable Machine check");
-
+#endif
 	if (!nested)
 		nmi_exit();
 
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d81568f..c03c453 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -3059,9 +3059,11 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 
 	case MTMSR:
 		val = regs->gpr[op.reg];
+#ifdef MSR_RI
 		if ((val & MSR_RI) == 0)
 			/* can't step mtmsr[d] that would clear MSR_RI */
 			return -1;
+#endif
 		/* here op.val is the mask of bits to change */
 		regs->msr = (regs->msr & ~op.val) | (val & op.val);
 		goto instr_done;


