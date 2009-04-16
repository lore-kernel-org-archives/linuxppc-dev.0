Return-Path: <geoff@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B00A7DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:27:09 +1000 (EST)
Message-Id: <20090416190536.684970903@am.sony.com>>
References: <20090416190536.540992667@am.sony.com>>
In-Reply-To: <20090416190536.540992667@am.sony.com>>
Date: Thu, 16 Apr 2009 12:05:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 2/4] powerpc/ps3: Fix no flash build warning
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix build warnings like these when CONFIG_PS3_FLASH=n:

  arch/powerpc/platforms/ps3/os-area.c: warning: 'update_flash_db' defined but not used

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -578,7 +578,7 @@ static void os_area_db_init(struct os_ar
  *
  */
 
-static void update_flash_db(void)
+static void __maybe_unused update_flash_db(void)
 {
 	int result;
 	int file;

-- 
