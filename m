Return-Path: <ahuja@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 668F4DDED6
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 16:44:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1I5iCT6024814
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:44:12 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1I5iCMH177536
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 22:44:12 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1I5iBVB000523
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 22:44:11 -0700
Message-ID: <47B91B29.8090602@austin.ibm.com>
Date: Sun, 17 Feb 2008 23:44:09 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 7/8] pseries: phyp dump: Tracking memory range freed.
References: <47B90F55.2080606@austin.ibm.com>
In-Reply-To: <47B90F55.2080606@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com
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
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-18 03:31:22.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-18 03:31:30.000000000 -0600
@@ -260,6 +260,39 @@ void release_memory_range(unsigned long 
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
@@ -284,6 +317,8 @@ static ssize_t store_release_region(stru
 	if (ret != 2)
 		return -EINVAL;
 
+	track_freed_range(start_addr, length);
+
 	/* Range-check - don't free any reserved memory that
 	 * wasn't reserved for phyp-dump */
 	if (start_addr < phyp_dump_info->init_reserve_start)
