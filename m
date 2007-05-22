Return-Path: <sachinp@in.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05BB1DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:26:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4MBOC6Q001016
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 07:24:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MCQFK9544710
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:26:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MCQEMk006585
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:26:15 -0400
Message-ID: <4652E17C.7080607@in.ibm.com>
Date: Tue, 22 May 2007 17:56:36 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [Patch 2/2] Kexec/Kdump support POWER6
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
In-Reply-To: <4652E109.4020204@in.ibm.com>
Content-Type: multipart/mixed; boundary="------------020709020904030606030702"
Cc: Milton Miller II <miltonm@us.ibm.com>, ellerman@au1.ibm.com
Reply-To: sachinp@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020709020904030606030702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Power machines supporting VRMA, Kexec/Kdump does not work.
Hypervisor stores VRMA mapping used by the OS, in the hpte hash
tables. Make sure these hpte entries are left untouched.

Thanks
-Sachin



--------------020709020904030606030702
Content-Type: text/plain;
 name="kexec-kdump-support-for-POWRE6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec-kdump-support-for-POWRE6"

* On Power machines supporting VRMA, Kexec/Kdump does not work.
* Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
* Make sure these hpte entries are left untouched.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---

diff -Naurp linux-2.6.22-rc2-vrma/arch/powerpc/kernel/machine_kexec_64.c linux-2.6.22-rc2-p6/arch/powerpc/kernel/machine_kexec_64.c
--- linux-2.6.22-rc2-vrma/arch/powerpc/kernel/machine_kexec_64.c	2007-05-21 15:14:58.000000000 +0530
+++ linux-2.6.22-rc2-p6/arch/powerpc/kernel/machine_kexec_64.c	2007-05-21 15:19:14.000000000 +0530
@@ -279,6 +279,9 @@ void default_machine_kexec(struct kimage
 	kexec_stack.thread_info.task = current_thread_info()->task;
 	kexec_stack.thread_info.flags = 0;
 
+	if (have_vrma)
+		pSeries_find_hpte_vrma();
+
 	/* Some things are best done in assembly.  Finding globals with
 	 * a toc is easier in C, so pass in what we can.
 	 */
diff -Naurp linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/lpar.c linux-2.6.22-rc2-p6/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/lpar.c	2007-05-21 15:14:57.000000000 +0530
+++ linux-2.6.22-rc2-p6/arch/powerpc/platforms/pseries/lpar.c	2007-05-22 15:53:11.000000000 +0530
@@ -369,6 +369,56 @@ static long pSeries_lpar_hpte_remove(uns
 	return -1;
 }
 
+unsigned long hpte_vrma_slots[HPTE_V_RMA_NUM];
+unsigned int num_hpte_vrma_slots = 0;
+
+void pSeries_find_hpte_vrma(void)
+{
+	unsigned int step;
+	unsigned long hash, slot, vaddr;
+	unsigned long dword0, dummy1, rma_size;
+	long lpar_rc;
+	int i;
+	
+	/* Get the RMA size */
+	rma_size = lmb.rmo_size;
+	
+	/* Get the VRMA page size */	
+	step = 1 << ppc64_vrma_page_size;
+
+	vaddr = HPTE_V_RMA_VPN + rma_size;
+
+	/* Find hpte's with VRMA mappings */
+	for (; vaddr >= HPTE_V_RMA_VPN; vaddr -= step) {
+		hash = hpt_hash(vaddr, mmu_psize_defs[MMU_PAGE_16M].shift);
+		slot = ((hash & htab_hash_mask) * HPTES_PER_GROUP);	
+
+		for (i = 0; i < HPTES_PER_GROUP; i++) {
+			lpar_rc = plpar_pte_read(0, slot, 
+						&dword0, &dummy1);
+			if (!lpar_rc && dword0 &&
+			((dword0 & HPTE_V_MASK) == MAGIC_SKIP_HPTE)) {
+				/* store the hpte */
+				hpte_vrma_slots[num_hpte_vrma_slots++] = slot;
+				break;
+			}
+			slot++;
+		}
+	}
+}
+
+static inline int check_vrma_slot(int slot)
+{
+	int j;
+
+	for (j = 0; j < num_hpte_vrma_slots; j++)
+		if (hpte_vrma_slots[j] == slot) 
+			return 1;
+
+	return 0;
+
+}
+
 static void pSeries_lpar_hptab_clear(void)
 {
 	unsigned long size_bytes = 1UL << ppc64_pft_size;
@@ -377,8 +427,12 @@ static void pSeries_lpar_hptab_clear(voi
 	int i;
 
 	/* TODO: Use bulk call */
-	for (i = 0; i < hpte_count; i++)
+	for (i = 0; i < hpte_count; i++) {
+		if (have_vrma && check_vrma_slot(i))
+			/* You don't want to remove this hpte */
+			continue;
 		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
+	}
 }
 
 /*
diff -Naurp linux-2.6.22-rc2-vrma/include/asm-powerpc/kexec.h linux-2.6.22-rc2-p6/include/asm-powerpc/kexec.h
--- linux-2.6.22-rc2-vrma/include/asm-powerpc/kexec.h	2007-05-21 15:14:55.000000000 +0530
+++ linux-2.6.22-rc2-p6/include/asm-powerpc/kexec.h	2007-05-21 15:19:14.000000000 +0530
@@ -24,6 +24,8 @@
 
 #define KEXEC_CONTROL_CODE_SIZE 4096
 
+extern void pSeries_find_hpte_vrma(void);
+
 /* The native architecture */
 #ifdef __powerpc64__
 #define KEXEC_ARCH KEXEC_ARCH_PPC64
diff -Naurp linux-2.6.22-rc2-vrma/include/asm-powerpc/mmu-hash64.h linux-2.6.22-rc2-p6/include/asm-powerpc/mmu-hash64.h
--- linux-2.6.22-rc2-vrma/include/asm-powerpc/mmu-hash64.h	2007-05-21 15:14:55.000000000 +0530
+++ linux-2.6.22-rc2-p6/include/asm-powerpc/mmu-hash64.h	2007-05-21 15:23:31.000000000 +0530
@@ -94,6 +94,11 @@ extern char initial_stab[];
 #define HPTE_R_C		ASM_CONST(0x0000000000000080)
 #define HPTE_R_R		ASM_CONST(0x0000000000000100)
 
+#define HPTE_V_RMA_VPN         ASM_CONST(0x001FFFFFF0000000)
+#define HPTE_V_MASK            ASM_CONST(0xc000000000000000)
+#define MAGIC_SKIP_HPTE        ASM_CONST(0x4000000000000000)
+#define HPTE_V_RMA_NUM         16
+
 /* Values for PP (assumes Ks=0, Kp=1) */
 /* pp0 will always be 0 for linux     */
 #define PP_RWXX	0	/* Supervisor read/write, User none */

--------------020709020904030606030702--
