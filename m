Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT1fm4mNCzDvNV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 11:35:44 +1100 (AEDT)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tT1fm01dQz9t2C
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 11:35:44 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id x23so17863442pgx.3
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 16:35:43 -0800 (PST)
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/radix/mm: Fixup storage key mm fault
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <b8a934c7-899f-a320-31d5-5f2889f77d6c@gmail.com>
Date: Wed, 30 Nov 2016 11:35:36 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Aneesh/Ben reported that the change to do_page_fault() needs
to handle the case where CPU_FTR_COHERENT_ICACHE is missing
but we have CPU_FTR_NOEXECUTE. In those cases the check
added for SRR1_ISI_N_OR_G might trigger a false positive.

This patch checks for CPU_FTR_COHERENT_ICACHE in addition
to the MSR value

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

 Applies on top of powerpc/next and I've not added a fixes tag

 arch/powerpc/mm/fault.c | 9 ++++++++-
 drivers/crypto/Makefile | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a17029aa..eab3ded 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -392,8 +392,15 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec) {
 		/*
 		 * An execution fault + no execute ?
+		 * We need to check for CPU_FTR_COHERENT_ICACHE, since
+		 * on some variants, an NX fault is taken and
+		 * hash_page_do_lazy_icache() does the fixup. Without the
+		 * check for CPU_FTR_COHERENT_ICACHE we could have a false
+		 * positive if we have !CPU_FTR_COHERENT_ICACHE and
+		 * CPU_FTR_NOEXECUTE
 		 */
-		if (regs->msr & SRR1_ISI_N_OR_G)
+		if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE) &&
+			(regs->msr & SRR1_ISI_N_OR_G))
 			goto bad_area;
 
 		/*
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index ad7250f..3c6432d 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -31,4 +31,3 @@ obj-$(CONFIG_CRYPTO_DEV_QCE) += qce/
 obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
 obj-$(CONFIG_CRYPTO_DEV_SUN4I_SS) += sunxi-ss/
 obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rockchip/
-obj-$(CONFIG_CRYPTO_DEV_CHELSIO) += chelsio/
-- 
2.5.5
