Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DE41A0DE1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 19:00:26 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15A53140157
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 May 2015 19:00:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 24F292CE8040
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4490FTx14024886
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 19:00:23 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t448xoR9023589
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 18:59:50 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] powerpc/powernv: Add definition of OPAL_MSG_OCC
 message type
Date: Mon,  4 May 2015 14:24:08 +0530
Message-Id: <1430729652-14813-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add OPAL_MSG_OCC message definition to opal_message_type to receive
OCC events like reset, load and throttled. Host performance can be
affected when OCC is reset or OCC throttles the max Pstate.
We can register to opal_message_notifier to receive OPAL_MSG_OCC type
of message and report it to the userspace so as to keep the user
informed about the reason for a performance drop in workloads.

The reset and load OCC events are notified to kernel when FSP sends
OCC_RESET and OCC_LOAD commands.  Both reset and load messages are
sent to kernel on successful completion of reset and load operation
respectively.

The throttle OCC event indicates that the Pmax of the chip is reduced.
The chip_id and throttle reason for reducing Pmax is also queued along
with the message.

Additional opal message type OPAL_MSG_PRD is added to maintain
compatibility between opal and kernel definition of opal_message_type.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
No change from V2

Change from v1:
- Update the commit changelog

 arch/powerpc/include/asm/opal-api.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..50053b7 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -352,6 +352,14 @@ enum opal_msg_type {
 	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_DPO,
+	OPAL_MSG_PRD,
+	OPAL_MSG_OCC,                   /*
+					 * params[0] = 0 reset,
+					 *             1 load,
+					 *             2 throttle
+					 * params[1] = chip_id
+					 * params[2] = throttle_status
+					 */
 	OPAL_MSG_TYPE_MAX,
 };
 
-- 
1.9.3
