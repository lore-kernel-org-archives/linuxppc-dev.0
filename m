Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2364D1A014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:21 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:27:19 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 32EB938C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:27:15 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RFW727394160
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:27:15 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2REO5023005
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:14 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 02/18] powerpc/powernv: synchronize OPAL calls and return
 codes with firmware
Date: Tue, 10 Feb 2015 13:26:44 +1100
Message-Id: <1423535220-6322-3-git-send-email-stewart@linux.vnet.ibm.com>
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

This just leaves us with CXL vs CAPI as differences in the list of OPAL
calls between opal.h in firmware and opal.h in Linux.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 4694183..80cb4d3 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -56,6 +56,7 @@ struct opal_sg_list {
 #define OPAL_HARDWARE_FROZEN	-13
 #define OPAL_WRONG_STATE	-14
 #define OPAL_ASYNC_COMPLETION	-15
+#define OPAL_EMPTY		-16
 #define OPAL_I2C_TIMEOUT	-17
 #define OPAL_I2C_INVALID_CMD	-18
 #define OPAL_I2C_LBUS_PARITY	-19
@@ -66,7 +67,8 @@ struct opal_sg_list {
 #define OPAL_I2C_STOP_ERR	-24
 
 /* API Tokens (in r0) */
-#define OPAL_INVALID_CALL			-1
+#define OPAL_INVALID_CALL		       -1
+#define OPAL_TEST				0
 #define OPAL_CONSOLE_WRITE			1
 #define OPAL_CONSOLE_READ			2
 #define OPAL_RTC_READ				3
@@ -155,8 +157,10 @@ struct opal_sg_list {
 #define OPAL_GET_PARAM				89
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
+#define OPAL_ELOG_SEND				92	/* Deprecated */
 #define OPAL_PCI_SET_PHB_CXL_MODE		93
 #define OPAL_DUMP_INFO2				94
+#define OPAL_WRITE_OPPANEL_ASYNC		95
 #define OPAL_PCI_ERR_INJECT			96
 #define OPAL_PCI_EEH_FREEZE_SET			97
 #define OPAL_HANDLE_HMI				98
@@ -166,9 +170,12 @@ struct opal_sg_list {
 #define OPAL_UNREGISTER_DUMP_REGION		102
 #define OPAL_WRITE_TPO				103
 #define OPAL_READ_TPO				104
+#define OPAL_GET_DPO_STATUS			105
+#define OPAL_OLD_I2C_REQUEST			106	/* Deprecated */
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
 #define OPAL_I2C_REQUEST			109
+#define OPAL_LAST				109
 
 /* Device tree flags */
 
-- 
1.7.10.4
