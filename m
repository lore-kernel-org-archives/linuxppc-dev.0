Return-Path: <ahuja@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C691DDDEA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:39:56 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m080dseW024043
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:39:54 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m080dsdA487524
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:39:54 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m080drlg020123
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:39:54 -0500
Message-ID: <4782C658.4050901@austin.ibm.com>
Date: Mon, 07 Jan 2008 18:39:52 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] pseries: phyp dump: Tracking memory range freed.
References: <4782B985.2090508@austin.ibm.com>
In-Reply-To: <4782B985.2090508@austin.ibm.com>
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
 arch/powerpc/platforms/pseries/phyp_dump.c |   36 +++++++++++++++++++++++++++++
 include/asm-powerpc/phyp_dump.h            |    3 ++
 2 files changed, 39 insertions(+)

Index: 2.6.24-rc5/include/asm-powerpc/phyp_dump.h
===================================================================
--- 2.6.24-rc5.orig/include/asm-powerpc/phyp_dump.h	2008-01-07 22:55:28.000000000 -0600
+++ 2.6.24-rc5/include/asm-powerpc/phyp_dump.h	2008-01-07 22:58:02.000000000 -0600
@@ -24,6 +24,9 @@ struct phyp_dump {
 	/* Memory that is reserved during very early boot. */
 	unsigned long init_reserve_start;
 	unsigned long init_reserve_size;
+	/* Scratch area memory details */
+	unsigned long scratch_reserve_start;
+	unsigned long scratch_reserve_size;
 };
 
 extern struct phyp_dump *phyp_dump_info;
Index: 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-07 22:57:27.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/platforms/pseries/phyp_dump.c	2008-01-07 22:58:02.000000000 -0600
@@ -287,6 +287,39 @@ release_memory_range(unsigned long start
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
+	if ((addr >= phyp_dump_info->scratch_reserve_start) &&
+	    (addr <= phyp_dump_info->scratch_reserve_start +
+	     phyp_dump_info->scratch_reserve_size))
+		scratch_area_size += length;
+
+	if ((reserved_area_size == phyp_dump_info->init_reserve_start) &&
+	    (scratch_area_size == phyp_dump_info->scratch_reserve_size)) {
+
+		invalidate_last_dump(&phdr,
+				phyp_dump_info->scratch_reserve_start);
+		register_dump_area (&phdr,
+				phyp_dump_info->scratch_reserve_start);
+	}
+}
+
 /* ------------------------------------------------- */
 /**
  * sysfs_release_region -- sysfs interface to release memory range.
@@ -310,6 +343,8 @@ store_release_region(struct kset *kset, 
 	if (ret != 2)
 		return -EINVAL;
 
+	track_freed_range(start_addr, length);
+
 	/* Range-check - don't free any reserved memory that
 	 * wasn't reserved for phyp-dump */
 	if (start_addr < phyp_dump_info->init_reserve_start)
@@ -414,6 +449,7 @@ static int __init phyp_dump_setup(void)
 	}
 
 	/* Don't allow user to release the 256MB scratch area */
+	/* this might be wrong */
 	phyp_dump_info->init_reserve_size = free_area_length;
 
 	/* Should we create a dump_subsys, analogous to s390/ipl.c ? */
