Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtcgt4PYczDr21
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 20:07:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MA408F052724
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:07:04 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8beth2p8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:07:04 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 11:07:01 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com
Subject: [RFC v2 3/3] cxl: Add memory barrier to guarantee TLBI scope
Date: Thu, 22 Jun 2017 12:06:49 +0200
In-Reply-To: <20170622100649.3846-1-fbarrat@linux.vnet.ibm.com>
References: <20170622100649.3846-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170622100649.3846-4-fbarrat@linux.vnet.ibm.com>
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
 include/misc/cxl-base.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/misc/cxl-base.h b/include/misc/cxl-base.h
index b2ebc91fe09a..dcb6d38ab3ad 100644
--- a/include/misc/cxl-base.h
+++ b/include/misc/cxl-base.h
@@ -25,12 +25,28 @@ extern atomic_t cxl_use_count;
 
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
+	smp_mb();
+	return (atomic_read(&cxl_use_count) != 0);
 }
 
 static inline void cxl_ctx_get(void)
 {
        atomic_inc(&cxl_use_count);
+       /*
+	* Barrier guarantees that the device will receive all TLBIs
+	* from that point on
+	*/
+       smp_wmb();
 }
 
 static inline void cxl_ctx_put(void)
-- 
2.11.0
