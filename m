Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 622E2DDEC1
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 09:54:22 +1100 (EST)
Message-ID: <47ACDD2E.6010607@am.sony.com>
Date: Fri, 08 Feb 2008 14:52:30 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 1/6] PS3: Fix lpm set bookmark
References: <20080208224723.029462363@am.sony.com>
In-Reply-To: <20080208224723.029462363@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>

Fix the ps3_set_bookmark() routine of the PS3 logical performance
monitor driver.

To properly set a performance monitor bookmark the Cell processor
requires no instruction branches near the setting of the bookmark
SPR.  Testing showed that the use of the db10cyc instruction did
not work correctly.  This change replaces the db10cyc instruction
with 10 nop instructions.

Signed-off-by: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-lpm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -181,9 +181,9 @@ void ps3_set_bookmark(u64 bookmark)
 	 * includes cycles before the call.
 	 */
 
-	asm volatile("or 29, 29, 29;"); /* db10cyc */
+	asm volatile("nop;nop;nop;nop;nop;nop;nop;nop;nop;");
 	mtspr(SPRN_BKMK, bookmark);
-	asm volatile("or 29, 29, 29;"); /* db10cyc */
+	asm volatile("nop;nop;nop;nop;nop;nop;nop;nop;nop;");
 }
 EXPORT_SYMBOL_GPL(ps3_set_bookmark);
 

-- 
