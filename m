Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1D52B711C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 16:08:16 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0L4i3Jo008085
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 23:44:09 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 208D272805F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 00:01:38 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0L51bLf191018
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jan 2011 00:01:37 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0L51aig017817
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jan 2011 03:01:37 -0200
Date: Fri, 21 Jan 2011 03:01:35 -0200
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20110121050135.5062.61349.sendpatchset@oc7304238415.ibm.com>
In-Reply-To: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
References: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
Subject: [PATCH 3/4] powerpc/pseries: Remove unnecessary variable
	initializations in numa.c
Cc: markn@au1.ibm.com, tbreeds@au1.ibm.com, lkessler@us.ibm.com,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>, mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Remove unnecessary variable initializations in VPHN functions.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index db36a2c..f7971d2 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1278,10 +1278,10 @@ int stop_topology_update(void);
  */
 static void setup_cpu_associativity_change_counters(void)
 {
-	int cpu = 0;
+	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		int i = 0;
+		int i;
 		u8 *counts = vphn_cpu_change_counts[cpu];
 		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
 
@@ -1303,7 +1303,7 @@ static void setup_cpu_associativity_change_counters(void)
  */
 static int update_cpu_associativity_changes_mask(void)
 {
-	int cpu = 0, nr_cpus = 0;
+	int cpu, nr_cpus = 0;
 	cpumask_t *changes = &cpu_associativity_changes_mask;
 
 	cpumask_clear(changes);
@@ -1337,8 +1337,7 @@ static int update_cpu_associativity_changes_mask(void)
  */
 static int vphn_unpack_associativity(const long *packed, unsigned int *unpacked)
 {
-	int i = 0;
-	int nr_assoc_doms = 0;
+	int i, nr_assoc_doms = 0;
 	const u16 *field = (const u16*) packed;
 
 #define VPHN_FIELD_UNUSED	(0xffff)
@@ -1377,7 +1376,7 @@ static int vphn_unpack_associativity(const long *packed, unsigned int *unpacked)
  */
 static long hcall_vphn(unsigned long cpu, unsigned int *associativity)
 {
-	long rc = 0;
+	long rc;
 	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
 	u64 flags = 1;
 	int hwcpu = get_hard_smp_processor_id(cpu);
@@ -1391,7 +1390,7 @@ static long hcall_vphn(unsigned long cpu, unsigned int *associativity)
 static long vphn_get_associativity(unsigned long cpu,
 					unsigned int *associativity)
 {
-	long rc = 0;
+	long rc;
 
 	rc = hcall_vphn(cpu, associativity);
 
@@ -1417,9 +1416,9 @@ static long vphn_get_associativity(unsigned long cpu,
  */
 int arch_update_cpu_topology(void)
 {
-	int cpu = 0, nid = 0, old_nid = 0;
+	int cpu, nid, old_nid;
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
-	struct sys_device *sysdev = NULL;
+	struct sys_device *sysdev;
 
 	for_each_cpu_mask(cpu, cpu_associativity_changes_mask) {
 		vphn_get_associativity(cpu, associativity);
-- 
1.7.3.4
