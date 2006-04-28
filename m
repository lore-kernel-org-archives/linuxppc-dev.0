Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C144679F7
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 04:41:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3SIfjMv015912
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 14:41:45 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3SIfjxt209622
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 14:41:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3SIfjmc016481
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 14:41:45 -0400
Subject: [RFC , PATCH] support for the ibm,pa_features cpu property
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>, paulus@samba.org
Content-Type: text/plain
Date: Fri, 28 Apr 2006 13:41:24 -0500
Message-Id: <1146249684.27214.18.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


To determine if our processors support some features, such as large
pages, we should be using the ibm,pa_features property, rather than just
the PVR values.  
This is an initial pass at the functionality.  This has been tested in
the case where the property is missing, but still needs to be tested
against a system where the property actually exists.  :-o  



diff --git a/arch/powerpc/kernel/setup_64.c
b/arch/powerpc/kernel/setup_64.c
index 13e91c4..78ad054 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -106,6 +106,65 @@ static struct notifier_block ppc64_panic
 	.priority = INT_MIN /* may not return; must be done last */
 };
 
+/*
+ * ibm,pa-features is a per-cpu property that contains a 2 byte header
+ * plus up to 256 bytes worth of processor attributes.  First header
+ * byte specifies the number of bytes implemented by the platform.
+ * Second header byte is an "attribute-specifier" type, which should
+ * be zero.  Remainder of the data consists of ones and zeros.
+ * Implementation:  Pass in the byte and bit offset for the feature
+ * that we are interested in.  The function will return -1 if the
+ * pa-features property is missing, or a 1/0 to indicate if the feature
+ * is supported/not supported.
+ */
+
+static int get_pa_features(int pabyte,int pabit)
+{
+	struct device_node *cpu;
+	char *pa_feature_table;
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+	pa_feature_table = 
+		(char *)get_property(cpu, "ibm,pa-features", NULL);
+
+	if ( pa_feature_table == NULL ) {
+		printk("ibm,pa-features property is missing.\n");
+		return -1;
+	}
+
+	/* sanity check */
+	if ( pabyte > pa_feature_table[0] ) {
+		printk("%s: %d out of range for table of size %d\n",
+			__FUNCTION__,pabyte,pa_feature_table[0]);
+		return -1;
+	}
+	
+	return pa_feature_table[2+pabyte*8+pabit];
+}
+
+/*
+ * set values within the cur_cpu_spec table according to
+ * the ibm,pa_features property. 
+ * potential entries include: 
+ * Byte 0, bit 1 - FPU available
+ * Byte 1, bit 2 - Large Pages 
+ * Byte 2, bit 3 - DAR set on alignment Interrupt. 
+ */
+static void add_cpu_features()
+{
+	/* if no property, bail early */
+	if (get_pa_features(0,0) == -1 ) return;
+
+	if (get_pa_features(1,2) ) {
+		printk("Adding CI_LARGE_PAGE to cur_cpu_spec \n");
+		cur_cpu_spec->cpu_features |= CPU_FTR_CI_LARGE_PAGE;
+	}
+
+	/* add more here... */
+
+}
+
+
 #ifdef CONFIG_SMP
 
 static int smt_enabled_cmdline;
@@ -425,6 +484,8 @@ void __init setup_system(void)
 
 	parse_early_param();
 
+	add_cpu_features();
+
 	check_smt_enabled();
 	smp_setup_cpu_maps();
 
