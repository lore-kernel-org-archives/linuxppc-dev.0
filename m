Return-Path: <sachinp@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38060DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:24:22 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4MCOKpo010739
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:24:20 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MCOJYj434530
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:24:19 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MCOJ9S001277
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:24:19 -0400
Message-ID: <4652E109.4020204@in.ibm.com>
Date: Tue, 22 May 2007 17:54:41 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [Patch 1/2] Kexec/Kdump support POWER6
References: <4652E088.9080207@in.ibm.com>
In-Reply-To: <4652E088.9080207@in.ibm.com>
Content-Type: multipart/mixed; boundary="------------070402040604080603040507"
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
--------------070402040604080603040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Read supported VRMA page size from device tree.

Thanks
-Sachin



--------------070402040604080603040507
Content-Type: text/plain;
 name="detect-vrma-page-size"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="detect-vrma-page-size"

* Read supported VRMA page size from device tree.

Signed-Off-By : Sachin Sant <sachinp@in.ibm.com>
Signed-Off-By : Mohan Kumar M <mohan@in.ibm.com>
---

diff -Naurp linux-2.6.22-rc2/arch/powerpc/kernel/setup_64.c linux-2.6.22-rc2-vrma/arch/powerpc/kernel/setup_64.c
--- linux-2.6.22-rc2/arch/powerpc/kernel/setup_64.c	2007-05-19 09:36:17.000000000 +0530
+++ linux-2.6.22-rc2-vrma/arch/powerpc/kernel/setup_64.c	2007-05-21 15:15:30.000000000 +0530
@@ -73,6 +73,10 @@ int have_of = 1;
 int boot_cpuid = 0;
 u64 ppc64_pft_size;
 
+/* For VRMA */
+u64 ppc64_vrma_page_size;
+int have_vrma = 0;
+
 /* Pick defaults since we might want to patch instructions
  * before we've read this from the device tree.
  */
diff -Naurp linux-2.6.22-rc2/arch/powerpc/mm/hash_utils_64.c linux-2.6.22-rc2-vrma/arch/powerpc/mm/hash_utils_64.c
--- linux-2.6.22-rc2/arch/powerpc/mm/hash_utils_64.c	2007-05-19 09:36:17.000000000 +0530
+++ linux-2.6.22-rc2-vrma/arch/powerpc/mm/hash_utils_64.c	2007-05-21 15:18:10.000000000 +0530
@@ -199,6 +199,13 @@ static int __init htab_dt_scan_page_size
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
+	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,vrma-page-sizes", &size);
+	if (prop != NULL) {
+		DBG("VRMA Page size from device-tree:\n");
+		ppc64_vrma_page_size = prop[0];
+		have_vrma = 1;
+	}
+
 	prop = (u32 *)of_get_flat_dt_prop(node,
 					  "ibm,segment-page-sizes", &size);
 	if (prop != NULL) {
diff -Naurp linux-2.6.22-rc2/include/asm-powerpc/page_64.h linux-2.6.22-rc2-vrma/include/asm-powerpc/page_64.h
--- linux-2.6.22-rc2/include/asm-powerpc/page_64.h	2007-05-19 09:36:17.000000000 +0530
+++ linux-2.6.22-rc2-vrma/include/asm-powerpc/page_64.h	2007-05-21 15:15:30.000000000 +0530
@@ -76,6 +76,10 @@ static inline void copy_page(void *to, v
 /* Log 2 of page table size */
 extern u64 ppc64_pft_size;
 
+/* For VRMA */
+extern u64 ppc64_vrma_page_size;
+extern int have_vrma;
+
 /* Large pages size */
 #ifdef CONFIG_HUGETLB_PAGE
 extern unsigned int HPAGE_SHIFT;

--------------070402040604080603040507--
