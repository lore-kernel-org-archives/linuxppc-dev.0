Message-ID: <20040105044949.24645.qmail@kunk.qbjnet.com>
Subject: patch: missing ifdef for CONFIG_ADB_PMU in pmac_nvram.c for 2.4.23-ben1
To: linuxppc-dev@lists.linuxppc.org
Date: Sun, 4 Jan 2004 22:49:49 -0600 (CST)
From: Bob Brose <bob@kunk.qbjnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To get 2.4.23-ben1 to compile on a pmac 7200 without CONFIG_ADB_PMU
being set, I needed to apply the simple patch below. The machine doesn't
have a lot of memory so I'm trying to eliminate all unused code.

Bob


--- linux-2.4.23-ben1/arch/ppc/platforms/pmac_nvram.c.orig	2004-01-04 20:47:16.000000000 -0600
+++ linux-2.4.23-ben1/arch/ppc/platforms/pmac_nvram.c	2004-01-04 21:20:52.000000000 -0600
@@ -526,11 +526,15 @@
 		nvram_data = ioremap(dp->addrs[1].address, dp->addrs[1].size);
 		ppc_md.nvram_read_val	= indirect_nvram_read_byte;
 		ppc_md.nvram_write_val	= indirect_nvram_write_byte;
-	} else if (nvram_naddrs == 0 && sys_ctrler == SYS_CTRLER_PMU) {
+	}
+#ifdef CONFIG_ADB_PMU
+  	else if (nvram_naddrs == 0 && sys_ctrler == SYS_CTRLER_PMU) {
 		nvram_naddrs = -1;
 		ppc_md.nvram_read_val	= pmu_nvram_read_byte;
 		ppc_md.nvram_write_val	= pmu_nvram_write_byte;
-	} else {
+	}
+#endif
+   	else {
 		printk(KERN_ERR "Don't know how to access NVRAM with %d addresses\n",
 		       nvram_naddrs);
 	}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
