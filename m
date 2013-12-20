Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 004AC2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 16:01:36 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 20 Dec 2013 10:31:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 46879125805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 10:32:46 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBK51Mm519791910
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 10:31:23 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBK51Tqt019877
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 10:31:29 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH V4] powerpc/kernel/sysfs: cleanup set up macros for
 PMC/non-PMC SPRs
Date: Fri, 20 Dec 2013 10:31:27 +0530
Message-Id: <1387515687-12113-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: michael@ellerman.id.au, olof@lixom.net,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently PMC (Performance Monitor Counter) setup macros are used
for other SPRs. Since not all SPRs are PMC related, this patch
modifies the exisiting macro and uses it to setup both PMC and
non PMC SPRs accordingly.

V4 changes:
1) No logic changes, just rebase with upstream.

V3 changes:

1) No logic change, just renamed generic macro and removed #define for
empty string
2) Changes in the comment to explain better.

V2 changes:

1) Modified SYSFS_PMCSETUP to a generic macro with additional parameter
2) Added PMC and SPR macro to call the generic macro
3) Changes in the comment to explain better.

Acked-by: Michael Ellerman <michael@ellerman.id.au>
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c |   72 +++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index b4e6676..cad777e 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -108,14 +108,14 @@ void ppc_enable_pmcs(void)
 }
 EXPORT_SYMBOL(ppc_enable_pmcs);
 
-#define SYSFS_PMCSETUP(NAME, ADDRESS) \
+#define __SYSFS_SPRSETUP(NAME, ADDRESS, EXTRA) \
 static void read_##NAME(void *val) \
 { \
 	*(unsigned long *)val = mfspr(ADDRESS);	\
 } \
 static void write_##NAME(void *val) \
 { \
-	ppc_enable_pmcs(); \
+	EXTRA; \
 	mtspr(ADDRESS, *(unsigned long *)val);	\
 } \
 static ssize_t show_##NAME(struct device *dev, \
@@ -140,6 +140,10 @@ static ssize_t __used \
 	return count; \
 }
 
+#define SYSFS_PMCSETUP(NAME, ADDRESS)	\
+	__SYSFS_SPRSETUP(NAME, ADDRESS, ppc_enable_pmcs())
+#define SYSFS_SPRSETUP(NAME, ADDRESS)	\
+	__SYSFS_SPRSETUP(NAME, ADDRESS, )
 
 /* Let's define all possible registers, we'll only hook up the ones
  * that are implemented on the current processor
@@ -175,10 +179,10 @@ SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
 SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
 
 SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
-SYSFS_PMCSETUP(purr, SPRN_PURR);
-SYSFS_PMCSETUP(spurr, SPRN_SPURR);
-SYSFS_PMCSETUP(dscr, SPRN_DSCR);
-SYSFS_PMCSETUP(pir, SPRN_PIR);
+SYSFS_SPRSETUP(purr, SPRN_PURR);
+SYSFS_SPRSETUP(spurr, SPRN_SPURR);
+SYSFS_SPRSETUP(dscr, SPRN_DSCR);
+SYSFS_SPRSETUP(pir, SPRN_PIR);
 
 /*
   Lets only enable read for phyp resources and
@@ -249,34 +253,34 @@ SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
 SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
 SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
 #ifdef CONFIG_DEBUG_KERNEL
-SYSFS_PMCSETUP(hid0, SPRN_HID0);
-SYSFS_PMCSETUP(hid1, SPRN_HID1);
-SYSFS_PMCSETUP(hid4, SPRN_HID4);
-SYSFS_PMCSETUP(hid5, SPRN_HID5);
-SYSFS_PMCSETUP(ima0, SPRN_PA6T_IMA0);
-SYSFS_PMCSETUP(ima1, SPRN_PA6T_IMA1);
-SYSFS_PMCSETUP(ima2, SPRN_PA6T_IMA2);
-SYSFS_PMCSETUP(ima3, SPRN_PA6T_IMA3);
-SYSFS_PMCSETUP(ima4, SPRN_PA6T_IMA4);
-SYSFS_PMCSETUP(ima5, SPRN_PA6T_IMA5);
-SYSFS_PMCSETUP(ima6, SPRN_PA6T_IMA6);
-SYSFS_PMCSETUP(ima7, SPRN_PA6T_IMA7);
-SYSFS_PMCSETUP(ima8, SPRN_PA6T_IMA8);
-SYSFS_PMCSETUP(ima9, SPRN_PA6T_IMA9);
-SYSFS_PMCSETUP(imaat, SPRN_PA6T_IMAAT);
-SYSFS_PMCSETUP(btcr, SPRN_PA6T_BTCR);
-SYSFS_PMCSETUP(pccr, SPRN_PA6T_PCCR);
-SYSFS_PMCSETUP(rpccr, SPRN_PA6T_RPCCR);
-SYSFS_PMCSETUP(der, SPRN_PA6T_DER);
-SYSFS_PMCSETUP(mer, SPRN_PA6T_MER);
-SYSFS_PMCSETUP(ber, SPRN_PA6T_BER);
-SYSFS_PMCSETUP(ier, SPRN_PA6T_IER);
-SYSFS_PMCSETUP(sier, SPRN_PA6T_SIER);
-SYSFS_PMCSETUP(siar, SPRN_PA6T_SIAR);
-SYSFS_PMCSETUP(tsr0, SPRN_PA6T_TSR0);
-SYSFS_PMCSETUP(tsr1, SPRN_PA6T_TSR1);
-SYSFS_PMCSETUP(tsr2, SPRN_PA6T_TSR2);
-SYSFS_PMCSETUP(tsr3, SPRN_PA6T_TSR3);
+SYSFS_SPRSETUP(hid0, SPRN_HID0);
+SYSFS_SPRSETUP(hid1, SPRN_HID1);
+SYSFS_SPRSETUP(hid4, SPRN_HID4);
+SYSFS_SPRSETUP(hid5, SPRN_HID5);
+SYSFS_SPRSETUP(ima0, SPRN_PA6T_IMA0);
+SYSFS_SPRSETUP(ima1, SPRN_PA6T_IMA1);
+SYSFS_SPRSETUP(ima2, SPRN_PA6T_IMA2);
+SYSFS_SPRSETUP(ima3, SPRN_PA6T_IMA3);
+SYSFS_SPRSETUP(ima4, SPRN_PA6T_IMA4);
+SYSFS_SPRSETUP(ima5, SPRN_PA6T_IMA5);
+SYSFS_SPRSETUP(ima6, SPRN_PA6T_IMA6);
+SYSFS_SPRSETUP(ima7, SPRN_PA6T_IMA7);
+SYSFS_SPRSETUP(ima8, SPRN_PA6T_IMA8);
+SYSFS_SPRSETUP(ima9, SPRN_PA6T_IMA9);
+SYSFS_SPRSETUP(imaat, SPRN_PA6T_IMAAT);
+SYSFS_SPRSETUP(btcr, SPRN_PA6T_BTCR);
+SYSFS_SPRSETUP(pccr, SPRN_PA6T_PCCR);
+SYSFS_SPRSETUP(rpccr, SPRN_PA6T_RPCCR);
+SYSFS_SPRSETUP(der, SPRN_PA6T_DER);
+SYSFS_SPRSETUP(mer, SPRN_PA6T_MER);
+SYSFS_SPRSETUP(ber, SPRN_PA6T_BER);
+SYSFS_SPRSETUP(ier, SPRN_PA6T_IER);
+SYSFS_SPRSETUP(sier, SPRN_PA6T_SIER);
+SYSFS_SPRSETUP(siar, SPRN_PA6T_SIAR);
+SYSFS_SPRSETUP(tsr0, SPRN_PA6T_TSR0);
+SYSFS_SPRSETUP(tsr1, SPRN_PA6T_TSR1);
+SYSFS_SPRSETUP(tsr2, SPRN_PA6T_TSR2);
+SYSFS_SPRSETUP(tsr3, SPRN_PA6T_TSR3);
 #endif /* CONFIG_DEBUG_KERNEL */
 #endif /* HAS_PPC_PMC_PA6T */
 
-- 
1.7.10.4
