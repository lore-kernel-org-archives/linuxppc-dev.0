Return-Path: <clabbe@baylibre.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhJMb4JR5zF1FS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 23:17:58 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id l43so1242587wrc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 04:17:58 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 nfont@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] powerpc: add empty update_numa_cpu_lookup_table for
 !CONFIG_NUMA
Date: Wed, 14 Feb 2018 12:17:47 +0000
Message-Id: <1518610667-23406-1-git-send-email-clabbe@baylibre.com>
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

When CONFIG_NUMA is not set, build fail with:
arch/powerpc/platforms/pseries/hotplug-cpu.c:335:4: error: déclaration implicite de la fonction « update_numa_cpu_lookup_table » [-Werror=implicit-function-declaration]

So we have to add update_numa_cpu_lookup_table as an empty function when CONFIG_NUMA is not set.

Fixes: 1d9a090783be ("powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/powerpc/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 593248110902..9f421641a35c 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -81,6 +81,9 @@ static inline int numa_update_cpu_topology(bool cpus_locked)
 {
 	return 0;
 }
+
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
-- 
2.13.6
