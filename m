Return-Path: <anton@ozlabs.org>
Date: Sat, 11 Feb 2006 22:55:09 +1100
From: Anton Blanchard <anton@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: [PATCH] ppc64: poison invalid cpus
Message-ID: <20060211115509.GA7922@krispykreme>
References: <20060210140008.GA11864@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060210140008.GA11864@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ensure that per cpu access to !possible cpus causes a fault instead of silent
corruption.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Olaf Hering <olh@suse.de>
---

Thanks Olaf, I had forgotten to send it out.

Index: linux-2.6.16-rc1-git3/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.16-rc1-git3.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6.16-rc1-git3/arch/powerpc/kernel/setup_64.c
@@ -670,6 +670,14 @@ void __init setup_per_cpu_areas(void)
 		size = PERCPU_ENOUGH_ROOM;
 #endif
 
+	/*
+	 * Poison invalid cpus, with lots of high bits set this should
+	 * always fault
+	 */
+	for (i = 0; i < NR_CPUS; i++) {
+		paca[i].data_offset = 0xeeeeeeeeeeeeeeeeULL;
+	}
+
 	for_each_cpu(i) {
 		ptr = alloc_bootmem_node(NODE_DATA(cpu_to_node(i)), size);
 		if (!ptr)
