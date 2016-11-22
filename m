Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNLsS5c1fzDvnZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:13:48 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMADZKj061596
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 05:13:46 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vkfvbym3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 05:13:45 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 22 Nov 2016 20:13:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7671A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:13:39 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAMADds755312446
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:13:39 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAMADdKC013774
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:13:39 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
Subject: [PATCH] cxl: fix coccinelle warnings
Date: Tue, 22 Nov 2016 21:13:27 +1100
Message-Id: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the following coccinelle warnings:

    drivers/misc/cxl/debugfs.c:46:0-23: WARNING: fops_io_x64 should be
        defined with DEFINE_DEBUGFS_ATTRIBUTE
    drivers/misc/cxl/guest.c:890:5-26: WARNING: Comparison to bool
    drivers/misc/cxl/irq.c:107:3-23: WARNING: Assignment of bool to 0/1
    drivers/misc/cxl/native.c:57:2-3: Unneeded semicolon
    drivers/misc/cxl/native.c:170:2-3: Unneeded semicolon

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/debugfs.c | 6 ++++--
 drivers/misc/cxl/guest.c   | 2 +-
 drivers/misc/cxl/irq.c     | 2 +-
 drivers/misc/cxl/native.c  | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index ec7b8a0..9c06ac8 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -43,12 +43,14 @@ static int debugfs_io_u64_set(void *data, u64 val)
 	out_be64((u64 __iomem *)data, val);
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_io_x64, debugfs_io_u64_get, debugfs_io_u64_set, "0x%016llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_x64, debugfs_io_u64_get, debugfs_io_u64_set,
+			 "0x%016llx\n");
 
 static struct dentry *debugfs_create_io_x64(const char *name, umode_t mode,
 					    struct dentry *parent, u64 __iomem *value)
 {
-	return debugfs_create_file(name, mode, parent, (void __force *)value, &fops_io_x64);
+	return debugfs_create_file_unsafe(name, mode, parent,
+					  (void __force *)value, &fops_io_x64);
 }
 
 void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir)
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 3e102cd..e04bc4d 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -887,7 +887,7 @@ static void afu_handle_errstate(struct work_struct *work)
 	    afu_guest->previous_state == H_STATE_PERM_UNAVAILABLE)
 		return;
 
-	if (afu_guest->handle_err == true)
+	if (afu_guest->handle_err)
 		schedule_delayed_work(&afu_guest->work_err,
 				      msecs_to_jiffies(3000));
 }
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index dec60f5..1a402bb 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -104,7 +104,7 @@ irqreturn_t cxl_irq(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_i
 		} else {
 			spin_lock(&ctx->lock);
 			ctx->afu_err = irq_info->afu_err;
-			ctx->pending_afu_err = 1;
+			ctx->pending_afu_err = true;
 			spin_unlock(&ctx->lock);
 
 			wake_up_all(&ctx->wq);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index a217a74..fe56d1b 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -54,7 +54,7 @@ static int afu_control(struct cxl_afu *afu, u64 command, u64 clear,
 				     AFU_Cntl | command);
 		cpu_relax();
 		AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
-	};
+	}
 
 	if (AFU_Cntl & CXL_AFU_Cntl_An_RA) {
 		/*
@@ -167,7 +167,7 @@ int cxl_psl_purge(struct cxl_afu *afu)
 			cpu_relax();
 		}
 		PSL_CNTL = cxl_p1n_read(afu, CXL_PSL_SCNTL_An);
-	};
+	}
 	end = local_clock();
 	pr_devel("PSL purged in %lld ns\n", end - start);
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
