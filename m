Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4B559B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 07:12:34 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BABBEDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 07:12:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8BL62n4014133
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:06:02 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8BLCUX3139588
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:12:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8BLCUL4017094
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:12:30 -0400
Message-ID: <4AAABD37.2050205@austin.ibm.com>
Date: Fri, 11 Sep 2009 16:12:23 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] move of_drconf_cell definition to prom.h
References: <4AAABC55.4070207@austin.ibm.com>
In-Reply-To: <4AAABC55.4070207@austin.ibm.com>
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

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: powerpc/arch/powerpc/include/asm/prom.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/prom.h	2009-09-11 12:43:39.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/prom.h	2009-09-11 12:52:11.000000000 -0500
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
--- powerpc.orig/arch/powerpc/mm/numa.c	2009-09-11 12:43:39.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2009-09-11 12:52:11.000000000 -0500
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
