Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28A921A0D60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 07:17:55 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 14:17:54 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 485B71FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 14:06:04 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9LKGm3e10289582
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:16:48 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9LKHoMH014428
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 14:17:52 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 37/37] cxlflash: Fix to avoid bypassing context cleanup
Date: Wed, 21 Oct 2015 15:16:32 -0500
Message-Id: <1445458592-63806-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Contexts may be skipped over for cleanup in situations where contention
for the adapter's table-list mutex is experienced in the presence of a
signal during the execution of the release handler.

This can lead to two known issues:

 - A hang condition on remove as that path tries to wait for users to
   cleanup - something that will never complete should this scenario play
   out as the user has already cleaned up from their perspective.

 - An Oops in the unmap_mapping_range() call that is made as part of
   the user waiting mechanism that is invoked on remove when contexts
   are found to still exist.

The root cause of this issue can be found in get_context() and how the
table-list mutex is acquired. As this code path is shared by several
different access points within the driver, a decision was made during
the development cycle to acquire this mutex in this location using the
interruptible version of the mutex locking service. In almost all of
the use-cases and environmental scenarios this holds up, even when the
mutex is contended. However, for critical system threads (such as the
release handler), failing to acquire the mutex and bailing with the
intention of the user being able to try again later is unacceptable.

In such a scenario, the context _must_ be derived as it is on an
irreversible path to being freed. Without being able to derive the
context, the code mistakenly assumes that it has already been freed
and proceeds to free up the underlying CXL context resources. From
this point on, any usage of [the now stale] CXL context resources
will result in undefined behavior. This is root cause of the Oops
mentioned as the second known issue as the mapping passed to the
unmap_mapping_range() service is owned by the CXL context.

To fix this problem, acquisition of the table-list mutex within
get_context() is simply changed to use the uninterruptible version
of the mutex locking service. This is safe as the timing windows for
holding this mutex are short and also protected against blocking.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/superpipe.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 8af7cdc..34b21a0 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -162,10 +162,7 @@ struct ctx_info *get_context(struct cxlflash_cfg *cfg, u64 rctxid,
 
 	if (likely(ctxid < MAX_CONTEXT)) {
 		while (true) {
-			rc = mutex_lock_interruptible(&cfg->ctx_tbl_list_mutex);
-			if (rc)
-				goto out;
-
+			mutex_lock(&cfg->ctx_tbl_list_mutex);
 			ctxi = cfg->ctx_tbl[ctxid];
 			if (ctxi)
 				if ((file && (ctxi->file != file)) ||
-- 
2.1.0
