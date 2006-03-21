Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A923867A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:50:43 +1100 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0cdMK002805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:38:40 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0cQuG002095
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:38:26 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0cGOM238818
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:38:16 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2L0cGwh020172
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:38:16 -0500
Subject: [PATCH 1/7] powerpc numa: fix boot_cpuid always assigned to node 0
In-Reply-To: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Date: Mon, 20 Mar 2006 18:34:15 -0600
Message-Id: <11429012552739-git-send-email-nathanl@austin.ibm.com>
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

At boot, the numa code is assigning boot_cpuid to node 0
unconditionally.  Basically, numa_setup_cpu is being stupid about it,
but this is the minimal fix -- just call numa_setup_cpu(boot_cpuid)
later, after all nodes have been set online.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

---

 arch/powerpc/mm/numa.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

d5ecb195c3b93cb954264e075c7fe29a0bdc6db7
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 2863a91..b813bad 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -375,7 +375,7 @@ static int __init parse_numa_properties(
 {
 	struct device_node *cpu = NULL;
 	struct device_node *memory = NULL;
-	int max_domain;
+	int max_domain = 0;
 	unsigned long i;
 
 	if (numa_enabled == 0) {
@@ -389,8 +389,6 @@ static int __init parse_numa_properties(
 	if (min_common_depth < 0)
 		return min_common_depth;
 
-	max_domain = numa_setup_cpu(boot_cpuid);
-
 	/*
 	 * Even though we connect cpus to numa domains later in SMP init,
 	 * we need to know the maximum node id now. This is because each
@@ -469,6 +467,8 @@ new_range:
 	for (i = 0; i <= max_domain; i++)
 		node_set_online(i);
 
+	max_domain = numa_setup_cpu(boot_cpuid);
+
 	return 0;
 }
 
-- 
1.2.4
