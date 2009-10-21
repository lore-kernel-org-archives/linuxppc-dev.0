Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D784BB7BC1
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 01:43:15 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9LEf7Mb024384
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:41:07 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9LEguum210030
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:42:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9LEgjlu021399
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:42:46 -0600
Message-ID: <4ADF1DE1.2070303@austin.ibm.com>
Date: Wed, 21 Oct 2009 09:42:41 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5 v4] move of_drconf_cell definition to prom.h
References: <4ADF1C49.2030201@austin.ibm.com>
In-Reply-To: <4ADF1C49.2030201@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the definition of the of_drconf_cell struct from numa.c to prom.h.  This
is needed so that we can parse the ibm,dynamic-memory device-tree property
when DLPAR adding and removing memory.

Signed-off-by: Nathan Fontenot <nfont at austin.ibm.com>
---

Index: powerpc/arch/powerpc/include/asm/prom.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/prom.h	2009-10-19 11:56:51.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/prom.h	2009-10-19 11:59:31.000000000 -0500
@@ -349,6 +349,18 @@
  */
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
+struct of_drconf_cell {
+	u64	base_addr;
+	u32	drc_index;
+	u32	reserved;
+	u32	aa_index;
+	u32	flags;
+};
+
+#define DRCONF_MEM_ASSIGNED	0x00000008
+#define DRCONF_MEM_AI_INVALID	0x00000040
+#define DRCONF_MEM_RESERVED	0x00000080
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/of.h
Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2009-10-19 11:56:51.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2009-10-19 11:59:31.000000000 -0500
@@ -296,18 +296,6 @@
 	return result;
 }
 
-struct of_drconf_cell {
-	u64	base_addr;
-	u32	drc_index;
-	u32	reserved;
-	u32	aa_index;
-	u32	flags;
-};
-
-#define DRCONF_MEM_ASSIGNED	0x00000008
-#define DRCONF_MEM_AI_INVALID	0x00000040
-#define DRCONF_MEM_RESERVED	0x00000080
-
 /*
  * Read the next lmb list entry from the ibm,dynamic-memory property
  * and return the information in the provided of_drconf_cell structure.
