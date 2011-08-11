Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH part1 v2 7/9] ps3: Log the detected lpar on startup
Date: Thu, 11 Aug 2011 21:31:11 +0200
Message-Id: <1313091073-4572-8-git-send-email-a.heider@gmail.com>
In-Reply-To: <1313091073-4572-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PS3_SS_LAID_GAMEOS to enum ps3_ss_laid.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/include/asm/ps3.h     |    1 +
 arch/powerpc/platforms/ps3/setup.c |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index 9e8c878..136354a 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -40,6 +40,7 @@ void ps3_get_firmware_version(union ps3_firmware_version *v);
 int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev);
 
 enum ps3_ss_laid {
+	PS3_SS_LAID_GAMEOS = 0x1070000002000001UL,
 	PS3_SS_LAID_OTHEROS = 0x1080000004000001UL,
 };
 
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 9f23a6d..1239059 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -199,6 +199,7 @@ static int ps3_set_dabr(unsigned long dabr)
 
 static void __init ps3_setup_arch(void)
 {
+	const char *laid_str;
 
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
@@ -208,6 +209,18 @@ static void __init ps3_setup_arch(void)
 	       ps3_firmware_version.rev);
 
 	ps3_repository_read_ss_laid(&ps3_ss_laid);
+	switch (ps3_ss_laid) {
+	case PS3_SS_LAID_GAMEOS:
+		laid_str = "GameOS";
+		break;
+	case PS3_SS_LAID_OTHEROS:
+		laid_str = "OtherOS";
+		break;
+	default:
+		laid_str = "unknown";
+		break;
+	}
+	printk(KERN_INFO "Running in %s LPAR\n", laid_str);
 
 	ps3_spu_set_platform();
 
-- 
1.7.5.4
