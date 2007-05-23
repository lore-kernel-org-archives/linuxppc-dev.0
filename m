Return-Path: <sachinp@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E3F1DDEC1
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 19:34:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4N9YOOG013006
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 05:34:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4N9YOXJ215192
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:34:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4N9YNxs007540
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:34:24 -0600
Message-ID: <46540AB7.304@in.ibm.com>
Date: Wed, 23 May 2007 15:04:47 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: [Patch 1/2] Kexec/Kdump support POWER6
Content-Type: multipart/mixed; boundary="------------030607050202030104090807"
Cc: Olof Johansson <olof@lixom.net>, Milton Miller II <miltonm@us.ibm.com>
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
--------------030607050202030104090807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Read supported VRMA page size from device tree.

Thanks
-Sachin




--------------030607050202030104090807
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
+++ linux-2.6.22-rc2-vrma/arch/powerpc/kernel/setup_64.c	2007-05-23 11:25:45.000000000 +0530
@@ -73,6 +73,10 @@ int have_of = 1;
 int boot_cpuid = 0;
 u64 ppc64_pft_size;
 
+/* For VRMA */
+u64 ppc64_vrma_page_shift;
+int have_vrma = 0;
+
 /* Pick defaults since we might want to patch instructions
  * before we've read this from the device tree.
  */
diff -Naurp linux-2.6.22-rc2/arch/powerpc/mm/hash_utils_64.c linux-2.6.22-rc2-vrma/arch/powerpc/mm/hash_utils_64.c
--- linux-2.6.22-rc2/arch/powerpc/mm/hash_utils_64.c	2007-05-19 09:36:17.000000000 +0530
+++ linux-2.6.22-rc2-vrma/arch/powerpc/mm/hash_utils_64.c	2007-05-23 11:26:03.000000000 +0530
@@ -199,6 +199,13 @@ static int __init htab_dt_scan_page_size
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
+	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,vrma-page-sizes", &size);
+	if (prop != NULL) {
+		DBG("VRMA Page size from device-tree:\n");
+		ppc64_vrma_page_shift = prop[0];
+		have_vrma = 1;
+	}
+
 	prop = (u32 *)of_get_flat_dt_prop(node,
 					  "ibm,segment-page-sizes", &size);
 	if (prop != NULL) {
diff -Naurp linux-2.6.22-rc2/include/asm-powerpc/page_64.h linux-2.6.22-rc2-vrma/include/asm-powerpc/page_64.h
--- linux-2.6.22-rc2/include/asm-powerpc/page_64.h	2007-05-19 09:36:17.000000000 +0530
+++ linux-2.6.22-rc2-vrma/include/asm-powerpc/page_64.h	2007-05-23 11:25:27.000000000 +0530
@@ -76,6 +76,10 @@ static inline void copy_page(void *to, v
 /* Log 2 of page table size */
 extern u64 ppc64_pft_size;
 
+/* For VRMA */
+extern u64 ppc64_vrma_page_shift;
+extern int have_vrma;
+
 /* Large pages size */
 #ifdef CONFIG_HUGETLB_PAGE
 extern unsigned int HPAGE_SHIFT;

--------------030607050202030104090807--
