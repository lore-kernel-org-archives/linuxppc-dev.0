Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 928F31A0311
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:28:08 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:28:06 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CC6273E4004C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:28:04 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RxTk27000992
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:28:07 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RVGu020489
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:32 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 08/18] powerpc/powernv: Move OpalSysparamPerm,
 OpalMessageType in opal.h to match firmware
Date: Tue, 10 Feb 2015 13:26:50 +1100
Message-Id: <1423535220-6322-9-git-send-email-stewart@linux.vnet.ibm.com>
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

For whatever strange reason, these two structures were in different
locations in opal.h in firmware and opal.h in Linux. Move them around
to match firmware so that the diff is less.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 31b9656..3786c6b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -279,17 +279,6 @@ enum OpalPendingState {
 	OPAL_EVENT_MSG_PENDING	   = 0x800,
 };
 
-enum OpalMessageType {
-	OPAL_MSG_ASYNC_COMP = 0,	/* params[0] = token, params[1] = rc,
-					 * additional params function-specific
-					 */
-	OPAL_MSG_MEM_ERR,
-	OPAL_MSG_EPOW,
-	OPAL_MSG_SHUTDOWN,
-	OPAL_MSG_HMI_EVT,
-	OPAL_MSG_TYPE_MAX,
-};
-
 enum OpalThreadStatus {
 	OPAL_THREAD_INACTIVE = 0x0,
 	OPAL_THREAD_STARTED = 0x1,
@@ -389,11 +378,15 @@ enum OpalLPCAddressType {
 	OPAL_LPC_FW	= 2,
 };
 
-/* System parameter permission */
-enum OpalSysparamPerm {
-	OPAL_SYSPARAM_READ      = 0x1,
-	OPAL_SYSPARAM_WRITE     = 0x2,
-	OPAL_SYSPARAM_RW        = (OPAL_SYSPARAM_READ | OPAL_SYSPARAM_WRITE),
+enum OpalMessageType {
+	OPAL_MSG_ASYNC_COMP = 0,	/* params[0] = token, params[1] = rc,
+					 * additional params function-specific
+					 */
+	OPAL_MSG_MEM_ERR,
+	OPAL_MSG_EPOW,
+	OPAL_MSG_SHUTDOWN,
+	OPAL_MSG_HMI_EVT,
+	OPAL_MSG_TYPE_MAX,
 };
 
 struct opal_msg {
@@ -402,6 +395,13 @@ struct opal_msg {
 	__be64 params[8];
 };
 
+/* System parameter permission */
+enum OpalSysparamPerm {
+	OPAL_SYSPARAM_READ      = 0x1,
+	OPAL_SYSPARAM_WRITE     = 0x2,
+	OPAL_SYSPARAM_RW        = (OPAL_SYSPARAM_READ | OPAL_SYSPARAM_WRITE),
+};
+
 enum {
 	OPAL_IPMI_MSG_FORMAT_VERSION_1 = 1,
 };
-- 
1.7.10.4
