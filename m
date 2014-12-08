Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D716E1A09C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 19:19:39 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52C831400F1
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 19:19:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 8 Dec 2014 18:19:38 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH 3/7] CXL: Fix leaking interrupts if attach process fails
Date: Mon,  8 Dec 2014 19:17:57 +1100
Message-Id: <1418026681-14787-3-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 greg <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

In this particular error path we have already allocated the AFU
interrupts, but have not yet set the status to STARTED. The detach
context code will only attempt to release the interrupts if the context
is in state STARTED, so in this case the interrupts would remain
allocated.

This patch releases the AFU interrupts immediately if the attach call
fails to prevent them leaking.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 378b099..2e067a5 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -181,8 +181,10 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	ctx->pid = get_pid(get_task_pid(current, PIDTYPE_PID));
 
 	if ((rc = cxl_attach_process(ctx, false, work.work_element_descriptor,
-				     amr)))
+				     amr))) {
+		afu_release_irqs(ctx);
 		goto out;
+	}
 
 	ctx->status = STARTED;
 	rc = 0;
-- 
2.1.3
