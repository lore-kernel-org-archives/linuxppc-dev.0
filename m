Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 876B11A0C79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 19:11:53 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B9BE140218
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2015 19:11:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 Feb 2015 18:11:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 639062BB0047
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2015 19:11:50 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t148BgJR39714882
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2015 19:11:50 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t148BGFf015307
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2015 19:11:17 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH] cxl: Add missing return statement after handling AFU errror
Date: Wed,  4 Feb 2015 19:10:38 +1100
Message-Id: <1423037438-27022-1-git-send-email-imunsie@au.ibm.com>
Cc: mikey <mikey@neuling.org>, Vaibhav Jain <vajain21@in.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

We were missing a return statement in the PSL interrupt handler in the
case of an AFU error, which would trigger an "Unhandled CXL PSL IRQ"
warning. We do actually handle these type of errors (by notifying
userspace), so add the missing return IRQ_HANDLED so we don't throw
unecessary warnings.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index ef52af7..2a2e58a 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -170,6 +170,7 @@ static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
 		}
 
 		cxl_ack_irq(ctx, CXL_PSL_TFC_An_A, 0);
+		return IRQ_HANDLED;
 	}
 	if (dsisr & CXL_PSL_DSISR_An_OC)
 		pr_devel("CXL interrupt: OS Context Warning\n");
-- 
2.1.4
