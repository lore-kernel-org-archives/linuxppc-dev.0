Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03ED71A09D5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 19:18:45 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A98291400EA
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 19:18:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 8 Dec 2014 18:18:44 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH 4/7] CXL: Early return from cxl_handle_fault for a shut down
 context
Date: Mon,  8 Dec 2014 19:17:58 +1100
Message-Id: <1418026681-14787-4-git-send-email-imunsie@au.ibm.com>
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

If a context is being detached and we get a translation fault for it
there is little point getting it's mm and handling the fault, so just
respond with an address error and return earlier.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index c99e896..3e8c06a 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -176,6 +176,12 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		return;
 	}
 
+	/* Early return if the context is being / has been detached */
+	if (ctx->status == CLOSED) {
+		cxl_ack_ae(ctx);
+		return;
+	}
+
 	pr_devel("CXL BOTTOM HALF handling fault for afu pe: %i. "
 		"DSISR: %#llx DAR: %#llx\n", ctx->pe, dsisr, dar);
 
-- 
2.1.3
