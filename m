Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB48FB6F72
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:18:47 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3T1Crbn028916
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:12:53 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3T1Ilkt2380020
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:18:47 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3T1Ikcu010909
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:18:46 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH 1/4] powerpc/hvsi: Move HVSI protocol definitions to a
	header file
Date: Fri, 29 Apr 2011 11:18:39 +1000
Message-Id: <1304039922-32262-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves various HVSI protocol definitions from the hvsi.c
driver to a header file that can be used later on by a udbg
implementation

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/hvsi.h |   68 +++++++++++++++++++++++++++++++++++++++
 drivers/tty/hvc/hvsi.c          |   63 +-----------------------------------
 2 files changed, 69 insertions(+), 62 deletions(-)
 create mode 100644 arch/powerpc/include/asm/hvsi.h

diff --git a/arch/powerpc/include/asm/hvsi.h b/arch/powerpc/include/asm/hvsi.h
new file mode 100644
index 0000000..f13125a
--- /dev/null
+++ b/arch/powerpc/include/asm/hvsi.h
@@ -0,0 +1,68 @@
+#ifndef _HVSI_H
+#define _HVSI_H
+
+#define VS_DATA_PACKET_HEADER           0xff
+#define VS_CONTROL_PACKET_HEADER        0xfe
+#define VS_QUERY_PACKET_HEADER          0xfd
+#define VS_QUERY_RESPONSE_PACKET_HEADER 0xfc
+
+/* control verbs */
+#define VSV_SET_MODEM_CTL    1 /* to service processor only */
+#define VSV_MODEM_CTL_UPDATE 2 /* from service processor only */
+#define VSV_CLOSE_PROTOCOL   3
+
+/* query verbs */
+#define VSV_SEND_VERSION_NUMBER 1
+#define VSV_SEND_MODEM_CTL_STATUS 2
+
+/* yes, these masks are not consecutive. */
+#define HVSI_TSDTR 0x01
+#define HVSI_TSCD  0x20
+
+#define HVSI_MAX_OUTGOING_DATA 12
+#define HVSI_VERSION 1
+
+struct hvsi_header {
+	uint8_t  type;
+	uint8_t  len;
+	uint16_t seqno;
+} __attribute__((packed));
+
+struct hvsi_data {
+	uint8_t  type;
+	uint8_t  len;
+	uint16_t seqno;
+	uint8_t  data[HVSI_MAX_OUTGOING_DATA];
+} __attribute__((packed));
+
+struct hvsi_control {
+	uint8_t  type;
+	uint8_t  len;
+	uint16_t seqno;
+	uint16_t verb;
+	/* optional depending on verb: */
+	uint32_t word;
+	uint32_t mask;
+} __attribute__((packed));
+
+struct hvsi_query {
+	uint8_t  type;
+	uint8_t  len;
+	uint16_t seqno;
+	uint16_t verb;
+} __attribute__((packed));
+
+struct hvsi_query_response {
+	uint8_t  type;
+	uint8_t  len;
+	uint16_t seqno;
+	uint16_t verb;
+	uint16_t query_seqno;
+	union {
+		uint8_t  version;
+		uint32_t mctrl_word;
+	} u;
+} __attribute__((packed));
+
+
+#endif /* _HVSI_H */
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 8a8d637..0b35793 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -49,6 +49,7 @@
 #include <asm/uaccess.h>
 #include <asm/vio.h>
 #include <asm/param.h>
+#include <asm/hvsi.h>
 
 #define HVSI_MAJOR	229
 #define HVSI_MINOR	128
@@ -109,68 +110,6 @@ enum HVSI_PROTOCOL_STATE {
 };
 #define HVSI_CONSOLE 0x1
 
-#define VS_DATA_PACKET_HEADER           0xff
-#define VS_CONTROL_PACKET_HEADER        0xfe
-#define VS_QUERY_PACKET_HEADER          0xfd
-#define VS_QUERY_RESPONSE_PACKET_HEADER 0xfc
-
-/* control verbs */
-#define VSV_SET_MODEM_CTL    1 /* to service processor only */
-#define VSV_MODEM_CTL_UPDATE 2 /* from service processor only */
-#define VSV_CLOSE_PROTOCOL   3
-
-/* query verbs */
-#define VSV_SEND_VERSION_NUMBER 1
-#define VSV_SEND_MODEM_CTL_STATUS 2
-
-/* yes, these masks are not consecutive. */
-#define HVSI_TSDTR 0x01
-#define HVSI_TSCD  0x20
-
-struct hvsi_header {
-	uint8_t  type;
-	uint8_t  len;
-	uint16_t seqno;
-} __attribute__((packed));
-
-struct hvsi_data {
-	uint8_t  type;
-	uint8_t  len;
-	uint16_t seqno;
-	uint8_t  data[HVSI_MAX_OUTGOING_DATA];
-} __attribute__((packed));
-
-struct hvsi_control {
-	uint8_t  type;
-	uint8_t  len;
-	uint16_t seqno;
-	uint16_t verb;
-	/* optional depending on verb: */
-	uint32_t word;
-	uint32_t mask;
-} __attribute__((packed));
-
-struct hvsi_query {
-	uint8_t  type;
-	uint8_t  len;
-	uint16_t seqno;
-	uint16_t verb;
-} __attribute__((packed));
-
-struct hvsi_query_response {
-	uint8_t  type;
-	uint8_t  len;
-	uint16_t seqno;
-	uint16_t verb;
-	uint16_t query_seqno;
-	union {
-		uint8_t  version;
-		uint32_t mctrl_word;
-	} u;
-} __attribute__((packed));
-
-
-
 static inline int is_console(struct hvsi_struct *hp)
 {
 	return hp->flags & HVSI_CONSOLE;
-- 
1.7.1
