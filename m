Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B457DE3BC
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:08:04 +1100 (EST)
Message-ID: <45BAC20C.5000708@am.sony.com>
Date: Fri, 26 Jan 2007 19:07:56 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/16] ps3: fix struct alignment attributes
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove incorrect alignment attributes in PS3 platform code for
struct spe_shadow, struct os_area_header, and struct os_area_params.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/ps3/os-area.c |    4 ++--
 arch/powerpc/platforms/ps3/spu.c     |    5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/os-area.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/os-area.c
@@ -59,7 +59,7 @@ struct os_area_header {
 	u32 ldr_format;
 	u32 ldr_size;
 	u32 _reserved_2[6];
-} __attribute__ ((packed));
+};
 
 enum {
 	PARAM_BOOT_FLAG_GAME_OS = 0,
@@ -114,7 +114,7 @@ struct os_area_params {
 	u8 dns_primary[4];
 	u8 dns_secondary[4];
 	u8 _reserved_5[8];
-} __attribute__ ((packed));
+};
 
 /**
  * struct saved_params - Static working copies of data from the 'Other OS' area.
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/spu.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/spu.c
@@ -50,7 +50,7 @@ enum spe_type {
  */
 
 struct spe_shadow {
-	u8 padding_0000[0x0140];
+	u8 padding_0140[0x0140];
 	u64 int_status_class0_RW;       /* 0x0140 */
 	u64 int_status_class1_RW;       /* 0x0148 */
 	u64 int_status_class2_RW;       /* 0x0150 */
@@ -67,8 +67,7 @@ struct spe_shadow {
 	u8 padding_0c08[0x0f00-0x0c08];
 	u64 spe_execution_status;       /* 0x0f00 */
 	u8 padding_0f08[0x1000-0x0f08];
-} __attribute__ ((packed));
-
+};
 
 /**
  * enum spe_ex_state - Logical spe execution state.
