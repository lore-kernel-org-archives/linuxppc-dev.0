Return-Path: <afleming@freescale.com>
Received: from ftpbox.mot.com (ftpbox.mot.com [129.188.136.101])
	by ozlabs.org (Postfix) with ESMTP id 4BDCD2BF0D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 09:21:19 +1100 (EST)
Received: from az33exr04.mot.com (pobox4.mot.com [10.64.251.243])
	by ftpbox.mot.com (Motorola/Ftpbox) with ESMTP id iATMLIOP021054
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2004 15:21:18 -0700 (MST)
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <F9AAB23C-4254-11D9-A096-000393C30512@freescale.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-5-1053103875
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Andy Fleming <afleming@freescale.com>
Date: Mon, 29 Nov 2004 16:21:11 -0600
Subject: [PATCH] Remove 604 perfmon from ppc_htab
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Apple-Mail-5-1053103875
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

This patch removes the 604 performance monitor counters from ppc_htab.  
The reason is that people have said that no one uses them, and ppc_htab 
is not the right place for them.  Any objections?


--Apple-Mail-5-1053103875
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="htab_patch"
Content-Disposition: attachment;
	filename=htab_patch

--- linux-2.5-gfar/arch/ppc/kernel/ppc_htab.c	2004-10-28 10:54:04.000000000 -0500
+++ linux-2.5-oprofile/arch/ppc/kernel/ppc_htab.c	2004-10-29 10:50:20.000000000 -0500
@@ -59,42 +59,6 @@
 	.release	= single_release,
 };
 
-static char *pmc1_lookup(unsigned long mmcr0)
-{
-	switch ( mmcr0 & (0x7f<<7) )
-	{
-	case 0x0:
-		return "none";
-	case MMCR0_PMC1_CYCLES:
-		return "cycles";
-	case MMCR0_PMC1_ICACHEMISS:
-		return "ic miss";
-	case MMCR0_PMC1_DTLB:
-		return "dtlb miss";
-	default:
-		return "unknown";
-	}
-}
-
-static char *pmc2_lookup(unsigned long mmcr0)
-{
-	switch ( mmcr0 & 0x3f )
-	{
-	case 0x0:
-		return "none";
-	case MMCR0_PMC2_CYCLES:
-		return "cycles";
-	case MMCR0_PMC2_DCACHEMISS:
-		return "dc miss";
-	case MMCR0_PMC2_ITLB:
-		return "itlb miss";
-	case MMCR0_PMC2_LOADMISSTIME:
-		return "load miss time";
-	default:
-		return "unknown";
-	}
-}
-
 /*
  * print some useful info about the hash table.  This function
  * is _REALLY_ slow (see the nested for loops below) but nothing
@@ -102,29 +66,11 @@
  */
 static int ppc_htab_show(struct seq_file *m, void *v)
 {
-	unsigned long mmcr0 = 0, pmc1 = 0, pmc2 = 0;
 #if defined(CONFIG_PPC_STD_MMU) && !defined(CONFIG_PPC64BRIDGE)
 	unsigned int kptes = 0, uptes = 0;
 	PTE *ptr;
 #endif /* CONFIG_PPC_STD_MMU */
 
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
-		mmcr0 = mfspr(SPRN_MMCR0);
-		pmc1 = mfspr(SPRN_PMC1);
-		pmc2 = mfspr(SPRN_PMC2);
-		seq_printf(m,
-			      "604 Performance Monitoring\n"
-			      "MMCR0\t\t: %08lx %s%s ",
-			      mmcr0,
-			      ( mmcr0>>28 & 0x2 ) ? "(user mode counted)" : "",
-			      ( mmcr0>>28 & 0x4 ) ? "(kernel mode counted)" : "");
-		seq_printf(m,
-			      "\nPMC1\t\t: %08lx (%s)\n"
-			      "PMC2\t\t: %08lx (%s)\n",
-			      pmc1, pmc1_lookup(mmcr0),
-			      pmc2, pmc2_lookup(mmcr0));
-	}
-
 #ifdef CONFIG_PPC_STD_MMU
 	/* if we don't have a htab */
 	if ( Hash_size == 0 ) {
@@ -188,7 +134,7 @@
 }
 
 /*
- * Allow user to define performance counters and resize the hash table
+ * Allow user to resize the hash table
  */
 static ssize_t ppc_htab_write(struct file * file, const char __user * ubuffer,
 			      size_t count, loff_t *ppos)
@@ -209,108 +155,12 @@
 
 	if ( !strncmp( buffer, "reset", 5) )
 	{
-		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
-			/* reset PMC1 and PMC2 */
-			mtspr(SPRN_PMC1, 0);
-			mtspr(SPRN_PMC2, 0);
-		}
 		htab_reloads = 0;
 		htab_evicts = 0;
 		pte_misses = 0;
 		pte_errors = 0;
 	}
 
-	/* Everything below here requires the performance monitor feature. */
-	if ( !cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON )
-		return count;
-
-	/* turn off performance monitoring */
-	if ( !strncmp( buffer, "off", 3) )
-	{
-		mtspr(SPRN_MMCR0, 0);
-		mtspr(SPRN_PMC1, 0);
-		mtspr(SPRN_PMC2, 0);
-	}
-
-	if ( !strncmp( buffer, "user", 4) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x60000000)) | 0x20000000;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-		mtspr(SPRN_PMC2, 0);
-	}
-
-	if ( !strncmp( buffer, "kernel", 6) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x60000000)) | 0x40000000;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-		mtspr(SPRN_PMC2, 0);
-	}
-
-	/* PMC1 values */
-	if ( !strncmp( buffer, "dtlb", 4) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x7F << 7)) | MMCR0_PMC1_DTLB;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-	}
-
-	if ( !strncmp( buffer, "ic miss", 7) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x7F<<7)) | MMCR0_PMC1_ICACHEMISS;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-	}
-
-	/* PMC2 values */
-	if ( !strncmp( buffer, "load miss time", 14) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-	       asm volatile(
-		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
-		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
-		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
-		       "mtspr %3,%4 \n\t"    /* reset the pmc */
-		       : "=r" (tmp)
-		       : "i" (SPRN_MMCR0),
-		       "i" (MMCR0_PMC2_LOADMISSTIME),
-		       "i" (SPRN_PMC2),  "r" (0) );
-	}
-
-	if ( !strncmp( buffer, "itlb", 4) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-	       asm volatile(
-		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
-		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
-		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
-		       "mtspr %3,%4 \n\t"    /* reset the pmc */
-		       : "=r" (tmp)
-		       : "i" (SPRN_MMCR0), "i" (MMCR0_PMC2_ITLB),
-		       "i" (SPRN_PMC2),  "r" (0) );
-	}
-
-	if ( !strncmp( buffer, "dc miss", 7) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-	       asm volatile(
-		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
-		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
-		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
-		       "mtspr %3,%4 \n\t"    /* reset the pmc */
-		       : "=r" (tmp)
-		       : "i" (SPRN_MMCR0), "i" (MMCR0_PMC2_DCACHEMISS),
-		       "i" (SPRN_PMC2),  "r" (0) );
-	}
-
 	return count;
 #else /* CONFIG_PPC_STD_MMU */
 	return 0;

--Apple-Mail-5-1053103875--
