Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AA4C1A0214
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:56:43 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/boot: drop planetcore_set_serial_speed
Date: Mon, 16 Feb 2015 17:56:25 +0700
Message-Id: <1424084188-17097-2-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop planetcore_set_serial_speed() which had no users since its inception.

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 arch/powerpc/boot/planetcore.c | 33 ---------------------------------
 arch/powerpc/boot/planetcore.h |  3 ---
 2 files changed, 36 deletions(-)

diff --git a/arch/powerpc/boot/planetcore.c b/arch/powerpc/boot/planetcore.c
index 0d8558a..75117e6 100644
--- a/arch/powerpc/boot/planetcore.c
+++ b/arch/powerpc/boot/planetcore.c
@@ -131,36 +131,3 @@ void planetcore_set_stdout_path(const char *table)
 
 	setprop_str(chosen, "linux,stdout-path", path);
 }
-
-void planetcore_set_serial_speed(const char *table)
-{
-	void *chosen, *stdout;
-	u64 baud;
-	u32 baud32;
-	int len;
-
-	chosen = finddevice("/chosen");
-	if (!chosen)
-		return;
-
-	len = getprop(chosen, "linux,stdout-path", prop_buf, MAX_PROP_LEN);
-	if (len <= 0)
-		return;
-
-	stdout = finddevice(prop_buf);
-	if (!stdout) {
-		printf("planetcore_set_serial_speed: "
-		       "Bad /chosen/linux,stdout-path.\r\n");
-
-		return;
-	}
-
-	if (!planetcore_get_decimal(table, PLANETCORE_KEY_SERIAL_BAUD,
-	                            &baud)) {
-		printf("planetcore_set_serial_speed: No SB tag.\r\n");
-		return;
-	}
-
-	baud32 = baud;
-	setprop(stdout, "current-speed", &baud32, 4);
-}
diff --git a/arch/powerpc/boot/planetcore.h b/arch/powerpc/boot/planetcore.h
index 0d4094f..d53c733 100644
--- a/arch/powerpc/boot/planetcore.h
+++ b/arch/powerpc/boot/planetcore.h
@@ -43,7 +43,4 @@ void planetcore_set_mac_addrs(const char *table);
  */
 void planetcore_set_stdout_path(const char *table);
 
-/* Sets the current-speed property in the serial node. */
-void planetcore_set_serial_speed(const char *table);
-
 #endif
-- 
2.3.0
