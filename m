Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBjg3MJdzDrB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:08:23 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBjf4nSCz9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:08:22 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 41/41] powerpc: Fix build with CONFIG_MEMORY_HOTPLUG on some
 configs
Date: Tue,  5 Jul 2016 15:07:54 +1000
Message-Id: <1467695274-14667-41-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
References: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For memory hotplug to work, the MMU code needs to provide the functions
create_section_mapping() and remove_section_mapping() to respectively
map and unmap portions of the linear mapping.

At the moment only hash64 provides these, so we provide weak stubs that
just error out. This fixes the build with configurations such as 64-bit
BookE with CONFIG_MEMORY_HOTPLUG enabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/mem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 2fd57fa..b0b8f25 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -116,6 +116,16 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 #endif
 
+int __weak create_section_mapping(unsigned long start, unsigned long end)
+{
+	return -ENODEV;
+}
+
+int __weak remove_section_mapping(unsigned long start, unsigned long end)
+{
+	return -ENODEV;
+}
+
 int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 {
 	struct pglist_data *pgdata;
-- 
2.7.4
