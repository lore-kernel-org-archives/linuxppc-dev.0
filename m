Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19EFA2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 21:17:44 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 30 Sep 2013 16:47:35 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0B945394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 16:47:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8UBHUwK48693476
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 16:47:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8UBHVa4005226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 16:47:31 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/kernel/sysfs: cleanup set up macros for pmc/non pmc
 sprs
Date: Mon, 30 Sep 2013 16:47:29 +0530
Message-Id: <1380539849-6162-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently pmc setup macros are used for non pmc sprs. This patch
add new set of macros and cleans up the code to use the new setup macro
for non pmc sprs.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c |   95 ++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 27a90b9..73b6f9f 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -139,6 +139,37 @@ static ssize_t __used \
 	return count; \
 }

+#define SYSFS_SPRSETUP(NAME, ADDRESS) \
+static void read_##NAME(void *val) \
+{ \
+	*(unsigned long *)val = mfspr(ADDRESS);	\
+} \
+static void write_##NAME(void *val) \
+{ \
+	mtspr(ADDRESS, *(unsigned long *)val);	\
+} \
+static ssize_t show_##NAME(struct device *dev, \
+			struct device_attribute *attr, \
+			char *buf) \
+{ \
+	struct cpu *cpu = container_of(dev, struct cpu, dev); \
+	unsigned long val; \
+	smp_call_function_single(cpu->dev.id, read_##NAME, &val, 1);	\
+	return sprintf(buf, "%lx\n", val); \
+} \
+static ssize_t __used \
+	store_##NAME(struct device *dev, struct device_attribute *attr, \
+			const char *buf, size_t count) \
+{ \
+	struct cpu *cpu = container_of(dev, struct cpu, dev); \
+	unsigned long val; \
+	int ret = sscanf(buf, "%lx", &val); \
+	if (ret != 1) \
+		return -EINVAL; \
+	smp_call_function_single(cpu->dev.id, write_##NAME, &val, 1); \
+	return count; \
+}
+
 
 /* Let's define all possible registers, we'll only hook up the ones
  * that are implemented on the current processor
@@ -174,10 +205,10 @@ SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
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
 
 static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
 static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
@@ -238,34 +269,34 @@ SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
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
