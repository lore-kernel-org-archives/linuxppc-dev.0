Return-Path: <sachinp@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46C88DDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 19:37:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4N9bT2F027112
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 05:37:29 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4N9bT5U270030
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:37:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4N9bSxS017079
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:37:28 -0600
Message-ID: <46540B6F.6030300@in.ibm.com>
Date: Wed, 23 May 2007 15:07:51 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
Subject: [Patch 2/2] Kexec/Kdump support - POWER6
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
In-Reply-To: <20070522153419.GA22047@lixom.net>
Content-Type: multipart/mixed; boundary="------------000407060709060005030509"
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
	Milton Miller II <miltonm@us.ibm.com>
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
--------------000407060709060005030509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Power machines supporting VRMA, Kexec/Kdump does not work.
Hypervisor stores VRMA mapping used by the OS, in the hpte hash
tables. Make sure these hpte entries are left untouched.

This patch also adds plpar_pte_read_raw() on the lines of 
plpar_pte_remove_raw().

Thanks
-Sachin





--------------000407060709060005030509
Content-Type: text/plain;
 name="kexec-kdump-support-on-POWER6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec-kdump-support-on-POWER6"

* On Power machines supporting VRMA, Kexec/Kdump does not work.
* Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
* Make sure these hpte entries are left untouched.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---

diff -Naurp linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/lpar.c linux-2.6.22-rc2-kexec/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/lpar.c	2007-05-19 09:36:17.000000000 +0530
+++ linux-2.6.22-rc2-kexec/arch/powerpc/platforms/pseries/lpar.c	2007-05-23 13:47:54.000000000 +0530
@@ -369,6 +369,62 @@ static long pSeries_lpar_hpte_remove(uns
 	return -1;
 }
 
+#define VRMA_VPN        ASM_CONST(0x001FFFFFF0000000)
+#define VRMA_MASK       ASM_CONST(0xc000000000000000)
+#define VRMA_HPTE_B_1TB ASM_CONST(0x4000000000000000)
+#define VRMA_NUM        16
+
+unsigned long hpte_vrma_slots[VRMA_NUM];
+unsigned int num_hpte_vrma_slots = 0;
+
+static void pSeries_save_hpte_vrma(void)
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
+	step = 1 << ppc64_vrma_page_shift;
+
+	vaddr = VRMA_VPN + rma_size;
+
+	/* Find hpte's with VRMA mappings */
+	for (; vaddr >= VRMA_VPN; vaddr -= step) {
+		hash = hpt_hash(vaddr, ppc64_vrma_page_shift);
+		slot = ((hash & htab_hash_mask) * HPTES_PER_GROUP);	
+
+		for (i = 0; i < HPTES_PER_GROUP; i++) {
+			lpar_rc = plpar_pte_read_raw(0, slot, 
+						&dword0, &dummy1);
+			if (!lpar_rc && dword0 &&
+				((dword0 & VRMA_MASK) == VRMA_HPTE_B_1TB) &&
+				(num_hpte_vrma_slots < VRMA_NUM)) {
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
@@ -376,9 +432,16 @@ static void pSeries_lpar_hptab_clear(voi
 	unsigned long dummy1, dummy2;
 	int i;
 
+	if (have_vrma)
+		pSeries_save_hpte_vrma();
+
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
diff -Naurp linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/plpar_wrappers.h linux-2.6.22-rc2-kexec/arch/powerpc/platforms/pseries/plpar_wrappers.h
--- linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-19 09:36:17.000000000 +0530
+++ linux-2.6.22-rc2-kexec/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-23 11:38:12.000000000 +0530
@@ -108,6 +108,21 @@ static inline long plpar_pte_read(unsign
 	return rc;
 }
 
+/* plpar_pte_read_raw can be called in real mode. It calls plpar_hcall_raw */
+static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
+		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall_raw(H_READ, retbuf, flags, ptex);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
 static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 		unsigned long avpn)
 {

--------------000407060709060005030509--
