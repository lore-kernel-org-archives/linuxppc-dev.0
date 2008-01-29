Return-Path: <pbadari@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA696DDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 11:28:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0T0Sdsf004724
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 19:28:39 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0T0Sc0G106572
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 17:28:38 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0T0ScJn011164
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 17:28:38 -0700
Subject: [-mm PATCH] updates for hotplug memory remove
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 28 Jan 2008 16:31:22 -0800
Message-Id: <1201566682.29357.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linux-mm <linux-mm@kvack.org>, pbadari@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

Here are the updates for hotplug memory remove code currently in -mm.

1) Please don't push this patch to mainline (for the merge window).

memory-hotplug-add-removable-to-sysfs-to-show-memblock-removability.patch

I didn't find this consistently useful - even though memory is marked
removable, I found cases where I can't move it. When we get it right,
we can push it at that time. Please leave this in -mm.

2) Can you replace the following patch with this ?

add-remove_memory-for-ppc64-2.patch

I found that, I do need arch-specific hooks to get the memory remove
working on ppc64 LPAR. Earlier, I tried to make remove_memory() arch
neutral, but we do need arch specific hooks.

Thanks,
Badari

Supply ppc64 remove_memory() function. Arch specific is still
being reviewed by Paul Mackerras.

From: Badari Pulavarty <pbadari@us.ibm.com>
---
 arch/powerpc/mm/mem.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6.24-rc8/arch/powerpc/mm/mem.c
===================================================================
--- linux-2.6.24-rc8.orig/arch/powerpc/mm/mem.c	2008-01-25 08:04:32.000000000 -0800
+++ linux-2.6.24-rc8/arch/powerpc/mm/mem.c	2008-01-25 08:16:37.000000000 -0800
@@ -145,6 +145,22 @@ walk_memory_resource(unsigned long start
 	return  (*func)(start_pfn, nr_pages, arg);
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+int remove_memory(u64 start, u64 size)
+{
+	unsigned long start_pfn, end_pfn;
+	int ret;
+
+	start_pfn = start >> PAGE_SHIFT;
+	end_pfn = start_pfn + (size >> PAGE_SHIFT);
+	ret = offline_pages(start_pfn, end_pfn, 120 * HZ);
+	if (ret)
+		goto out;
+	/* Arch-specific calls go here - next patch */
+out:
+	return ret;
+}
+#endif /* CONFIG_MEMORY_HOTREMOVE */
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 void show_mem(void)
