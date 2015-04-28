Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB87C1A084F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 16:24:00 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D50211400B7
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 16:23:59 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 11:53:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 12EA11258059
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 11:55:54 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3S6Nqiv65929352
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 11:53:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S6NqnB025695
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 11:53:52 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc/powernv: Add definition of OPAL_MSG_OCC
 message type
Date: Tue, 28 Apr 2015 11:53:33 +0530
Message-Id: <1430202214-13807-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
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
Changes from v1:
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
