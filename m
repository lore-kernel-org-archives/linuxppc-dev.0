Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE9BD679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:42:16 +1100 (EST)
Received: from e33.co.us.ibm.com (e33.boulder.ibm.com [9.17.249.43])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0dK90002889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:39:20 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0dHsM016963
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:39:17 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0gGwu151176
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 17:42:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2L0dGDN023805
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 17:39:16 -0700
Subject: [PATCH 3/7] powerpc numa: Minor cpu hotplug-related cleanups
In-Reply-To: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Date: Mon, 20 Mar 2006 18:35:15 -0600
Message-Id: <11429013151912-git-send-email-nathanl@austin.ibm.com>
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

map_cpu_to_node does not need to be inline, it is never called in a
hot path.

map_cpu_to_node, numa_setup_cpu, and find_cpu_node can be marked
__cpuinit, as they are never used after boot if CONFIG_HOTPLUG_CPU=n.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

---

 arch/powerpc/mm/numa.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

5685935151d9ed413571e03b8e7c9b4673bd5e88
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index de99e47..1c3df1d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -129,7 +129,7 @@ void __init get_region(unsigned int nid,
 		*start_pfn = 0;
 }
 
-static inline void map_cpu_to_node(int cpu, int node)
+static void __cpuinit map_cpu_to_node(int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
 
@@ -155,7 +155,7 @@ static void unmap_cpu_from_node(unsigned
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static struct device_node *find_cpu_node(unsigned int cpu)
+static struct device_node * __cpuinit find_cpu_node(unsigned int cpu)
 {
 	unsigned int hw_cpuid = get_hard_smp_processor_id(cpu);
 	struct device_node *cpu_node = NULL;
@@ -284,7 +284,7 @@ static unsigned long __devinit read_n_ce
  * Figure out to which domain a cpu belongs and stick it there.
  * Return the id of the domain used.
  */
-static int numa_setup_cpu(unsigned long lcpu)
+static int __cpuinit numa_setup_cpu(unsigned long lcpu)
 {
 	int numa_domain = 0;
 	struct device_node *cpu = find_cpu_node(lcpu);
-- 
1.2.4
