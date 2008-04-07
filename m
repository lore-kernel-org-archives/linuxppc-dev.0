Return-Path: <ahuja@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 946A3DDED4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 09:45:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m37NjdgZ018670
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 19:45:39 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m37Njdcj250426
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 19:45:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m37NjcKp027230
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 19:45:39 -0400
Message-ID: <47FAB221.7050406@austin.ibm.com>
Date: Mon, 07 Apr 2008 18:45:37 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] pseries: phyp dump: Variable size reserve space. 
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A small proposed change in the amount of reserve space we allocate during boot.
Currently we reserve 256MB only. 
The proposed change does one of the 3 things.

A. It checks to see if there is cmdline variable set and if found sets the
   value to it. OR
B. It computes 5% of total ram and rounds it down to multiples of 256MB. AND
C. Compares the rounded down value and returns larger of two values, the new
   computed value or 256MB.

Again this is for large systems who have excess memory. 

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>

---
 arch/powerpc/kernel/prom.c                 |   35 +++++++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/phyp_dump.c |    9 +++++++
 include/asm-powerpc/phyp_dump.h            |    4 ++-
 3 files changed, 45 insertions(+), 3 deletions(-)

Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-04-02 23:36:51.000000000 -0500
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-04-02 23:48:34.000000000 -0500
@@ -496,3 +496,12 @@ static int __init early_phyp_dump_enable
 }
 early_param("phyp_dump", early_phyp_dump_enabled);
 
+/* Look for phyp_dump_reserve_size= cmdline option */
+static int __init early_phyp_dump_reserve_size(char *p)
+{
+        if (p)
+		phyp_dump_info->phyp_dump_reserve_bootvar = memparse(p, &p);
+
+        return 0;
+}
+early_param("phyp_dump_reserve_size", early_phyp_dump_reserve_size);
Index: 2.6.25-rc1/include/asm-powerpc/phyp_dump.h
===================================================================
--- 2.6.25-rc1.orig/include/asm-powerpc/phyp_dump.h	2008-04-02 23:36:49.000000000 -0500
+++ 2.6.25-rc1/include/asm-powerpc/phyp_dump.h	2008-04-02 23:37:57.000000000 -0500
@@ -24,8 +24,10 @@ struct phyp_dump {
 	/* Memory that is reserved during very early boot. */
 	unsigned long init_reserve_start;
 	unsigned long init_reserve_size;
-	/* Check status during boot if dump supported, active & present*/
+	/* cmd line options during boot */
+	unsigned long phyp_dump_reserve_bootvar;
 	unsigned long phyp_dump_at_boot;
+	/* Check status during boot if dump supported, active & present*/
 	unsigned long phyp_dump_configured;
 	unsigned long phyp_dump_is_active;
 	/* store cpu & hpte size */
Index: 2.6.25-rc1/arch/powerpc/kernel/prom.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/kernel/prom.c	2008-04-02 23:36:49.000000000 -0500
+++ 2.6.25-rc1/arch/powerpc/kernel/prom.c	2008-04-08 00:01:34.000000000 -0500
@@ -1042,6 +1042,33 @@ static void __init early_reserve_mem(voi
 
 #ifdef CONFIG_PHYP_DUMP
 /**
+ * phyp_dump_calculate_reserve_size() - reserve variable boot area 5% or arg
+ *
+ * Function to find the largest size we need to reserve
+ * during early boot process.
+ *
+ * It either looks for boot param and returns that OR
+ * returns larger of 256 or 5% rounded down to multiples of 256MB.
+ *
+ */
+static inline unsigned long phyp_dump_calculate_reserve_size(void)
+{
+	unsigned long tmp;
+
+	if (phyp_dump_info->phyp_dump_reserve_bootvar)
+		return phyp_dump_info->phyp_dump_reserve_bootvar;
+
+	/* divide by 20 to get 5% of value */
+	tmp = lmb_end_of_DRAM();
+	do_div(tmp, 20);
+
+	/* round it down in multiples of 256 */
+	tmp = tmp & ~0x000000001FFFFFFF;
+
+	return (tmp > PHYP_DUMP_RMR_END ? tmp : PHYP_DUMP_RMR_END);
+}
+
+/**
  * phyp_dump_reserve_mem() - reserve all not-yet-dumped mmemory
  *
  * This routine may reserve memory regions in the kernel only
@@ -1054,6 +1081,8 @@ static void __init early_reserve_mem(voi
 static void __init phyp_dump_reserve_mem(void)
 {
 	unsigned long base, size;
+	unsigned long variable_reserve_size;
+
 	if (!phyp_dump_info->phyp_dump_configured) {
 		printk(KERN_ERR "Phyp-dump not supported on this hardware\n");
 		return;
@@ -1064,9 +1093,11 @@ static void __init phyp_dump_reserve_mem
 		return;
 	}
 
+	variable_reserve_size = phyp_dump_calculate_reserve_size();
+
 	if (phyp_dump_info->phyp_dump_is_active) {
 		/* Reserve *everything* above RMR.Area freed by userland tools*/
-		base = PHYP_DUMP_RMR_END;
+		base = variable_reserve_size;
 		size = lmb_end_of_DRAM() - base;
 
 		/* XXX crashed_ram_end is wrong, since it may be beyond
@@ -1078,7 +1109,7 @@ static void __init phyp_dump_reserve_mem
 	} else {
 		size = phyp_dump_info->cpu_state_size +
 			phyp_dump_info->hpte_region_size +
-			PHYP_DUMP_RMR_END;
+			variable_reserve_size;
 		base = lmb_end_of_DRAM() - size;
 		lmb_reserve(base, size);
 		phyp_dump_info->init_reserve_start = base;
