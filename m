Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DB447DE048
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 12:59:47 +1000 (EST)
Message-ID: <4666231F.9090901@am.sony.com>
Date: Tue, 05 Jun 2007 19:59:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [patch 04/18] PS3: Compare firmware version
References: <20070606024407.786638029@am.sony.com>>
In-Reply-To: <20070606024407.786638029@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a utiltiy routine ps3_compare_firmware_version() to compare system
firmware versions.  Uses the existing ps3_get_firmware_version() routine.

Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/setup.c |   32 ++++++++++++++++++++------------
 include/asm-powerpc/ps3.h          |    3 ++-
 2 files changed, 22 insertions(+), 13 deletions(-)

--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -46,18 +46,26 @@
 static void smp_send_stop(void) {}
 #endif
 
-int ps3_get_firmware_version(union ps3_firmware_version *v)
+static union ps3_firmware_version ps3_firmware_version;
+
+void ps3_get_firmware_version(union ps3_firmware_version *v)
 {
-	int result = lv1_get_version_info(&v->raw);
+	*v = ps3_firmware_version;
+}
+EXPORT_SYMBOL_GPL(ps3_get_firmware_version);
 
-	if (result) {
-		v->raw = 0;
-		return -1;
-	}
+int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
+{
+	union ps3_firmware_version x;
+
+	x.pad = 0;
+	x.major = major;
+	x.minor = minor;
+	x.rev = rev;
 
-	return result;
+	return (ps3_firmware_version.raw - x.raw);
 }
-EXPORT_SYMBOL_GPL(ps3_get_firmware_version);
+EXPORT_SYMBOL_GPL(ps3_compare_firmware_version);
 
 static void ps3_power_save(void)
 {
@@ -146,13 +154,13 @@ static int ps3_set_dabr(u64 dabr)
 
 static void __init ps3_setup_arch(void)
 {
-	union ps3_firmware_version v;
 
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
-	ps3_get_firmware_version(&v);
-	printk(KERN_INFO "PS3 firmware version %u.%u.%u\n", v.major, v.minor,
-		v.rev);
+	lv1_get_version_info(&ps3_firmware_version.raw);
+	printk(KERN_INFO "PS3 firmware version %u.%u.%u\n",
+	       ps3_firmware_version.major, ps3_firmware_version.minor,
+	       ps3_firmware_version.rev);
 
 	ps3_spu_set_platform();
 	ps3_map_htab();
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -35,7 +35,8 @@ union ps3_firmware_version {
 	};
 };
 
-int ps3_get_firmware_version(union ps3_firmware_version *v);
+void ps3_get_firmware_version(union ps3_firmware_version *v);
+int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev);
 
 /* 'Other OS' area */
 

-- 
