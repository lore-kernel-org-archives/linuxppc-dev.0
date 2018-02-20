Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmHpv4rh2zF19m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 11:07:01 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH 3/6] powerpc: numa: Use the right #ifdef guards around
 functions
Date: Tue, 20 Feb 2018 17:14:21 +0100
Message-Id: <20180220161424.5421-4-j.neuschaefer@gmx.net>
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_node_to_nid and dump_numa_cpu_topology are declared inline in their
respective header files, if CONFIG_NUMA is not set. Thus it is only
valid to define these functions in numa.c if CONFIG_NUMA is set.
(numa.c, despite the name, isn't conditionalized on CONFIG_NUMA, but
CONFIG_NEED_MULTIPLE_NODES.)

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/numa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0570bc2a0b13..df03a65b658f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -254,6 +254,7 @@ static int of_node_to_nid_single(struct device_node *device)
 	return nid;
 }
 
+#ifdef CONFIG_NUMA
 /* Walk the device tree upwards, looking for an associativity id */
 int of_node_to_nid(struct device_node *device)
 {
@@ -272,6 +273,7 @@ int of_node_to_nid(struct device_node *device)
 	return nid;
 }
 EXPORT_SYMBOL(of_node_to_nid);
+#endif
 
 static int __init find_min_common_depth(void)
 {
@@ -744,6 +746,7 @@ static void __init setup_nonnuma(void)
 	}
 }
 
+#ifdef CONFIG_NUMA
 void __init dump_numa_cpu_topology(void)
 {
 	unsigned int node;
@@ -778,6 +781,7 @@ void __init dump_numa_cpu_topology(void)
 		pr_cont("\n");
 	}
 }
+#endif
 
 /* Initialize NODE_DATA for a node on the local memory */
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
-- 
2.16.1
