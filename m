Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3E691A18FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 16:28:30 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8ACE0140B0E
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 16:28:30 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 16:28:30 +1000
Subject: [PATCH] ipmi/powernv: Fix a minor bug
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, jk@ozlabs.org
Cc: neelegup@linux.vnet.ibm.com
Date: Wed, 08 Jul 2015 11:57:28 +0530
Message-ID: <20150708062702.11242.47257.stgit@localhost.localdomain>
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

If the OPAL call to receive the ipmi message fails, then we free up the smi
message before returning. But, the driver still holds the reference to old
smi message in the 'cur_msg' which is dangerous if the driver derefernces it
later and it will further block the subsequent ipmi operations. So, to fix
it up, we need to nullify 'cur_msg' in the error case.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
---
 drivers/char/ipmi/ipmi_powernv.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index 9b409c0..08dd38f 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -143,6 +143,7 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
 	pr_devel("%s:   -> %d (size %lld)\n", __func__,
 			rc, rc == 0 ? size : 0);
 	if (rc) {
+		smi->cur_msg = NULL;
 		spin_unlock_irqrestore(&smi->msg_lock, flags);
 		ipmi_free_smi_msg(msg);
 		return 0;
