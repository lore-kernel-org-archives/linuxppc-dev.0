Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6344679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:24:53 +1100 (EST)
Received: from e5.ny.us.ibm.com ([192.168.1.105])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0fe6F005343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:41:40 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0fRjZ015420
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:41:27 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0fHOM256110
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:41:17 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2L0fG4M022738
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:41:16 -0500
Subject: [PATCH 7/7] powerpc numa: Consolidate assignment of cpus to nodes
In-Reply-To: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Date: Mon, 20 Mar 2006 18:37:15 -0600
Message-Id: <11429014352189-git-send-email-nathanl@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can plug the boot cpu into its node independently of whether numa
topology is detected.  And numa_setup_cpu does the right thing for all
cases now, so remove special-casing for non-numa from the cpu hotplug
callback.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

---

 arch/powerpc/mm/numa.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

69d1ca13915d4ba423d43177e491cd176b92e94c
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index fe0ee6d..e9f340d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -321,10 +321,7 @@ static int cpu_numa_callback(struct noti
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		if (min_common_depth == -1 || !numa_enabled)
-			map_cpu_to_node(lcpu, 0);
-		else
-			numa_setup_cpu(lcpu);
+		numa_setup_cpu(lcpu);
 		ret = NOTIFY_OK;
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
@@ -459,8 +456,6 @@ new_range:
 			goto new_range;
 	}
 
-	numa_setup_cpu(boot_cpuid);
-
 	return 0;
 }
 
@@ -475,7 +470,6 @@ static void __init setup_nonnuma(void)
 	printk(KERN_INFO "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
 
-	map_cpu_to_node(boot_cpuid, 0);
 	for (i = 0; i < lmb.memory.cnt; ++i)
 		add_region(0, lmb.memory.region[i].base >> PAGE_SHIFT,
 			   lmb_size_pages(&lmb.memory, i));
@@ -612,6 +606,8 @@ void __init do_init_bootmem(void)
 		dump_numa_memory_topology();
 
 	register_cpu_notifier(&ppc64_numa_nb);
+	cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
+			  (void *)(unsigned long)boot_cpuid);
 
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn, pages_present;
-- 
1.2.4
