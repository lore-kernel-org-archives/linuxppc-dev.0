Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 833631A1975
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 01:59:02 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 11:59:00 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 96223C90045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 11:47:10 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t91FwwbF62980196
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 15:58:58 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t91FwuFi024461
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 11:58:57 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v5 25/34] cxlflash: Fix to prevent EEH recovery failure
Date: Thu,  1 Oct 2015 10:58:08 -0500
Message-Id: <1443715088-21200-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The process_sense() routine can perform a read capacity which
can take some time to complete. If an EEH occurs while waiting
on the read capacity, the EEH handler will wait to obtain the
context's mutex in order to put the context in an error state.
The EEH handler will sit and wait until the context is free,
but this wait can potentially last forever (deadlock) if the
scsi_execute() that performs the read capacity experiences a
timeout and calls into the reset callback. When that occurs,
the reset callback sees that the device is already being reset
and waits for the reset to complete. This leaves two threads
waiting on the other.

To address this issue, make the context unavailable to new,
non-system owned threads and release the context while calling
into process_sense(). After returning from process_sense() the
context mutex is reacquired and the context is made available
again. The context can be safely moved to the error state if
needed during the unavailable window as no other threads will
hold its reference.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
---
 drivers/scsi/cxlflash/superpipe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index a6316f5..7283e83 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1787,12 +1787,21 @@ static int cxlflash_disk_verify(struct scsi_device *sdev,
 	 * inquiry (i.e. the Unit attention is due to the WWN changing).
 	 */
 	if (verify->hint & DK_CXLFLASH_VERIFY_HINT_SENSE) {
+		/* Can't hold mutex across process_sense/read_cap16,
+		 * since we could have an intervening EEH event.
+		 */
+		ctxi->unavail = true;
+		mutex_unlock(&ctxi->mutex);
 		rc = process_sense(sdev, verify);
 		if (unlikely(rc)) {
 			dev_err(dev, "%s: Failed to validate sense data (%d)\n",
 				__func__, rc);
+			mutex_lock(&ctxi->mutex);
+			ctxi->unavail = false;
 			goto out;
 		}
+		mutex_lock(&ctxi->mutex);
+		ctxi->unavail = false;
 	}
 
 	switch (gli->mode) {
-- 
2.1.0
