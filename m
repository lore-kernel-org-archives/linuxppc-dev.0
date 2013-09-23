Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 33/39] powerpc/hvsi: Fix endian issues in HVSI driver
Date: Mon, 23 Sep 2013 12:05:07 +1000
Message-Id: <1379901913-5945-34-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/hvsi.h | 16 ++++++++--------
 drivers/tty/hvc/hvsi_lib.c      | 25 ++++++++++++-------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/hvsi.h b/arch/powerpc/include/asm/hvsi.h
index d3f64f3..d4a5315 100644
--- a/arch/powerpc/include/asm/hvsi.h
+++ b/arch/powerpc/include/asm/hvsi.h
@@ -25,7 +25,7 @@
 struct hvsi_header {
 	uint8_t  type;
 	uint8_t  len;
-	uint16_t seqno;
+	__be16 seqno;
 } __attribute__((packed));
 
 struct hvsi_data {
@@ -35,24 +35,24 @@ struct hvsi_data {
 
 struct hvsi_control {
 	struct hvsi_header hdr;
-	uint16_t verb;
+	__be16 verb;
 	/* optional depending on verb: */
-	uint32_t word;
-	uint32_t mask;
+	__be32 word;
+	__be32 mask;
 } __attribute__((packed));
 
 struct hvsi_query {
 	struct hvsi_header hdr;
-	uint16_t verb;
+	__be16 verb;
 } __attribute__((packed));
 
 struct hvsi_query_response {
 	struct hvsi_header hdr;
-	uint16_t verb;
-	uint16_t query_seqno;
+	__be16 verb;
+	__be16 query_seqno;
 	union {
 		uint8_t  version;
-		uint32_t mctrl_word;
+		__be32 mctrl_word;
 	} u;
 } __attribute__((packed));
 
diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
index ac27671..347050e 100644
--- a/drivers/tty/hvc/hvsi_lib.c
+++ b/drivers/tty/hvc/hvsi_lib.c
@@ -9,7 +9,7 @@
 
 static int hvsi_send_packet(struct hvsi_priv *pv, struct hvsi_header *packet)
 {
-	packet->seqno = atomic_inc_return(&pv->seqno);
+	packet->seqno = cpu_to_be16(atomic_inc_return(&pv->seqno));
 
 	/* Assumes that always succeeds, works in practice */
 	return pv->put_chars(pv->termno, (char *)packet, packet->len);
@@ -28,7 +28,7 @@ static void hvsi_start_handshake(struct hvsi_priv *pv)
 	/* Send version query */
 	q.hdr.type = VS_QUERY_PACKET_HEADER;
 	q.hdr.len = sizeof(struct hvsi_query);
-	q.verb = VSV_SEND_VERSION_NUMBER;
+	q.verb = cpu_to_be16(VSV_SEND_VERSION_NUMBER);
 	hvsi_send_packet(pv, &q.hdr);
 }
 
@@ -40,7 +40,7 @@ static int hvsi_send_close(struct hvsi_priv *pv)
 
 	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER;
 	ctrl.hdr.len = sizeof(struct hvsi_control);
-	ctrl.verb = VSV_CLOSE_PROTOCOL;
+	ctrl.verb = cpu_to_be16(VSV_CLOSE_PROTOCOL);
 	return hvsi_send_packet(pv, &ctrl.hdr);
 }
 
@@ -69,14 +69,14 @@ static void hvsi_got_control(struct hvsi_priv *pv)
 {
 	struct hvsi_control *pkt = (struct hvsi_control *)pv->inbuf;
 
-	switch (pkt->verb) {
+	switch (be16_to_cpu(pkt->verb)) {
 	case VSV_CLOSE_PROTOCOL:
 		/* We restart the handshaking */
 		hvsi_start_handshake(pv);
 		break;
 	case VSV_MODEM_CTL_UPDATE:
 		/* Transition of carrier detect */
-		hvsi_cd_change(pv, pkt->word & HVSI_TSCD);
+		hvsi_cd_change(pv, be32_to_cpu(pkt->word) & HVSI_TSCD);
 		break;
 	}
 }
@@ -87,7 +87,7 @@ static void hvsi_got_query(struct hvsi_priv *pv)
 	struct hvsi_query_response r;
 
 	/* We only handle version queries */
-	if (pkt->verb != VSV_SEND_VERSION_NUMBER)
+	if (be16_to_cpu(pkt->verb) != VSV_SEND_VERSION_NUMBER)
 		return;
 
 	pr_devel("HVSI@%x: Got version query, sending response...\n",
@@ -96,7 +96,7 @@ static void hvsi_got_query(struct hvsi_priv *pv)
 	/* Send version response */
 	r.hdr.type = VS_QUERY_RESPONSE_PACKET_HEADER;
 	r.hdr.len = sizeof(struct hvsi_query_response);
-	r.verb = VSV_SEND_VERSION_NUMBER;
+	r.verb = cpu_to_be16(VSV_SEND_VERSION_NUMBER);
 	r.u.version = HVSI_VERSION;
 	r.query_seqno = pkt->hdr.seqno;
 	hvsi_send_packet(pv, &r.hdr);
@@ -112,7 +112,7 @@ static void hvsi_got_response(struct hvsi_priv *pv)
 
 	switch(r->verb) {
 	case VSV_SEND_MODEM_CTL_STATUS:
-		hvsi_cd_change(pv, r->u.mctrl_word & HVSI_TSCD);
+		hvsi_cd_change(pv, be32_to_cpu(r->u.mctrl_word) & HVSI_TSCD);
 		pv->mctrl_update = 1;
 		break;
 	}
@@ -265,8 +265,7 @@ int hvsilib_read_mctrl(struct hvsi_priv *pv)
 	pv->mctrl_update = 0;
 	q.hdr.type = VS_QUERY_PACKET_HEADER;
 	q.hdr.len = sizeof(struct hvsi_query);
-	q.hdr.seqno = atomic_inc_return(&pv->seqno);
-	q.verb = VSV_SEND_MODEM_CTL_STATUS;
+	q.verb = cpu_to_be16(VSV_SEND_MODEM_CTL_STATUS);
 	rc = hvsi_send_packet(pv, &q.hdr);
 	if (rc <= 0) {
 		pr_devel("HVSI@%x: Error %d...\n", pv->termno, rc);
@@ -304,9 +303,9 @@ int hvsilib_write_mctrl(struct hvsi_priv *pv, int dtr)
 
 	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER,
 	ctrl.hdr.len = sizeof(struct hvsi_control);
-	ctrl.verb = VSV_SET_MODEM_CTL;
-	ctrl.mask = HVSI_TSDTR;
-	ctrl.word = dtr ? HVSI_TSDTR : 0;
+	ctrl.verb = cpu_to_be16(VSV_SET_MODEM_CTL);
+	ctrl.mask = cpu_to_be32(HVSI_TSDTR);
+	ctrl.word = cpu_to_be32(dtr ? HVSI_TSDTR : 0);
 	return hvsi_send_packet(pv, &ctrl.hdr);
 }
 
-- 
1.8.1.2
