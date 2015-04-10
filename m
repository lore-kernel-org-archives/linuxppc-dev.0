Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 208B01A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 17:33:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Fri, 10 Apr 2015 17:33:40 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 590B72BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 17:33:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A7XUCs32702696
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 17:33:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A7X4IJ006787
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 17:33:05 +1000
From: Alistair Popple <alistair@popple.id.au>
To: openipmi-developer@lists.sourceforge.net
Subject: [PATCH] ipmi/powernv: Fix minor locking bug
Date: Fri, 10 Apr 2015 17:32:20 +1000
Message-Id: <1428651140-13665-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, minyard@acm.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If ipmi_powernv_recv(...) is called without a current message it
prints a warning and returns. However it fails to release the message
lock causing the system to dead lock during any subsequent IPMI
operations.

This error path should never normally be taken unless there are bugs
elsewhere in the system.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 drivers/char/ipmi/ipmi_powernv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index b3a2224..9b409c0 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -126,6 +126,7 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
 	spin_lock_irqsave(&smi->msg_lock, flags);
 
 	if (!smi->cur_msg) {
+		spin_unlock_irqrestore(&smi->msg_lock, flags);
 		pr_warn("no current message?\n");
 		return 0;
 	}
-- 
1.8.3.2
