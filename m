Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A734DDF07
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 11:34:17 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1T0XNJv007407
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:33:23 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1T0XNos301250
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:33:23 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1T0XMKT013413
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:33:22 -0500
Message-ID: <47C752D0.7020304@austin.ibm.com>
Date: Thu, 28 Feb 2008 18:33:20 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH 7/8] pseries: phyp dump: Tracking memory range freed.
References: <47B90F55.2080606@austin.ibm.com>	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com>
In-Reply-To: <47C74A66.1060105@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch tracks the size freed. For now it does a simple
rudimentary calculation of the ranges freed. The idea is
to keep it simple at the external shell script level and 
send in large chunks for now.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
-----

---
 arch/powerpc/platforms/pseries/phyp_dump.c |   35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-28 23:36:47.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-28 23:36:49.000000000 -0600
@@ -262,6 +262,39 @@ void release_memory_range(unsigned long 
 	}
 }
 
+/**
+ * track_freed_range -- Counts the range being freed.
+ * Once the counter goes to zero, it re-registers dump for
+ * future use.
+ */
+static void
+track_freed_range(unsigned long addr, unsigned long length)
+{
+	static unsigned long scratch_area_size, reserved_area_size;
+
+	if (addr < phyp_dump_info->init_reserve_start)
+		return;
+
+	if ((addr >= phyp_dump_info->init_reserve_start) &&
+	    (addr <= phyp_dump_info->init_reserve_start +
+	     phyp_dump_info->init_reserve_size))
+		reserved_area_size += length;
+
+	if ((addr >= phyp_dump_info->reserved_scratch_addr) &&
+	    (addr <= phyp_dump_info->reserved_scratch_addr +
+	     phyp_dump_info->reserved_scratch_size))
+		scratch_area_size += length;
+
+	if ((reserved_area_size == phyp_dump_info->init_reserve_size) &&
+	    (scratch_area_size == phyp_dump_info->reserved_scratch_size)) {
+
+		invalidate_last_dump(&phdr,
+				phyp_dump_info->reserved_scratch_addr);
+		register_dump_area(&phdr,
+				phyp_dump_info->reserved_scratch_addr);
+	}
+}
+
 /* ------------------------------------------------- */
 /**
  * sysfs_release_region -- sysfs interface to release memory range.
@@ -286,6 +319,8 @@ static ssize_t store_release_region(stru
 	if (ret != 2)
 		return -EINVAL;
 
+	track_freed_range(start_addr, length);
+
 	/* Range-check - don't free any reserved memory that
 	 * wasn't reserved for phyp-dump */
 	if (start_addr < phyp_dump_info->init_reserve_start)
