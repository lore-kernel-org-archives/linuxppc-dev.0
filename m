Return-Path: <mokuno@sm.sony.co.jp>
Received: from ns8.sony.co.jp (NS8.Sony.CO.JP [137.153.0.33])
	by ozlabs.org (Postfix) with ESMTP id EE287DDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 21:31:08 +1000 (EST)
Date: Wed, 29 Aug 2007 20:30:25 +0900
From: Masakazu Mokuno <mokuno@sm.sony.co.jp>
To: paulus@samba.org
Subject: [PATCH] PS3: fix the bug the major version part is not compared, take2
Message-Id: <20070829202823.C2E8.MOKUNO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the bug that the major version part of the firmware 
is not compared.

Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
CC: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/setup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -63,7 +63,8 @@ int ps3_compare_firmware_version(u16 maj
 	x.minor = minor;
 	x.rev = rev;
 
-	return (ps3_firmware_version.raw - x.raw);
+	return (ps3_firmware_version.raw > x.raw) -
+	       (ps3_firmware_version.raw < x.raw);
 }
 EXPORT_SYMBOL_GPL(ps3_compare_firmware_version);
 
--
Masakazu MOKUNO
