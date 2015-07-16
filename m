Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EECB91A0EFB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 18:05:03 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 32D4B1402B2
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 18:05:03 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 13:35:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 507C1394006C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6G84hp953411908
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6G84f6a030619
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:41 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH v5 2/6] powerpc/powernv: Add definition of OPAL_MSG_OCC
 message type
Date: Thu, 16 Jul 2015 13:34:19 +0530
Message-Id: <1437033863-15864-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

CC: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No change from v4

Changes from v3:
- '0d7cd8550d3 powerpc/powernv: Add opal-prd channel' this patch adds
  the definition of OPAL_MSG_PRD, so remove it and update the
  changelog.
- Move the definitions of OCC_RESET, OCC_LOAD and OCC_THROTTLE from 
  drivers/cpufreq/powernv-cpufreq.c to arch/powerpc/include/asm/opal-api.h
- Define OCC_MAX_THROTTLE_STATUS 
- Add a wrapper structure 'opal_occ_msg' to copy 'struct opal_msg.params[0..2]'
  This structure will define the parameters received from firmware to
  maintain compatibility for any future additions.

No change from v2

Change from v1:
- Update the commit changelog

 arch/powerpc/include/asm/opal-api.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e9e4c52..64dc9f5 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -361,6 +361,7 @@ enum opal_msg_type {
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_DPO,
 	OPAL_MSG_PRD,
+	OPAL_MSG_OCC,
 	OPAL_MSG_TYPE_MAX,
 };
 
@@ -700,6 +701,17 @@ struct opal_prd_msg_header {
 
 struct opal_prd_msg;
 
+#define OCC_RESET                       0
+#define OCC_LOAD                        1
+#define OCC_THROTTLE                    2
+#define OCC_MAX_THROTTLE_STATUS         5
+
+struct opal_occ_msg {
+	__be64 type;
+	__be64 chip;
+	__be64 throttle_status;
+};
+
 /*
  * SG entries
  *
-- 
1.9.3
