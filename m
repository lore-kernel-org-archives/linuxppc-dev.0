Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15BE9B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 11:33:36 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8T1HHXp015332
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 21:17:17 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8T1XUg5313544
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 21:33:32 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8T1XU9v022794
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 21:33:30 -0400
Subject: Re: [PATCH 1/1  v3]  Add kernel parameter to disable batched hcalls
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20100928175206.GA15783@lixom.net>
References: <1285364655.3016.25.camel@lexx>
	<20100926034903.GA5473@lixom.net> <1285693371.2843.43.camel@lexx>
	<20100928175206.GA15783@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Sep 2010 20:33:12 -0500
Message-ID: <1285723992.4408.3.camel@lexx>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This introduces a pair of kernel parameters that can be used to disable
the MULTITCE and BULK_REMOVE h-calls.

By default, those hcalls are enabled, active, and good for throughput
and performance.  The ability to disable them will be useful for some of
the PREEMPT_RT related investigation and work occurring on Power.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Olof Johansson <olof@lixom.net>
cc: Anton Blanchard <anton@samba.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

v2 - Per feedback from Olof, the code is reworked to utilize kernel
    parameter runtime checks, rather than CONFIG options.
   - Added relevant change to kernel-parameters.txt

v3 - ran through checkpatch and fixed whitespace issues.
   - consolidated the if() staircases to save indentation.


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e2c7487..5c40801 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -426,6 +426,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	bttv.pll=	See Documentation/video4linux/bttv/Insmod-options
 	bttv.tuner=	and Documentation/video4linux/bttv/CARDLIST
 
+	bulk_remove=off	[PPC]  This parameter disables the use of the pSeries
+			firmware feature for flushing multiple hpte entries
+			at a time.
+
 	BusLogic=	[HW,SCSI]
 			See drivers/scsi/BusLogic.c, comment before function
 			BusLogic_ParseDriverOptions().
@@ -1499,6 +1503,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	mtdparts=	[MTD]
 			See drivers/mtd/cmdlinepart.c.
 
+	multitce=off	[PPC]  This parameter disables the use of the pSeries
+			firmware feature for updating multiple TCE entries
+			at a time.
+
 	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
 
 			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 902987d..e174a2f 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -625,3 +625,17 @@ void iommu_init_early_pSeries(void)
 	set_pci_dma_ops(&dma_iommu_ops);
 }
 
+static int __init disable_multitce(char *str)
+{
+	if (strcmp(str, "off") == 0 &&
+	    firmware_has_feature(FW_FEATURE_LPAR) &&
+	    firmware_has_feature(FW_FEATURE_MULTITCE)) {
+		printk(KERN_INFO "Disabling MULTITCE firmware feature\n");
+		ppc_md.tce_build = tce_build_pSeriesLP;
+		ppc_md.tce_free	 = tce_free_pSeriesLP;
+		powerpc_firmware_features &= ~FW_FEATURE_MULTITCE;
+	}
+	return 1;
+}
+
+__setup("multitce=", disable_multitce);
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0707653..82d15e7 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -599,6 +599,18 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
 }
 
+static int __init disable_bulk_remove(char *str)
+{
+	if (strcmp(str, "off") == 0 &&
+	    firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
+			printk(KERN_INFO "Disabling BULK_REMOVE firmware feature");
+			powerpc_firmware_features &= ~FW_FEATURE_BULK_REMOVE;
+	}
+	return 1;
+}
+
+__setup("bulk_remove=", disable_bulk_remove);
+
 void __init hpte_init_lpar(void)
 {
 	ppc_md.hpte_invalidate	= pSeries_lpar_hpte_invalidate;
