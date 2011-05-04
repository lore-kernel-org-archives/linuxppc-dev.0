Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8F88B6F05
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2011 14:28:52 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p444SVll008553
	for <linuxppc-dev@ozlabs.org>; Wed, 4 May 2011 14:28:31 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p444SodZ1093824
	for <linuxppc-dev@ozlabs.org>; Wed, 4 May 2011 14:28:52 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p444SnXd020421
	for <linuxppc-dev@ozlabs.org>; Wed, 4 May 2011 14:28:50 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, tsenglin@us.ibm.com
Subject: [PATCH 1/2] powerpc/pseries: Add RTAS event log v6 definition
Date: Wed,  4 May 2011 14:28:43 +1000
Message-Id: <1304483324-11155-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1304483324-11155-1-git-send-email-benh@kernel.crashing.org>
References: <1304483324-11155-1-git-send-email-benh@kernel.crashing.org>
Cc: "Tseng-Hui \(Frank\) Lin" <thlin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>

This patch adds definitions of non-IBM specific v6 extended log
definitions to rtas.h.

Signed-off-by: Tseng-Hui (Frank) Lin <tsenglin@us.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/rtas.h |   45 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 9a1193e..58625d1 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -158,7 +158,50 @@ struct rtas_error_log {
 	unsigned long target:4;			/* Target of failed operation */
 	unsigned long type:8;			/* General event or error*/
 	unsigned long extended_log_length:32;	/* length in bytes */
-	unsigned char buffer[1];
+	unsigned char buffer[1];		/* Start of extended log */
+						/* Variable length.      */
+};
+
+#define RTAS_V6EXT_LOG_FORMAT_EVENT_LOG	14
+
+#define RTAS_V6EXT_COMPANY_ID_IBM	(('I' << 24) | ('B' << 16) | ('M' << 8))
+
+/* RTAS general extended event log, Version 6. The extended log starts
+ * from "buffer" field of struct rtas_error_log defined above.
+ */
+struct rtas_ext_event_log_v6 {
+	/* Byte 0 */
+	uint32_t log_valid:1;		/* 1:Log valid */
+	uint32_t unrecoverable_error:1;	/* 1:Unrecoverable error */
+	uint32_t recoverable_error:1;	/* 1:recoverable (correctable	*/
+					/*   or successfully retried)	*/
+	uint32_t degraded_operation:1;	/* 1:Unrecoverable err, bypassed*/
+					/*   - degraded operation (e.g.	*/
+					/*   CPU or mem taken off-line)	*/
+	uint32_t predictive_error:1;
+	uint32_t new_log:1;		/* 1:"New" log (Always 1 for	*/
+					/*   data returned from RTAS	*/
+	uint32_t big_endian:1;		/* 1: Big endian */
+	uint32_t :1;			/* reserved */
+	/* Byte 1 */
+	uint32_t :8;			/* reserved */
+	/* Byte 2 */
+	uint32_t powerpc_format:1;	/* Set to 1 (indicating log is	*/
+					/* in PowerPC format		*/
+	uint32_t :3;			/* reserved */
+	uint32_t log_format:4;		/* Log format indicator. Define	*/
+					/* format used for byte 12-2047	*/
+	/* Byte 3 */
+	uint32_t :8;			/* reserved */
+	/* Byte 4-11 */
+	uint8_t reserved[8];		/* reserved */
+	/* Byte 12-15 */
+	uint32_t company_id;		/* Company ID of the company	*/
+					/* that defines the format for	*/
+					/* the vendor specific log type	*/
+	/* Byte 16-end of log */
+	uint8_t vendor_log[1];		/* Start of vendor specific log	*/
+					/* Variable length.		*/
 };
 
 /*
-- 
1.7.1
