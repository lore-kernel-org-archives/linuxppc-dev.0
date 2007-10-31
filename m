Return-Path: <pbadari@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80EAEDDE99
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:46:10 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l9VEjmKp005410
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 10:45:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VFk6Nr061044
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:46:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VFk5u6027315
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:46:06 -0600
Subject: [PATCH 1/3] Add remove_memory() for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 08:49:35 -0800
Message-Id: <1193849375.17412.34.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Supply arch specific remove_memory() for PPC64. There is nothing
ppc specific code here and its exactly same as ia64 version. 
For now, lets keep it arch specific - so each arch can add
its own special things if needed.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 arch/powerpc/mm/mem.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-2.6.23/arch/powerpc/mm/mem.c
===================================================================
--- linux-2.6.23.orig/arch/powerpc/mm/mem.c	2007-10-25 11:34:54.000000000 -0700
+++ linux-2.6.23/arch/powerpc/mm/mem.c	2007-10-25 11:35:24.000000000 -0700
@@ -131,6 +131,20 @@ int __devinit arch_add_memory(int nid, u
 
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+int remove_memory(u64 start, u64 size)
+{
+	unsigned long start_pfn, end_pfn;
+	unsigned long timeout = 120 * HZ;
+	int ret;
+	start_pfn = start >> PAGE_SHIFT;
+	end_pfn = start_pfn + (size >> PAGE_SHIFT);
+	ret = offline_pages(start_pfn, end_pfn, timeout);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(remove_memory);
+#endif /* CONFIG_MEMORY_HOTREMOVE */
+
 void show_mem(void)
 {
 	unsigned long total = 0, reserved = 0;
