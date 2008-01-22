Return-Path: <ahuja@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64BBFDDECE
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:07:33 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0ML7UYd012181
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 16:07:30 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0ML7UpT076910
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:07:30 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0ML7QLC027707
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:07:27 -0700
Message-ID: <47965B0C.8000201@austin.ibm.com>
Date: Tue, 22 Jan 2008 15:07:24 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
Subject: [PATCH 7/8] pseries: phyp dump: Tracking memory range freed.
References: <4796401D.5010907@austin.ibm.com>
In-Reply-To: <4796401D.5010907@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com, lkessler@us.ibm.com,
	strosake@us.ibm.com
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

Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-21 23:30:18.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-21 23:42:04.000000000 -0600
@@ -275,6 +275,39 @@ void release_memory_range(unsigned long 
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
+		register_dump_area (&phdr,
+				phyp_dump_info->reserved_scratch_addr);
+	}
+}
+
 /* ------------------------------------------------- */
 /**
  * sysfs_release_region -- sysfs interface to release memory range.
@@ -298,6 +331,8 @@ ssize_t store_release_region(struct kset
 	if (ret != 2)
 		return -EINVAL;
 
+	track_freed_range(start_addr, length);
+
 	/* Range-check - don't free any reserved memory that
 	 * wasn't reserved for phyp-dump */
 	if (start_addr < phyp_dump_info->init_reserve_start)
