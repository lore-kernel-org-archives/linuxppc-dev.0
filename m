Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A86E41A0775
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 19:32:35 +1000 (AEST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 31 Jul 2015 10:32:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 62E2717D8062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 10:31:19 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6V9Tquq32309324
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 09:29:52 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6V9TpxE029665
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 03:29:52 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
Date: Fri, 31 Jul 2015 11:29:50 +0200
Message-Id: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes several endianness issues detected when running the HVSI
driver in little endian mode.

These issues are raised in little endian mode because the data exchanged in
memory between the kernel and the hypervisor has to be in big endian
format.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.cz>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 drivers/tty/hvc/hvsi.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 41901997c0d6..a75146f600cb 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -240,9 +240,9 @@ static void hvsi_recv_control(struct hvsi_struct *hp, uint8_t *packet,
 {
 	struct hvsi_control *header = (struct hvsi_control *)packet;
 
-	switch (header->verb) {
+	switch (be16_to_cpu(header->verb)) {
 		case VSV_MODEM_CTL_UPDATE:
-			if ((header->word & HVSI_TSCD) == 0) {
+			if ((be32_to_cpu(header->word) & HVSI_TSCD) == 0) {
 				/* CD went away; no more connection */
 				pr_debug("hvsi%i: CD dropped\n", hp->index);
 				hp->mctrl &= TIOCM_CD;
@@ -267,6 +267,7 @@ static void hvsi_recv_control(struct hvsi_struct *hp, uint8_t *packet,
 static void hvsi_recv_response(struct hvsi_struct *hp, uint8_t *packet)
 {
 	struct hvsi_query_response *resp = (struct hvsi_query_response *)packet;
+	uint32_t mctrl_word;
 
 	switch (hp->state) {
 		case HVSI_WAIT_FOR_VER_RESPONSE:
@@ -274,9 +275,10 @@ static void hvsi_recv_response(struct hvsi_struct *hp, uint8_t *packet)
 			break;
 		case HVSI_WAIT_FOR_MCTRL_RESPONSE:
 			hp->mctrl = 0;
-			if (resp->u.mctrl_word & HVSI_TSDTR)
+			mctrl_word = be32_to_cpu(resp->u.mctrl_word);
+			if (mctrl_word & HVSI_TSDTR)
 				hp->mctrl |= TIOCM_DTR;
-			if (resp->u.mctrl_word & HVSI_TSCD)
+			if (mctrl_word & HVSI_TSCD)
 				hp->mctrl |= TIOCM_CD;
 			__set_state(hp, HVSI_OPEN);
 			break;
@@ -295,10 +297,10 @@ static int hvsi_version_respond(struct hvsi_struct *hp, uint16_t query_seqno)
 
 	packet.hdr.type = VS_QUERY_RESPONSE_PACKET_HEADER;
 	packet.hdr.len = sizeof(struct hvsi_query_response);
-	packet.hdr.seqno = atomic_inc_return(&hp->seqno);
-	packet.verb = VSV_SEND_VERSION_NUMBER;
+	packet.hdr.seqno = cpu_to_be16(atomic_inc_return(&hp->seqno));
+	packet.verb = cpu_to_be16(VSV_SEND_VERSION_NUMBER);
 	packet.u.version = HVSI_VERSION;
-	packet.query_seqno = query_seqno+1;
+	packet.query_seqno = cpu_to_be16(query_seqno+1);
 
 	pr_debug("%s: sending %i bytes\n", __func__, packet.hdr.len);
 	dbg_dump_hex((uint8_t*)&packet, packet.hdr.len);
@@ -319,7 +321,7 @@ static void hvsi_recv_query(struct hvsi_struct *hp, uint8_t *packet)
 
 	switch (hp->state) {
 		case HVSI_WAIT_FOR_VER_QUERY:
-			hvsi_version_respond(hp, query->hdr.seqno);
+			hvsi_version_respond(hp, be16_to_cpu(query->hdr.seqno));
 			__set_state(hp, HVSI_OPEN);
 			break;
 		default:
@@ -555,8 +557,8 @@ static int hvsi_query(struct hvsi_struct *hp, uint16_t verb)
 
 	packet.hdr.type = VS_QUERY_PACKET_HEADER;
 	packet.hdr.len = sizeof(struct hvsi_query);
-	packet.hdr.seqno = atomic_inc_return(&hp->seqno);
-	packet.verb = verb;
+	packet.hdr.seqno = cpu_to_be16(atomic_inc_return(&hp->seqno));
+	packet.verb = cpu_to_be16(verb);
 
 	pr_debug("%s: sending %i bytes\n", __func__, packet.hdr.len);
 	dbg_dump_hex((uint8_t*)&packet, packet.hdr.len);
@@ -596,14 +598,14 @@ static int hvsi_set_mctrl(struct hvsi_struct *hp, uint16_t mctrl)
 	struct hvsi_control packet __ALIGNED__;
 	int wrote;
 
-	packet.hdr.type = VS_CONTROL_PACKET_HEADER,
-	packet.hdr.seqno = atomic_inc_return(&hp->seqno);
+	packet.hdr.type = VS_CONTROL_PACKET_HEADER;
+	packet.hdr.seqno = cpu_to_be16(atomic_inc_return(&hp->seqno));
 	packet.hdr.len = sizeof(struct hvsi_control);
-	packet.verb = VSV_SET_MODEM_CTL;
-	packet.mask = HVSI_TSDTR;
+	packet.verb = cpu_to_be16(VSV_SET_MODEM_CTL);
+	packet.mask = cpu_to_be32(HVSI_TSDTR);
 
 	if (mctrl & TIOCM_DTR)
-		packet.word = HVSI_TSDTR;
+		packet.word = cpu_to_be32(HVSI_TSDTR);
 
 	pr_debug("%s: sending %i bytes\n", __func__, packet.hdr.len);
 	dbg_dump_hex((uint8_t*)&packet, packet.hdr.len);
@@ -680,7 +682,7 @@ static int hvsi_put_chars(struct hvsi_struct *hp, const char *buf, int count)
 	BUG_ON(count > HVSI_MAX_OUTGOING_DATA);
 
 	packet.hdr.type = VS_DATA_PACKET_HEADER;
-	packet.hdr.seqno = atomic_inc_return(&hp->seqno);
+	packet.hdr.seqno = cpu_to_be16(atomic_inc_return(&hp->seqno));
 	packet.hdr.len = count + sizeof(struct hvsi_header);
 	memcpy(&packet.data, buf, count);
 
@@ -697,9 +699,9 @@ static void hvsi_close_protocol(struct hvsi_struct *hp)
 	struct hvsi_control packet __ALIGNED__;
 
 	packet.hdr.type = VS_CONTROL_PACKET_HEADER;
-	packet.hdr.seqno = atomic_inc_return(&hp->seqno);
+	packet.hdr.seqno = cpu_to_be16(atomic_inc_return(&hp->seqno));
 	packet.hdr.len = 6;
-	packet.verb = VSV_CLOSE_PROTOCOL;
+	packet.verb = cpu_to_be16(VSV_CLOSE_PROTOCOL);
 
 	pr_debug("%s: sending %i bytes\n", __func__, packet.hdr.len);
 	dbg_dump_hex((uint8_t*)&packet, packet.hdr.len);
@@ -1180,7 +1182,7 @@ static int __init hvsi_console_init(void)
 	/* search device tree for vty nodes */
 	for_each_compatible_node(vty, "serial", "hvterm-protocol") {
 		struct hvsi_struct *hp;
-		const uint32_t *vtermno, *irq;
+		const __be32 *vtermno, *irq;
 
 		vtermno = of_get_property(vty, "reg", NULL);
 		irq = of_get_property(vty, "interrupts", NULL);
@@ -1202,11 +1204,11 @@ static int __init hvsi_console_init(void)
 		hp->index = hvsi_count;
 		hp->inbuf_end = hp->inbuf;
 		hp->state = HVSI_CLOSED;
-		hp->vtermno = *vtermno;
-		hp->virq = irq_create_mapping(NULL, irq[0]);
+		hp->vtermno = be32_to_cpup(vtermno);
+		hp->virq = irq_create_mapping(NULL, be32_to_cpup(irq));
 		if (hp->virq == 0) {
 			printk(KERN_ERR "%s: couldn't create irq mapping for 0x%x\n",
-				__func__, irq[0]);
+			       __func__, be32_to_cpup(irq));
 			tty_port_destroy(&hp->port);
 			continue;
 		}
-- 
1.9.1
