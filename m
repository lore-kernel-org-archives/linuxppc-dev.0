Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 08/15] ps3: Only prealloc the flash bounce buffer for the
	OtherOS lpar
Date: Mon,  1 Aug 2011 22:02:59 +0200
Message-Id: <1312228986-32307-9-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
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

It's only used by the ps3flash driver, which only supports the
OtherOS lpar.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/platforms/ps3/setup.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index f430279..923be8a 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -233,7 +233,10 @@ static void __init ps3_setup_arch(void)
 #endif
 
 	prealloc_ps3fb_videomemory();
-	prealloc_ps3flash_bounce_buffer();
+
+	/* the ps3flash driver only works for OtherOS */
+	if (ps3_get_ss_laid() == PS3_SS_LAID_OTHEROS)
+		prealloc_ps3flash_bounce_buffer();
 
 	ppc_md.power_save = ps3_power_save;
 	ps3_os_area_init();
-- 
1.7.5.4
