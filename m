Return-Path: <anton@ozlabs.org>
Date: Wed, 1 Apr 2009 17:13:27 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: Scan for all events in rtasd
Message-ID: <20090401061327.GD27084@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Instead of checking for known events, pass in all 1s so we handle future
event types. We were currently missing the IO event type.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 0aa0315..01c1233 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -68,7 +68,8 @@ struct rtas_t {
 #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
 #define RTAS_POWERMGM_EVENTS		0x20000000 /* set bit 2 */
 #define RTAS_HOTPLUG_EVENTS		0x10000000 /* set bit 3 */
-#define RTAS_EVENT_SCAN_ALL_EVENTS	0xf0000000
+#define RTAS_IO_EVENTS			0x08000000 /* set bit 4 */
+#define RTAS_EVENT_SCAN_ALL_EVENTS	0xffffffff
 
 /* RTAS event severity */
 #define RTAS_SEVERITY_FATAL		0x5
