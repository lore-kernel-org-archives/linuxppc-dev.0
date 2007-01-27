Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8F887DE66D
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:08:21 +1100 (EST)
Message-ID: <45BAC220.1060304@am.sony.com>
Date: Fri, 26 Jan 2007 19:08:16 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 11/16] ps3: fix interrupt bmp
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a comment and a preprocessor macro to help clearify the alignment
needs of the PS3 interrupt bitmap.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/interrupt.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
@@ -48,6 +48,9 @@
  * behalf of the guest.  These mappings are implemented as 256 bit guest
  * supplied bitmaps indexed by plug number.  The addresses of the bitmaps
  * are registered with the HV through lv1_configure_irq_state_bitmap().
+ * The HV requires that the 512 bits of status + mask not cross a page
+ * boundary.  PS3_BMP_MINALIGN is used to define this minimal 64 byte
+ * alignment.
  *
  * The HV supports 256 plugs per thread, assigned as {0..255}, for a total
  * of 512 plugs supported on a processor.  To simplify the logic this
@@ -59,6 +62,8 @@
  * can acquire.
  */
 
+#define PS3_BMP_MINALIGN 64
+
 struct ps3_bmp {
 	struct {
 		u64 status;
@@ -78,7 +83,7 @@ struct ps3_bmp {
  */
 
 struct ps3_private {
-	struct ps3_bmp bmp __attribute__ ((aligned (64)));
+	struct ps3_bmp bmp __attribute__ ((aligned (PS3_BMP_MINALIGN)));
 	u64 node;
 	unsigned int cpu;
 };
