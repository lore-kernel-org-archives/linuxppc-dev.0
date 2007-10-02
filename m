Return-Path: <pbadari@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 275A6DDE26
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 03:26:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l92HQp1E007419
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 13:26:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l92HQpbG501298
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 11:26:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l92HQo2N028731
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 11:26:51 -0600
Subject: [RFC] PPC64 Exporting memory information through /proc/iomem
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 02 Oct 2007 10:29:56 -0700
Message-Id: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linux-mm <linux-mm@kvack.org>, anton@au1.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul & Ben,

I am trying to get hotplug memory remove working on ppc64.
In order to verify a given memory region, if its valid or not -
current hotplug-memory patches used /proc/iomem. On IA64 and
x86-64 /proc/iomem shows all memory regions. 

I am wondering, if its acceptable to do the same on ppc64 also ?
Otherwise, we need to add arch-specific hooks in hotplug-remove
code to be able to do this.

Please comment. Here is the half-cooked patch I used to verify
the hotplug-memory-remove on ppc64.

Thanks,
Badari

---
 arch/powerpc/mm/numa.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: linux-2.6.23-rc8/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.23-rc8.orig/arch/powerpc/mm/numa.c	2007-10-02 10:16:42.000000000 -0700
+++ linux-2.6.23-rc8/arch/powerpc/mm/numa.c	2007-10-02 10:17:05.000000000 -0700
@@ -587,6 +587,22 @@ static void __init *careful_allocation(i
 	return (void *)ret;
 }
 
+static void add_regions_iomem()
+{
+	int i;
+	struct resource *res;
+
+	for (i = 0; i < lmb.memory.cnt; i++) {
+		res = alloc_bootmem_low(sizeof(struct resource));
+
+		res->name = "System RAM";
+		res->start = lmb.memory.region[i].base;
+		res->end = res->start + lmb.memory.region[i].size - 1;
+		res->flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, res);
+	}
+}
+
 static struct notifier_block __cpuinitdata ppc64_numa_nb = {
 	.notifier_call = cpu_numa_callback,
 	.priority = 1 /* Must run before sched domains notifier. */
@@ -650,6 +666,8 @@ void __init do_init_bootmem(void)
 
 		free_bootmem_with_active_regions(nid, end_pfn);
 
+		add_regions_iomem();
+
 		/* Mark reserved regions on this node */
 		for (i = 0; i < lmb.reserved.cnt; i++) {
 			unsigned long physbase = lmb.reserved.region[i].base;
