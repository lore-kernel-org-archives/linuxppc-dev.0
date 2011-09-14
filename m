Return-Path: <anton@samba.org>
Date: Thu, 15 Sep 2011 06:26:15 +1000
From: Anton Blanchard <anton@samba.org>
To: gregkh@suse.de, nfont@austin.ibm.com
Subject: [PATCH] memory hotplug: Refuse to add unaligned memory regions
Message-ID: <20110915062615.782bc4df@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The sysfs memory probe interface allows unaligned regions
to be added:

# echo 0xffffff > /sys/devices/system/memory/probe

# cat /proc/iomem 
00ffffff-01fffffe : System RAM
01ffffff-02fffffe : System RAM
02ffffff-03fffffe : System RAM
03ffffff-04fffffe : System RAM
04ffffff-05fffffe : System RAM

Return -EINVAL instead of creating these bad regions.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/drivers/base/memory.c
===================================================================
--- linux-build.orig/drivers/base/memory.c	2011-08-11 08:25:55.005941391 +1000
+++ linux-build/drivers/base/memory.c	2011-08-11 08:28:27.938580440 +1000
@@ -380,9 +380,13 @@ memory_probe_store(struct class *class,
 	u64 phys_addr;
 	int nid;
 	int i, ret;
+	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
 
 	phys_addr = simple_strtoull(buf, NULL, 0);
 
+	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
+		return -EINVAL;
+
 	for (i = 0; i < sections_per_block; i++) {
 		nid = memory_add_physaddr_to_nid(phys_addr);
 		ret = add_memory(nid, phys_addr,
