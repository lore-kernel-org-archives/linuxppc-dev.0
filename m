Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC5111A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:35 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:27:33 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F31781FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:18:42 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1A2RZRT13172856
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RU7B017373
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:30 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 13/18] powerpc/powernv: add remaining missing enums to opal.h
Date: Tue, 10 Feb 2015 13:26:55 +1100
Message-Id: <1423535220-6322-14-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some enums in firmware opal.h were missing from linux opal.h, add them.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 214a106..c09cf66 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -244,8 +244,13 @@ enum OpalShpcAction {
 };
 
 enum OpalShpcLinkState {
-	OPAL_SHPC_LINK_DOWN = 0,
-	OPAL_SHPC_LINK_UP = 1
+	OPAL_SHPC_LINK_DOWN	  = 0,
+	OPAL_SHPC_LINK_UP_x1	  = 1,
+	OPAL_SHPC_LINK_UP_x2	  = 2,
+	OPAL_SHPC_LINK_UP_x4	  = 4,
+	OPAL_SHPC_LINK_UP_x8	  = 8,
+	OPAL_SHPC_LINK_UP_x16	  = 16,
+	OPAL_SHPC_LINK_UP_x32	  = 32
 };
 
 enum OpalMmioWindowType {
@@ -253,10 +258,15 @@ enum OpalMmioWindowType {
 	OPAL_M64_WINDOW_TYPE = 2,
 	OPAL_IO_WINDOW_TYPE  = 3
 };
+
 enum OpalShpcSlotState {
 	OPAL_SHPC_DEV_NOT_PRESENT = 0,
 	OPAL_SHPC_DEV_PRESENT	  = 1
 };
+enum OpalShpcPowerState {
+	OPAL_SHPC_POWER_OFF	  = 0,
+	OPAL_SHPC_POWER_ON	  = 1
+};
 
 enum OpalExceptionHandler {
 	OPAL_MACHINE_CHECK_HANDLER	    = 1,
@@ -367,6 +377,11 @@ enum OpalEpowStatus {
 	OPAL_EPOW_OVER_INTERNAL_TEMP = 3
 };
 
+enum OpalCheckTokenStatus {
+	OPAL_TOKEN_ABSENT = 0,
+	OPAL_TOKEN_PRESENT = 1
+};
+
 /*
  * Address cycle types for LPC accesses. These also correspond
  * to the content of the first cell of the "reg" property for
@@ -536,6 +551,7 @@ enum OpalHMI_ErrType {
 	OpalHMI_ERROR_SCOM_FIR,
 	OpalHMI_ERROR_DEBUG_TRIG_FIR,
 	OpalHMI_ERROR_HYP_RESOURCE,
+	OpalHMI_ERROR_CAPP_RECOVERY,
 };
 
 struct OpalHMIEvent {
-- 
1.7.10.4
