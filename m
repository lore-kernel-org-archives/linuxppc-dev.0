Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hc4B45gWzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 16:06:18 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id y4-v6so2331596pgp.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 23:06:18 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, mikey@neuling.org,
 benh@kernel.crashing.org, paulus@samba.org, bsingharora@gmail.com
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH 1/2] powerpc: Allow memory that has been hot-removed to be
 hot-added
Date: Fri,  3 Aug 2018 16:06:00 +1000
Message-Id: <20180803060601.724-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch allows the memory removed by memtrace to be readded to the
kernel. So now you don't have to reboot your system to add the memory
back to the kernel or to have a different amount of memory removed.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
To remove 1GB from each node:
echo 1073741824  >  /sys/kernel/debug/powerpc/memtrace/enable

To add this memory back and remove 2GB:
echo 2147483648 >  /sys/kernel/debug/powerpc/memtrace/enable 

To just re-add memory:
echo 0  >  /sys/kernel/debug/powerpc/memtrace/enable 


 arch/powerpc/platforms/powernv/memtrace.c | 93 ++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index b99283df8584..51fe0862dcab 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -206,8 +206,11 @@ static int memtrace_init_debugfs(void)
 
 		snprintf(ent->name, 16, "%08x", ent->nid);
 		dir = debugfs_create_dir(ent->name, memtrace_debugfs_dir);
-		if (!dir)
+		if (!dir) {
+			pr_err("Failed to create debugfs directory for node %d\n",
+				ent->nid);
 			return -1;
+		}
 
 		ent->dir = dir;
 		debugfs_create_file("trace", 0400, dir, ent, &memtrace_fops);
@@ -218,18 +221,94 @@ static int memtrace_init_debugfs(void)
 	return ret;
 }
 
+static int online_mem_block(struct memory_block *mem, void *arg)
+{
+	return device_online(&mem->dev);
+}
+
+/*
+ * Iterate through the chunks of memory we have removed from the kernel
+ * and attempt to add them back to the kernel.
+ */
+static int memtrace_online(void)
+{
+	int i, ret = 0;
+	struct memtrace_entry *ent;
+
+	for (i = memtrace_array_nr - 1; i >= 0; i--) {
+		ent = &memtrace_array[i];
+
+		/* We have onlined this chunk previously */
+		if (ent->nid == -1)
+			continue;
+
+		/* Remove from io mappings */
+		if (ent->mem) {
+			iounmap(ent->mem);
+			ent->mem = 0;
+		}
+
+		if (add_memory(ent->nid, ent->start, ent->size)) {
+			pr_err("Failed to add trace memory to node %d\n",
+					 ent->nid);
+			ret += 1;
+			continue;
+		}
+
+		/*
+		 * If kernel isn't compiled with the auto online option
+		 * we need to online the memory ourselves.
+		 */
+		if (!memhp_auto_online) {
+			walk_memory_range(PFN_DOWN(ent->start),
+				PFN_UP(ent->start + ent->size - 1),
+				NULL, online_mem_block);
+		}
+
+		/*
+		 * Memory was added successfully so clean up references to it
+		 * so on reentry we can tell that this chunk was added.
+		 */
+		debugfs_remove_recursive(ent->dir);
+		pr_info("Added trace memory back to node %d\n", ent->nid);
+		ent->size = ent->start = ent->nid = -1;
+	}
+	if (ret)
+		return ret;
+
+	/* If all chunks of memory were added successfully, reset globals */
+	kfree(memtrace_array);
+	memtrace_array = NULL;
+	memtrace_size = 0;
+	memtrace_array_nr = 0;
+	return 0;
+
+}
+
 static int memtrace_enable_set(void *data, u64 val)
 {
-	if (memtrace_size)
+	uint64_t bytes;
+
+	/*
+	 * Don't attempt to do anything if size isn't aligned to a memory
+	 * block or equal to zero.
+	 */
+	bytes = memory_block_size_bytes();
+	if (val & (bytes - 1)) {
+		pr_err("Value must be aligned with 0x%llx\n", bytes);
 		return -EINVAL;
+	}
 
-	if (!val)
-		return -EINVAL;
+	/* Re-add/online previously removed/offlined memory */
+	if (memtrace_size) {
+		if (memtrace_online())
+			return -EAGAIN;
+	}
 
-	/* Make sure size is aligned to a memory block */
-	if (val & (memory_block_size_bytes() - 1))
-		return -EINVAL;
+	if (!val)
+		return 0;
 
+	/* Offline and remove memory */
 	if (memtrace_init_regions_runtime(val))
 		return -EINVAL;
 
-- 
2.14.4
