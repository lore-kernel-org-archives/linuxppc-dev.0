Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTq9P6rzszDq71
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 21:45:45 +1100 (AEDT)
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 22 Mar 2016 10:45:39 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2F19917D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 10:46:09 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2MAjYPm8520134
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 10:45:34 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2MAjYxG011097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 04:45:34 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, imunsie@au1.ibm.com, mikey@neuling.org,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH] Added a 5ms wait after a msi-irq is masked
Date: Tue, 22 Mar 2016 11:45:54 +0100
Message-Id: <1458643554-22766-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Adds a 5ms wait to phb3_msi_set_xive after the interrupt is masked so
that the kernel delays cleanup until an irq if its in-flight is
handled. The value 5ms is the worst case time needed by an irq to be
presented to the host after its generated.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
This patch requires the following patches:
https://patchwork.ozlabs.org/patch/581764/
https://patchwork.ozlabs.org/patch/581765/

 hw/phb3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/phb3.c b/hw/phb3.c
index fbdcb9e..e5d49b2 100644
--- a/hw/phb3.c
+++ b/hw/phb3.c
@@ -1751,6 +1751,8 @@ static int64_t phb3_msi_set_xive(void *data,
 			PHB_IVC_UPDATE_ENABLE_Q |
 			PHB_IVC_UPDATE_ENABLE_GEN;
 		out_be64(p->regs + PHB_IVC_UPDATE, ivc);
+		/* wait for 5ms before signalling the interrupt is masked */
+		time_wait_ms(5);
 	}
 
 	return OPAL_SUCCESS;
-- 
2.7.1
