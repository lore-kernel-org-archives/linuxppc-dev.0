Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYLT54DPtzDqfv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 17:27:53 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Suchanek <msuchanek@suse.de>, Daniel Axtens <dja@axtens.net>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/fadump: return error when fadump registration fails
Date: Thu, 25 May 2017 09:27:44 +0200
Message-Id: <20170525072744.18374-1-msuchanek@suse.de>
In-Reply-To: <201705251543.gd6iZ3OM%fengguang.wu@intel.com>
References: <201705251543.gd6iZ3OM%fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 - log an error message when registration fails and no error code listed
 in the switch is returned
 - translate the hv error code to posix error code and return it from
 fw_register
 - return the posix error code from fw_register to the process writing
 to sysfs
 - return EEXIST on re-registration
 - return success on deregistration when fadump is not registered
 - return ENODEV when no memory is reserved for fadump

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 2fa582092d42..5a649d76a785 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -398,9 +398,9 @@ static int __init early_fadump_param(char *p)
 }
 early_param("fadump", early_fadump_param);
 
-static void register_fw_dump(struct fadump_mem_struct *fdm)
+static int register_fw_dump(struct fadump_mem_struct *fdm)
 {
-	int rc;
+	int rc, err;
 	unsigned int wait_time;
 
 	pr_debug("Registering for firmware-assisted kernel dump...\n");
@@ -417,7 +417,12 @@ static void register_fw_dump(struct fadump_mem_struct *fdm)
 
 	} while (wait_time);
 
+	err = -EIO;
 	switch (rc) {
+	default:
+		printk(KERN_ERR "Failed to register firmware-assisted kernel"
+			" dump. Unknown Error(%d).\n", rc);
+		break;
 	case -1:
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Hardware Error(%d).\n", rc);
@@ -425,18 +430,22 @@ static void register_fw_dump(struct fadump_mem_struct *fdm)
 	case -3:
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Parameter Error(%d).\n", rc);
+		err = -EINVAL;
 		break;
 	case -9:
 		printk(KERN_ERR "firmware-assisted kernel dump is already "
 			" registered.");
 		fw_dump.dump_registered = 1;
+		err = -EEXIST;
 		break;
 	case 0:
 		printk(KERN_INFO "firmware-assisted kernel dump registration"
 			" is successful\n");
 		fw_dump.dump_registered = 1;
+		err = 0;
 		break;
 	}
+	return err;
 }
 
 void crash_fadump(struct pt_regs *regs, const char *str)
@@ -977,7 +986,7 @@ static unsigned long init_fadump_header(unsigned long addr)
 	return addr;
 }
 
-static void register_fadump(void)
+static int register_fadump(void)
 {
 	unsigned long addr;
 	void *vaddr;
@@ -987,7 +996,7 @@ static void register_fadump(void)
 	 * assisted dump.
 	 */
 	if (!fw_dump.reserve_dump_area_size)
-		return;
+		return -ENODEV
 
 	fadump_setup_crash_memory_ranges();
 
@@ -1000,7 +1009,7 @@ static void register_fadump(void)
 	fadump_create_elfcore_headers(vaddr);
 
 	/* register the future kernel dump with firmware. */
-	register_fw_dump(&fdm);
+	return register_fw_dump(&fdm);
 }
 
 static int fadump_unregister_dump(struct fadump_mem_struct *fdm)
@@ -1182,7 +1191,6 @@ static ssize_t fadump_register_store(struct kobject *kobj,
 	switch (buf[0]) {
 	case '0':
 		if (fw_dump.dump_registered == 0) {
-			ret = -EINVAL;
 			goto unlock_out;
 		}
 		/* Un-register Firmware-assisted dump */
@@ -1190,11 +1198,11 @@ static ssize_t fadump_register_store(struct kobject *kobj,
 		break;
 	case '1':
 		if (fw_dump.dump_registered == 1) {
-			ret = -EINVAL;
+			ret = -EEXIST;
 			goto unlock_out;
 		}
 		/* Register Firmware-assisted dump */
-		register_fadump();
+		ret = register_fadump();
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.10.2
