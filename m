Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4YR4y3qzDrFK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:29:47 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72KSsOG012002
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 16:29:44 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3mxwaech-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 16:29:44 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 21:29:42 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, alistair@popple.id.au,
 vaibhav@linux.vnet.ibm.com
Subject: [PATCH v3 3/3] cxl: Add memory barrier to guarantee TLBI scope
Date: Wed,  2 Aug 2017 22:29:30 +0200
In-Reply-To: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
References: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170802202930.5616-4-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the hash memory model, all TLBIs become global when the cxl
driver is active, i.e. as soon as one context is open.
It is theoretically possible to send a TLBI with the wrong scope as
there's currently no memory barrier between when the driver is marked
as in use, and attaching a context to the device, therefore we are
exposed to re-ordering. It is highly unlikely as the use count for the
driver is incremented on open() and the attachment to the device
happens on a different system call (ioctl)

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 include/misc/cxl-base.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/misc/cxl-base.h b/include/misc/cxl-base.h
index b2ebc91fe09a..25afe6bbe0a9 100644
--- a/include/misc/cxl-base.h
+++ b/include/misc/cxl-base.h
@@ -25,17 +25,33 @@ extern atomic_t cxl_use_count;
 
 static inline bool cxl_ctx_in_use(void)
 {
-       return (atomic_read(&cxl_use_count) != 0);
+	/*
+	 * This is called when sending an TLBI, to know whether it
+	 * should be global or local.
+	 *
+	 * We need to make sure the PTE update is happening before
+	 * reading the context global flag. Otherwise, reading the
+	 * flag may be re-ordered and happen first, and we could end
+	 * up in a situation where the old PTE is seen by the device,
+	 * but the TLBI is not global.
+	 */
+	mb();
+	return (atomic_read(&cxl_use_count) != 0);
 }
 
 static inline void cxl_ctx_get(void)
 {
-       atomic_inc(&cxl_use_count);
+	atomic_inc(&cxl_use_count);
+	/*
+	 * Barrier guarantees that the device will receive all TLBIs
+	 * from that point on
+	 */
+	wmb();
 }
 
 static inline void cxl_ctx_put(void)
 {
-       atomic_dec(&cxl_use_count);
+	atomic_dec(&cxl_use_count);
 }
 
 struct cxl_afu *cxl_afu_get(struct cxl_afu *afu);
-- 
2.11.0
