Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A30F1A1DC8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:17:06 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 16:47:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1D2041258064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:49:54 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GBGtcN45023406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:46:55 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6G9xtlA019624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 15:29:55 +0530
Subject: [PATCH] ipmi/powernv: Fix potential invalid pointer dereference
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
To: alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org, jk@ozlabs.org,
 minyard@acm.org
Date: Thu, 16 Jul 2015 16:46:54 +0530
Message-ID: <20150716111628.28037.80799.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the OPAL call to receive the ipmi message fails, then we free up the
smi message and return. But, the driver still holds the reference to
old smi message in the 'cur_msg' which can potentially be accessed later
and freed again leading to kernel oops. To fix it up,

The kernel driver should reset the 'cur_msg' and send reply to the user
in addition to freeing the message.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
---
 drivers/char/ipmi/ipmi_powernv.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index 9b409c0..637486d 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -143,9 +143,16 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
 	pr_devel("%s:   -> %d (size %lld)\n", __func__,
 			rc, rc == 0 ? size : 0);
 	if (rc) {
-		spin_unlock_irqrestore(&smi->msg_lock, flags);
-		ipmi_free_smi_msg(msg);
-		return 0;
+		/* If came via the poll, and response was not yet ready */
+		if (rc == OPAL_EMPTY) {
+			spin_unlock_irqrestore(&smi->msg_lock, flags);
+			return 0;
+		} else {
+			smi->cur_msg = NULL;
+			spin_unlock_irqrestore(&smi->msg_lock, flags);
+			send_error_reply(smi, msg, IPMI_ERR_UNSPECIFIED);
+			return 0;
+		}
 	}
 
 	if (size < sizeof(*opal_msg)) {
