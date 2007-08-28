Return-Path: <mokuno@sm.sony.co.jp>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id DF8B2DDF8E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 22:32:56 +1000 (EST)
Date: Tue, 28 Aug 2007 21:32:29 +0900
From: Masakazu Mokuno <mokuno@sm.sony.co.jp>
To: paulus@samba.org
Subject: [PATCH] PS3: fix the bug the major version part is not compared
Message-Id: <20070828211415.C2B5.MOKUNO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
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
 arch/powerpc/platforms/ps3/setup.c |    2 +-
 include/asm-powerpc/ps3.h          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -54,7 +54,7 @@ void ps3_get_firmware_version(union ps3_
 }
 EXPORT_SYMBOL_GPL(ps3_get_firmware_version);
 
-int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
+s64 ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
 {
 	union ps3_firmware_version x;
 
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -36,7 +36,7 @@ union ps3_firmware_version {
 };
 
 void ps3_get_firmware_version(union ps3_firmware_version *v);
-int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev);
+s64 ps3_compare_firmware_version(u16 major, u16 minor, u16 rev);
 
 /* 'Other OS' area */
 

--
Masakazu MOKUNO
