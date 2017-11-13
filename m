Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZzzR3GBTzDqjD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 16:41:55 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAD5dLkk044687
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 00:41:52 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e71fwsp94-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 00:41:52 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 05:41:51 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Add debugfs interface for imc-mode and
 imc-command
Date: Mon, 13 Nov 2017 11:11:45 +0530
Message-Id: <1510551705-20702-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In memory Collection (IMC) counter pmu driver controls the ucode's execution
state. At the system boot, IMC perf driver pause the ucode. Ucode state is
changed to "running" only when any of the nest units are monitored or profiled
using perf tool.                                      
                                                                                
Nest units support only limited set of hardware counters and ucode is always
programmed in the "production mode" ("accumulation") mode. This mode is
configured to provide key performance metric data for most of the nest units.                                                         
                                                                                
But ucode also supports other modes which would be used for "debug" to drill    
down specific nest units. That is, ucode when switched to "powerbus" debug      
mode (for example), will dynamically reconfigure the nest counters to target    
only "powerbus" related events in the hardware counters. This allows the IMC
nest unit to focus on powerbus related transactions in the system in more
detail. At this point, production mode events may or may not be counted.                                                          
                                                                                
IMC nest counters has both in-band (ucode access) and out of band access to it. 
Since not all nest counter configurations are supported by ucode, out of band   
tools are used to characterize other nest counter configurations.               
                                                                                
Patch provides an interface via "debugfs" to enable the switching of ucode
modes in the system. To switch ucode mode, one has to first pause the microcode 
(imc_cmd), and then write the target mode value to the "imc_mode" file.                                                   
                                                                                
Proposed Approach                                                               
===================                                                             
                                                                                
In the proposed approach, the function (export_imc_mode_and_cmd) which creates   
the debugfs interface for imc mode and command is implemented in opal-imc.c.    
Thus we can use imc_get_mem_addr() to get the homer base address for each chip. 
                                                                                
The interface to expose imc mode and command is required only if we have nest
pmu units registered. Employing the existing data structures to track whether
we have any nest units registered will require to extend data from perf side
to opal-imc.c. Instead an integer is introduced to hold that information by
counting successful nest unit registration. Debugfs interface is removed
based on the integer count.                                           

Example for the interface:                                                      
                                                                                
root@XXXX:/sys/kernel/debug/imc# ls                                             
imc_cmd_0  imc_cmd_8  imc_mode_0  imc_mode_8                                    
                                                                                
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>    
---
 arch/powerpc/include/asm/imc-pmu.h        |  7 +++
 arch/powerpc/platforms/powernv/opal-imc.c | 74 ++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 7f74c28..317002d 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -40,6 +40,13 @@
 #define THREAD_IMC_ENABLE               0x8000000000000000ULL
 
 /*
+ * For debugfs interface for imc-mode and imc-command
+ */
+#define IMC_CNTL_BLK_OFFSET		0x3FC00
+#define IMC_CNTL_BLK_CMD_OFFSET		8
+#define IMC_CNTL_BLK_MODE_OFFSET	32
+
+/*
  * Structure to hold memory address information for imc units.
  */
 struct imc_mem_info {
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 21f6531..a88ddab 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -21,6 +21,70 @@
 #include <asm/io.h>
 #include <asm/imc-pmu.h>
 #include <asm/cputhreads.h>
+#include <linux/debugfs.h>
+
+static struct dentry *parent;
+
+/* Helpers to export imc command and status via debugfs */
+static int debugfs_imc_mem_get(void *data, u64 *val)
+{
+	*val = cpu_to_be64(*(u64 *)data);
+	return 0;
+}
+
+static int debugfs_imc_mem_set(void *data, u64 val)
+{
+	*(u64 *)data = cpu_to_be64(val);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_imc_x64, debugfs_imc_mem_get, debugfs_imc_mem_set,
+								"0x%016llx\n");
+
+static struct dentry *debugfs_create_imc_x64(const char *name, umode_t mode,
+					    struct dentry *parent, u64  *value)
+{
+	return debugfs_create_file_unsafe(name, mode, parent, value, &fops_imc_x64);
+}
+
+/*
+ * export_imc_mode_and_cmd: Create a debugfs interface
+ *                     for imc_cmd and imc_mode
+ *                     for each node in the system.
+ *  imc_mode and imc_cmd can be changed by echo into
+ *  this interface.
+ */
+static void export_imc_mode_and_cmd(struct imc_pmu *pmu_ptr)
+{
+	static u64 loc, *imc_mode_addr, *imc_cmd_addr;
+	int i = 0, nid;
+	char mode[16], cmd[16];
+
+	parent = debugfs_create_dir("imc", NULL);
+	/*
+	 * Return here, either because 'imc' directory already exists,
+	 * Or failed to create a new one.
+	 */
+	if (!parent)
+		return;
+
+	for_each_node(nid) {
+		loc = (u64)(pmu_ptr->mem_info[i].vbase) + IMC_CNTL_BLK_OFFSET;
+		imc_mode_addr = (u64 *)(loc + IMC_CNTL_BLK_MODE_OFFSET);
+		sprintf(mode, "imc_mode_%d", nid);
+		if (!debugfs_create_imc_x64(mode, 0600, parent, imc_mode_addr))
+			goto err;
+
+		imc_cmd_addr = (u64 *)(loc + IMC_CNTL_BLK_CMD_OFFSET);
+		sprintf(cmd, "imc_cmd_%d", nid);
+		if (!debugfs_create_imc_x64(cmd, 0600, parent, imc_cmd_addr))
+			goto err;
+		i++;
+	}
+	return;
+
+err:
+	debugfs_remove_recursive(parent);
+}
 
 /*
  * imc_get_mem_addr_nest: Function to get nest counter memory region
@@ -65,6 +129,7 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 	}
 
 	pmu_ptr->imc_counter_mmaped = true;
+	export_imc_mode_and_cmd(pmu_ptr);
 	kfree(base_addr_arr);
 	kfree(chipid_arr);
 	return 0;
@@ -156,7 +221,7 @@ static void disable_core_pmu_counters(void)
 static int opal_imc_counters_probe(struct platform_device *pdev)
 {
 	struct device_node *imc_dev = pdev->dev.of_node;
-	int pmu_count = 0, domain;
+	int pmu_count = 0, domain, nest_pmus = 0;
 	u32 type;
 
 	/*
@@ -191,9 +256,14 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 			break;
 		}
 
-		if (!imc_pmu_create(imc_dev, pmu_count, domain))
+		if (!imc_pmu_create(imc_dev, pmu_count, domain)) {
+			if (domain == IMC_DOMAIN_NEST)
+				nest_pmus++;
 			pmu_count++;
+		}
 	}
+	if (nest_pmus == 0)
+		debugfs_remove_recursive(parent);
 
 	return 0;
 }
-- 
2.7.4
