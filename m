Return-Path: <nfont@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA968DDFBB
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 07:30:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KLUmrs011469
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:30:48 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KLUmhU175552
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:30:48 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KLUmL8011279
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:30:48 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5KLUlYD011246
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:30:48 -0400
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m5KLUlop045746
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:30:47 -0500
Message-ID: <485C2187.2040700@austin.ibm.com>
Date: Fri, 20 Jun 2008 16:30:47 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] Use the base address of lmbs instead of drc index for
	dlpar
References: <485C2033.20101@austin.ibm.com>
In-Reply-To: <485C2033.20101@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the base address of the lmb to get the starting page frame number
instead of trying to extract it from the drc index of the lmb.

In the previous representations of memory in the device tree, the drc index
of a lmb would match up with the base address of the lmb.  For example a
lmb woulf have a drc index of 8000000a and a base address of a0000000.  This
allowed the starting page frame number to be extracted from the drc index.

The lmbs represented under the ibm,dynamic-reconfiguration-memory nodein the
device tree do not always have a drc index that matches, thus we need to
get the starting page frame number from the base address of an lmb instead
of the drc index.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6.git/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-06-20 
12:08:41.000000000 -0500
+++ linux-2.6.git/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-06-20 
12:40:21.000000000 -0500
@@ -18,8 +18,9 @@
  static int pseries_remove_memory(struct device_node *np)
  {
  	const char *type;
-	const unsigned int *my_index;
  	const unsigned int *regs;
+	unsigned long base;
+	unsigned int lmb_size;
  	u64 start_pfn, start;
  	struct zone *zone;
  	int ret = -EINVAL;
@@ -32,17 +33,16 @@
  		return 0;

  	/*
-	 * Find the memory index and size of the removing section
+	 * Find the base address and size of the lmb
  	 */
-	my_index = of_get_property(np, "ibm,my-drc-index", NULL);
-	if (!my_index)
-		return ret;
-
  	regs = of_get_property(np, "reg", NULL);
  	if (!regs)
  		return ret;

-	start_pfn = section_nr_to_pfn(*my_index & 0xffff);
+	base = *(unsigned long *)regs;
+	lmb_size = regs[3];
+
+	start_pfn = base >> PFN_SECTION_SHIFT;
  	zone = page_zone(pfn_to_page(start_pfn));

  	/*
@@ -54,29 +54,29 @@
  	 * to sysfs "state" file and we can't remove sysfs entries
  	 * while writing to it. So we have to defer it to here.
  	 */
-	ret = __remove_pages(zone, start_pfn, regs[3] >> PAGE_SHIFT);
+	ret = __remove_pages(zone, start_pfn, lmb_size >> PAGE_SHIFT);
  	if (ret)
  		return ret;

  	/*
  	 * Update memory regions for memory remove
  	 */
-	lmb_remove(start_pfn << PAGE_SHIFT, regs[3]);
+	lmb_remove(base, lmb_size);

  	/*
  	 * Remove htab bolted mappings for this section of memory
  	 */
-	start = (unsigned long)__va(start_pfn << PAGE_SHIFT);
-	ret = remove_section_mapping(start, start + regs[3]);
+	start = (unsigned long)__va(base);
+	ret = remove_section_mapping(start, start + lmb_size);
  	return ret;
  }

  static int pseries_add_memory(struct device_node *np)
  {
  	const char *type;
-	const unsigned int *my_index;
  	const unsigned int *regs;
-	u64 start_pfn;
+	unsigned long base;
+	unsigned int lmb_size;
  	int ret = -EINVAL;

  	/*
@@ -87,22 +87,19 @@
  		return 0;

  	/*
-	 * Find the memory index and size of the added section
+	 * Find the base and size of the lmb
  	 */
-	my_index = of_get_property(np, "ibm,my-drc-index", NULL);
-	if (!my_index)
-		return ret;
-
  	regs = of_get_property(np, "reg", NULL);
  	if (!regs)
  		return ret;

-	start_pfn = section_nr_to_pfn(*my_index & 0xffff);
+	base = *(unsigned long *)regs;
+	lmb_size = regs[3];

  	/*
  	 * Update memory region to represent the memory add
  	 */
-	lmb_add(start_pfn << PAGE_SHIFT, regs[3]);
+	lmb_add(base, lmb_size);
  	return 0;
  }
