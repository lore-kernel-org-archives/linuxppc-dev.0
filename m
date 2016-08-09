Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s89jw0YyCzDrLD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:39:47 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79Ncvdf081800
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 19:39:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9s29nr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 19:39:46 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 17:39:45 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Subject: [PATCH 2/6] cxlflash: Cache owning adapter within context
Date: Tue,  9 Aug 2016 18:39:30 -0500
In-Reply-To: <1470785888-9112-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1470785888-9112-1-git-send-email-mrochs@linux.vnet.ibm.com>
Message-Id: <1470785970-9192-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The context removal routine requires access to the owning adapter
structure to reset the context within the AFU as part of the tear
down sequence. In order to support kref adoption, the owning adapter
must be accessible from the release handler. As the kref framework
only provides the kref reference as the sole parameter, another means
is needed to derive the owning adapter.

As a remedy, the owning adapter reference is saved off within the
context during initialization.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/superpipe.c | 1 +
 drivers/scsi/cxlflash/superpipe.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index ab5c893..640c3a2 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -804,6 +804,7 @@ static void init_context(struct ctx_info *ctxi, struct cxlflash_cfg *cfg,
 	ctxi->lfd = adap_fd;
 	ctxi->pid = current->tgid; /* tgid = pid */
 	ctxi->ctx = ctx;
+	ctxi->cfg = cfg;
 	ctxi->file = file;
 	ctxi->initialized = true;
 	mutex_init(&ctxi->mutex);
diff --git a/drivers/scsi/cxlflash/superpipe.h b/drivers/scsi/cxlflash/superpipe.h
index 5f9a091..61404f2 100644
--- a/drivers/scsi/cxlflash/superpipe.h
+++ b/drivers/scsi/cxlflash/superpipe.h
@@ -107,6 +107,7 @@ struct ctx_info {
 	bool err_recovery_active;
 	struct mutex mutex; /* Context protection */
 	struct cxl_context *ctx;
+	struct cxlflash_cfg *cfg;
 	struct list_head luns;	/* LUNs attached to this context */
 	const struct vm_operations_struct *cxl_mmap_vmops;
 	struct file *file;
-- 
2.1.0
