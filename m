Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA6E3B71C9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:51:41 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4K7jcbK019597
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:45:38 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4K7pctn868538
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:51:40 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4K7pcJj011233
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:51:38 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Fix hard CPU IDs detection
Date: Fri, 20 May 2011 17:51:15 +1000
Message-Id: <1305877875-23157-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1305877875-23157-1-git-send-email-benh@kernel.crashing.org>
References: <1305877875-23157-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 9d07bc841c9779b4d7902e417f4e509996ce805d
"powerpc: Properly handshake CPUs going out of boot spin loop"

Would cause a miscalculation of the hard CPU ID. It removes breaking
out of the loop when finding a match with a processor, thus the "i"
used as an index in the intserv array is always incorrect

This broke interrupt on my PowerMac laptop.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5311a26..48aeb55 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -278,6 +278,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	int i, nthreads;
 	unsigned long len;
 	int found = -1;
+	int found_thread = 0;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -301,9 +302,11 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		 * version 2 of the kexec param format adds the phys cpuid of
 		 * booted proc.
 		 */
-		if (initial_boot_params && initial_boot_params->version >= 2) {
-			if (intserv[i] == initial_boot_params->boot_cpuid_phys)
+		if (initial_boot_params->version >= 2) {
+			if (intserv[i] == initial_boot_params->boot_cpuid_phys) {
 				found = boot_cpu_count;
+				found_thread = i;
+			}
 		} else {
 			/*
 			 * Check if it's the boot-cpu, set it's hw index now,
@@ -322,9 +325,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 
 	if (found >= 0) {
 		DBG("boot cpu: logical %d physical %d\n", found,
-			intserv[i]);
+			intserv[found_thread]);
 		boot_cpuid = found;
-		set_hard_smp_processor_id(found, intserv[i]);
+		set_hard_smp_processor_id(found, intserv[found_thread]);
 
 		/*
 		 * PAPR defines "logical" PVR values for cpus that
-- 
1.7.1
