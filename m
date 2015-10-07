Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484FE1A03C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 16:08:49 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0FE72140D95
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 16:08:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 7 Oct 2015 15:08:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 944AF2BB0052
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 16:08:43 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9758ZvV60227756
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 16:08:43 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9758A2B021029
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 16:08:10 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ian Munsie <imunsie@au1.ibm.com>, stable <stable@vger.kernel.org>
Subject: [PATCH] cxl: Fix number of allocated pages in SPA
Date: Wed,  7 Oct 2015 16:07:40 +1100
Message-Id: <1444194460-13584-1-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1444190982.6794.4.camel@ellerman.id.au>
References: <1444190982.6794.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

The scheduled process area is currently allocated before assigning the
correct maximum processes to the AFU, which will mean we only ever
allocate a fixed number of pages for the scheduled process area. This
will limit us to 958 processes with 2 x 64K pages. If we try to use more
processes than that we'd probably overrun the buffer and corrupt memory
or crash.

AFUs that require three or more interrupts per process will not be
affected as they are already limited to less processes than that, but we
could hit it on an AFU that requires 0, 1 or 2 interrupts per process,
or when using 4K pages.

This patch moves the initialisation of the num_procs to before the SPA
allocation so that enough pages will be allocated for the number of
processes that the AFU supports.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Cc: stable <stable@vger.kernel.org> # 3.18+
---

Changes since v2:
 - Expanded commit message
Changes since v1:
 - Expanded commit message

 drivers/misc/cxl/native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index b37f2e8..d2e75c8 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -457,6 +457,7 @@ static int activate_afu_directed(struct cxl_afu *afu)
 
 	dev_info(&afu->dev, "Activating AFU directed mode\n");
 
+	afu->num_procs = afu->max_procs_virtualised;
 	if (afu->spa == NULL) {
 		if (cxl_alloc_spa(afu))
 			return -ENOMEM;
@@ -468,7 +469,6 @@ static int activate_afu_directed(struct cxl_afu *afu)
 	cxl_p1n_write(afu, CXL_PSL_ID_An, CXL_PSL_ID_An_F | CXL_PSL_ID_An_L);
 
 	afu->current_mode = CXL_MODE_DIRECTED;
-	afu->num_procs = afu->max_procs_virtualised;
 
 	if ((rc = cxl_chardev_m_afu_add(afu)))
 		return rc;
-- 
2.1.4
