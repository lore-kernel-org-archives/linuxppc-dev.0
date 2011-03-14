Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4C12B6FE3
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 07:29:36 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2EKJb1N019279
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:19:37 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CF96F38C8038
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:30 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2EKTXmk2539578
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:33 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2EKTW9O018531
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 17:29:32 -0300
Subject: [PATCH v3 1/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Mar 2011 15:29:32 -0500
Message-ID: <1300134572.803.14.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch adds definitions of non-IBM specific v6 extended log definitions to rtas.h.

Change log from V2:
- rename RTAS general extended event log version 6 structure from
  rtas_error_log_v6ext to rtas_ext_event_log_v6.

Signed-off-by: Tseng-Hui (Frank) Lin <tsenglin@us.ibm.com>
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
