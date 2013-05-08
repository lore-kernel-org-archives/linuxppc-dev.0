Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 08E632C0120
 for <linuxppc-dev@ozlabs.org>; Wed,  8 May 2013 14:15:29 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r484FOIe013136
 for <linuxppc-dev@ozlabs.org>; Tue, 7 May 2013 23:15:26 -0500
Message-ID: <1367986524.25488.115.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Properly drop characters if console is closed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Wed, 08 May 2013 14:15:24 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the firmware returns an error such as "closed" (or hardware
error), we should drop characters.

Currently we only do that when a firmware compatible with OPAL v2
APIs is detected, in the code that calls opal_console_write_buffer_space(),
which didn't exist with OPAL v1 (or didn't work).

However, when enabling early debug consoles, the flag indicating
that v2 is supported isn't set yet, causing us, in case of errors
or closed console, to spin forever.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index ade4463..12d9846 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -144,6 +144,13 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 				rc == OPAL_BUSY_EVENT || rc == OPAL_SUCCESS)) {
 		len = total_len;
 		rc = opal_console_write(vtermno, &len, data);
+
+		/* Closed or other error drop */
+		if (rc != OPAL_SUCCESS && rc != OPAL_BUSY &&
+		    rc != OPAL_BUSY_EVENT) {
+			written = total_len;
+			break;
+		}
 		if (rc == OPAL_SUCCESS) {
 			total_len -= len;
 			data += len;
