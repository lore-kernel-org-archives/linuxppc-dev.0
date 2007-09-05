Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6C473DDF68
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:02:15 +1000 (EST)
Date: Tue, 4 Sep 2007 21:09:06 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [POWERPC] pasemi: Export more SPRs to sysfs when CONFIG_DEBUG_KERNEL=y
Message-ID: <20070905020906.GD25900@lixom.net>
References: <20070905020733.GA25900@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905020733.GA25900@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit e34d30c44975ed7db1542f6548f2716185c87baf
Author: Olof Johansson <olof@lixom.net>
Date:   Sat Sep 1 14:45:07 2007 -0500

    [POWERPC] pasemi: Export more SPRs to sysfs when CONFIG_DEBUG_KERNEL=y
    
    Export some of the implementation-specific registers via sysfs. Useful
    when debugging, etc.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 55d29ed..d7835ba 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -197,6 +197,36 @@ SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
 SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
 SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
 
+#ifdef CONFIG_DEBUG_KERNEL
+SYSFS_PMCSETUP(hid0, SPRN_HID0);
+SYSFS_PMCSETUP(hid1, SPRN_HID1);
+SYSFS_PMCSETUP(hid4, SPRN_HID4);
+SYSFS_PMCSETUP(hid5, SPRN_HID5);
+SYSFS_PMCSETUP(ima0, SPRN_PA6T_IMA0);
+SYSFS_PMCSETUP(ima1, SPRN_PA6T_IMA1);
+SYSFS_PMCSETUP(ima2, SPRN_PA6T_IMA2);
+SYSFS_PMCSETUP(ima3, SPRN_PA6T_IMA3);
+SYSFS_PMCSETUP(ima4, SPRN_PA6T_IMA4);
+SYSFS_PMCSETUP(ima5, SPRN_PA6T_IMA5);
+SYSFS_PMCSETUP(ima6, SPRN_PA6T_IMA6);
+SYSFS_PMCSETUP(ima7, SPRN_PA6T_IMA7);
+SYSFS_PMCSETUP(ima8, SPRN_PA6T_IMA8);
+SYSFS_PMCSETUP(ima9, SPRN_PA6T_IMA9);
+SYSFS_PMCSETUP(imaat, SPRN_PA6T_IMAAT);
+SYSFS_PMCSETUP(btcr, SPRN_PA6T_BTCR);
+SYSFS_PMCSETUP(pccr, SPRN_PA6T_PCCR);
+SYSFS_PMCSETUP(rpccr, SPRN_PA6T_RPCCR);
+SYSFS_PMCSETUP(der, SPRN_PA6T_DER);
+SYSFS_PMCSETUP(mer, SPRN_PA6T_MER);
+SYSFS_PMCSETUP(ber, SPRN_PA6T_BER);
+SYSFS_PMCSETUP(ier, SPRN_PA6T_IER);
+SYSFS_PMCSETUP(sier, SPRN_PA6T_SIER);
+SYSFS_PMCSETUP(siar, SPRN_PA6T_SIAR);
+SYSFS_PMCSETUP(tsr0, SPRN_PA6T_TSR0);
+SYSFS_PMCSETUP(tsr1, SPRN_PA6T_TSR1);
+SYSFS_PMCSETUP(tsr2, SPRN_PA6T_TSR2);
+SYSFS_PMCSETUP(tsr3, SPRN_PA6T_TSR3);
+#endif /* CONFIG_DEBUG_KERNEL */
 
 static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
 static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
@@ -228,6 +258,36 @@ static struct sysdev_attribute pa6t_attrs[] = {
 	_SYSDEV_ATTR(pmc3, 0600, show_pa6t_pmc3, store_pa6t_pmc3),
 	_SYSDEV_ATTR(pmc4, 0600, show_pa6t_pmc4, store_pa6t_pmc4),
 	_SYSDEV_ATTR(pmc5, 0600, show_pa6t_pmc5, store_pa6t_pmc5),
+#ifdef CONFIG_DEBUG_KERNEL
+	_SYSDEV_ATTR(hid0, 0600, show_hid0, store_hid0),
+	_SYSDEV_ATTR(hid1, 0600, show_hid1, store_hid1),
+	_SYSDEV_ATTR(hid4, 0600, show_hid4, store_hid4),
+	_SYSDEV_ATTR(hid5, 0600, show_hid5, store_hid5),
+	_SYSDEV_ATTR(ima0, 0600, show_ima0, store_ima0),
+	_SYSDEV_ATTR(ima1, 0600, show_ima1, store_ima1),
+	_SYSDEV_ATTR(ima2, 0600, show_ima2, store_ima2),
+	_SYSDEV_ATTR(ima3, 0600, show_ima3, store_ima3),
+	_SYSDEV_ATTR(ima4, 0600, show_ima4, store_ima4),
+	_SYSDEV_ATTR(ima5, 0600, show_ima5, store_ima5),
+	_SYSDEV_ATTR(ima6, 0600, show_ima6, store_ima6),
+	_SYSDEV_ATTR(ima7, 0600, show_ima7, store_ima7),
+	_SYSDEV_ATTR(ima8, 0600, show_ima8, store_ima8),
+	_SYSDEV_ATTR(ima9, 0600, show_ima9, store_ima9),
+	_SYSDEV_ATTR(imaat, 0600, show_imaat, store_imaat),
+	_SYSDEV_ATTR(btcr, 0600, show_btcr, store_btcr),
+	_SYSDEV_ATTR(pccr, 0600, show_pccr, store_pccr),
+	_SYSDEV_ATTR(rpccr, 0600, show_rpccr, store_rpccr),
+	_SYSDEV_ATTR(der, 0600, show_der, store_der),
+	_SYSDEV_ATTR(mer, 0600, show_mer, store_mer),
+	_SYSDEV_ATTR(ber, 0600, show_ber, store_ber),
+	_SYSDEV_ATTR(ier, 0600, show_ier, store_ier),
+	_SYSDEV_ATTR(sier, 0600, show_sier, store_sier),
+	_SYSDEV_ATTR(siar, 0600, show_siar, store_siar),
+	_SYSDEV_ATTR(tsr0, 0600, show_tsr0, store_tsr0),
+	_SYSDEV_ATTR(tsr1, 0600, show_tsr1, store_tsr1),
+	_SYSDEV_ATTR(tsr2, 0600, show_tsr2, store_tsr2),
+	_SYSDEV_ATTR(tsr3, 0600, show_tsr3, store_tsr3),
+#endif /* CONFIG_DEBUG_KERNEL */
 };
 
 
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index 281011e..347de53 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -518,21 +518,47 @@
 #define   PA6T_MMCR1_ES4	0x0000000000ff0000UL
 #define   PA6T_MMCR1_ES5	0x00000000ff000000UL
 
-#define SPRN_PA6T_SIAR  780
-#define SPRN_PA6T_UPMC0 771
-#define SPRN_PA6T_UPMC1 772
+#define SPRN_PA6T_UPMC0 771	/* User PerfMon Counter 0 */
+#define SPRN_PA6T_UPMC1 772	/* ... */
 #define SPRN_PA6T_UPMC2 773
 #define SPRN_PA6T_UPMC3 774
 #define SPRN_PA6T_UPMC4 775
 #define SPRN_PA6T_UPMC5 776
-#define SPRN_PA6T_UMMCR0 779
-#define SPRN_PA6T_UMMCR1 782
-#define SPRN_PA6T_PMC0  787
-#define SPRN_PA6T_PMC1  788
-#define SPRN_PA6T_PMC2  789
-#define SPRN_PA6T_PMC3  790
-#define SPRN_PA6T_PMC4  791
-#define SPRN_PA6T_PMC5  792
+#define SPRN_PA6T_UMMCR0 779	/* User Monitor Mode Control Register 0 */
+#define SPRN_PA6T_SIAR	780	/* Sampled Instruction Address */
+#define SPRN_PA6T_UMMCR1 782	/* User Monitor Mode Control Register 1 */
+#define SPRN_PA6T_SIER	785	/* Sampled Instruction Event Register */
+#define SPRN_PA6T_PMC0	787
+#define SPRN_PA6T_PMC1	788
+#define SPRN_PA6T_PMC2	789
+#define SPRN_PA6T_PMC3	790
+#define SPRN_PA6T_PMC4	791
+#define SPRN_PA6T_PMC5	792
+#define SPRN_PA6T_TSR0	793	/* Timestamp Register 0 */
+#define SPRN_PA6T_TSR1	794	/* Timestamp Register 1 */
+#define SPRN_PA6T_TSR2	799	/* Timestamp Register 2 */
+#define SPRN_PA6T_TSR3	784	/* Timestamp Register 3 */
+
+#define SPRN_PA6T_IER	981	/* Icache Error Register */
+#define SPRN_PA6T_DER	982	/* Dcache Error Register */
+#define SPRN_PA6T_BER	862	/* BIU Error Address Register */
+#define SPRN_PA6T_MER	849	/* MMU Error Register */
+
+#define SPRN_PA6T_IMA0	880	/* Instruction Match Array 0 */
+#define SPRN_PA6T_IMA1	881	/* ... */
+#define SPRN_PA6T_IMA2	882
+#define SPRN_PA6T_IMA3	883
+#define SPRN_PA6T_IMA4	884
+#define SPRN_PA6T_IMA5	885
+#define SPRN_PA6T_IMA6	886
+#define SPRN_PA6T_IMA7	887
+#define SPRN_PA6T_IMA8	888
+#define SPRN_PA6T_IMA9	889
+#define SPRN_PA6T_BTCR	978	/* Breakpoint and Tagging Control Register */
+#define SPRN_PA6T_IMAAT	979	/* Instruction Match Array Action Table */
+#define SPRN_PA6T_PCCR	1019	/* Power Counter Control Register */
+#define SPRN_PA6T_RPCCR	1021	/* Retire PC Trace Control Register */
+
 
 #else /* 32-bit */
 #define SPRN_MMCR0	952	/* Monitor Mode Control Register 0 */
