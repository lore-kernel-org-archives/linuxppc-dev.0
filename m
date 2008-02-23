Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2AFD6DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 22:30:57 +1100 (EST)
Date: Sat, 23 Feb 2008 12:24:57 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/2] firewire: endianess annotations
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
Message-ID: <tkrat.99ed7585f5c25d58@s5r6.in-berlin.de>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Jarod Wilson <jwilson@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kills warnings from 'make C=1 CHECKFLAGS="-D__CHECK_ENDIAN__" modules':

drivers/firewire/fw-transaction.c:771:10: warning: incorrect type in assignment (different base types)
drivers/firewire/fw-transaction.c:771:10:    expected unsigned int [unsigned] [usertype] <noident>
drivers/firewire/fw-transaction.c:771:10:    got restricted unsigned int [usertype] <noident>
drivers/firewire/fw-transaction.h:93:10: warning: incorrect type in assignment (different base types)
drivers/firewire/fw-transaction.h:93:10:    expected unsigned int [unsigned] [usertype] <noident>
drivers/firewire/fw-transaction.h:93:10:    got restricted unsigned int [usertype] <noident>
drivers/firewire/fw-ohci.c:1490:8: warning: restricted degrades to integer
drivers/firewire/fw-ohci.c:1490:35: warning: restricted degrades to integer
drivers/firewire/fw-ohci.c:1516:5: warning: cast to restricted type

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
---
 drivers/firewire/fw-ohci.c        |    4 ++--
 drivers/firewire/fw-transaction.c |    2 +-
 drivers/firewire/fw-transaction.h |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux/drivers/firewire/fw-ohci.c
===================================================================
--- linux.orig/drivers/firewire/fw-ohci.c
+++ linux/drivers/firewire/fw-ohci.c
@@ -1487,7 +1487,7 @@ static int handle_ir_dualbuffer_packet(s
 	void *p, *end;
 	int i;
 
-	if (db->first_res_count > 0 && db->second_res_count > 0) {
+	if (db->first_res_count != 0 && db->second_res_count != 0) {
 		if (ctx->excess_bytes <= le16_to_cpu(db->second_req_count)) {
 			/* This descriptor isn't done yet, stop iteration. */
 			return 0;
@@ -1513,7 +1513,7 @@ static int handle_ir_dualbuffer_packet(s
 		memcpy(ctx->header + i + 4, p + 8, ctx->base.header_size - 4);
 		i += ctx->base.header_size;
 		ctx->excess_bytes +=
-			(le32_to_cpu(*(u32 *)(p + 4)) >> 16) & 0xffff;
+			(le32_to_cpu(*(__le32 *)(p + 4)) >> 16) & 0xffff;
 		p += ctx->base.header_size + 4;
 	}
 	ctx->header_length = i;
Index: linux/drivers/firewire/fw-transaction.c
===================================================================
--- linux.orig/drivers/firewire/fw-transaction.c
+++ linux/drivers/firewire/fw-transaction.c
@@ -751,7 +751,7 @@ handle_topology_map(struct fw_card *card
 		    void *payload, size_t length, void *callback_data)
 {
 	int i, start, end;
-	u32 *map;
+	__be32 *map;
 
 	if (!TCODE_IS_READ_REQUEST(tcode)) {
 		fw_send_response(card, request, RCODE_TYPE_ERROR);
Index: linux/drivers/firewire/fw-transaction.h
===================================================================
--- linux.orig/drivers/firewire/fw-transaction.h
+++ linux/drivers/firewire/fw-transaction.h
@@ -85,12 +85,12 @@
 static inline void
 fw_memcpy_from_be32(void *_dst, void *_src, size_t size)
 {
-	u32 *dst = _dst;
-	u32 *src = _src;
+	u32    *dst = _dst;
+	__be32 *src = _src;
 	int i;
 
 	for (i = 0; i < size / 4; i++)
-		dst[i] = cpu_to_be32(src[i]);
+		dst[i] = be32_to_cpu(src[i]);
 }
 
 static inline void

-- 
Stefan Richter
-=====-==--- --=- =-===
http://arcgraph.de/sr/
