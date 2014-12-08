Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89F0C1A06AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 19:18:42 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4C00E1400DD
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 19:18:42 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 8 Dec 2014 18:18:41 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH 2/7] CXL: Add timeout to process element commands
Date: Mon,  8 Dec 2014 19:17:56 +1100
Message-Id: <1418026681-14787-2-git-send-email-imunsie@au.ibm.com>
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

In the event that something goes wrong in the hardware and it is unable
to complete a process element comment we would end up polling forever,
effectively making the associated process unkillable.

This patch adds a timeout to the process element command code path, so
that we will give up if the hardware does not respond in a reasonable
time.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/native.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 1001cf4..f2b37b4 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -277,6 +277,7 @@ static int do_process_element_cmd(struct cxl_context *ctx,
 				  u64 cmd, u64 pe_state)
 {
 	u64 state;
+	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
 
 	WARN_ON(!ctx->afu->enabled);
 
@@ -286,6 +287,10 @@ static int do_process_element_cmd(struct cxl_context *ctx,
 	smp_mb();
 	cxl_p1n_write(ctx->afu, CXL_PSL_LLCMD_An, cmd | ctx->pe);
 	while (1) {
+		if (time_after_eq(jiffies, timeout)) {
+			dev_warn(&ctx->afu->dev, "WARNING: Process Element Command timed out!\n");
+			return -EBUSY;
+		}
 		state = be64_to_cpup(ctx->afu->sw_command_status);
 		if (state == ~0ULL) {
 			pr_err("cxl: Error adding process element to AFU\n");
-- 
2.1.3
