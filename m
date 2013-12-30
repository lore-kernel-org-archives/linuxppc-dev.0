Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D3402C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 22:41:24 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 30 Dec 2013 17:11:14 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5F747394002D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 17:11:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBUBf9Kq48562256
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 17:11:10 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBUBfAkH022652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 17:11:11 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc: Add debug checks to catch invalid cpu-to-node
 mappings
To: benh@kernel.crashing.org, paulus@samba.org, nfont@linux.vnet.ibm.com
Date: Mon, 30 Dec 2013 17:06:04 +0530
Message-ID: <20131230113554.11508.45801.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20131230113517.11508.7224.stgit@srivatsabhat.in.ibm.com>
References: <20131230113517.11508.7224.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There have been some weird bugs in the past where the kernel tried to associate
threads of the same core to different NUMA nodes, and things went haywire after
that point (as expected).

But unfortunately, root-causing such issues have been quite challenging, due to
the lack of appropriate debug checks in the kernel. These bugs usually lead to
some odd soft-lockups in the scheduler's build-sched-domain code in the CPU
hotplug path, which makes it very hard to trace it back to the incorrect
cpu-to-node mappings.

So add appropriate debug checks to catch such invalid cpu-to-node mappings
as early as possible.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/mm/numa.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 6847d50..4f50c6a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -570,16 +570,38 @@ out:
 	return nid;
 }
 
+static void verify_cpu_node_mapping(int cpu, int node)
+{
+	int base, sibling, i;
+
+	/* Verify that all the threads in the core belong to the same node */
+	base = cpu_first_thread_sibling(cpu);
+
+	for (i = 0; i < threads_per_core; i++) {
+		sibling = base + i;
+
+		if (sibling == cpu || cpu_is_offline(sibling))
+			continue;
+
+		if (cpu_to_node(sibling) != node) {
+			WARN(1, "CPU thread siblings %d and %d don't belong"
+				" to the same node!\n", cpu, sibling);
+			break;
+		}
+	}
+}
+
 static int cpu_numa_callback(struct notifier_block *nfb, unsigned long action,
 			     void *hcpu)
 {
 	unsigned long lcpu = (unsigned long)hcpu;
-	int ret = NOTIFY_DONE;
+	int ret = NOTIFY_DONE, nid;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
-		numa_setup_cpu(lcpu);
+		nid = numa_setup_cpu(lcpu);
+		verify_cpu_node_mapping((int)lcpu, nid);
 		ret = NOTIFY_OK;
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
