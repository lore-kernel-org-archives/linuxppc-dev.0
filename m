Return-Path: <k0da@opensuse.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5090D1A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 23:30:12 +1000 (AEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 36D71AC66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:30:09 +0000 (UTC)
From: Dinar valeev <k0da@opensuse.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Dinar Valeev <dvaleev@suse.com>
Subject: [PATCH] Fix function keys sequence on USB
Date: Fri, 29 May 2015 15:30:01 +0200
Message-Id: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dinar Valeev <dvaleev@suse.com>

Original issue is home and end keys are not functional in grub2.
Later I've found other inconsistencies in f1-f12 keys.

"Correct sequence" was crabbed by pressing key on cat running in
xterm.

Tested with Home, End, F2, Del and F10 keys in grub2

Signed-off-by: Dinar Valeev <dvaleev@suse.com>
---
 lib/libusb/usb-hid.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/lib/libusb/usb-hid.c b/lib/libusb/usb-hid.c
index f0cab8a..ccd5ba9 100644
--- a/lib/libusb/usb-hid.c
+++ b/lib/libusb/usb-hid.c
@@ -190,33 +190,29 @@ static void check_key_code(uint8_t *buf)
 				case 0x3a:	                        /* F1 */
 					write_key(0x1b);
 					write_key(0x5b);
-					write_key(0x31);
-					write_key(0x31);
-					write_key(0x7e);
+					write_key(0x4f);
+					write_key(0x50);
 					break;
 
 				case 0x3b:		                /* F2 */
 					write_key(0x1b);
 					write_key(0x5b);
-					write_key(0x31);
-					write_key(0x32);
-					write_key(0x7e);
+					write_key(0x4f);
+					write_key(0x51);
 					break;
 
 				case 0x3c:
 					write_key(0x1b);               /* F3 */
 					write_key(0x5b);
-					write_key(0x31);
-					write_key(0x33);
-					write_key(0x7e);
+					write_key(0x4f);
+					write_key(0x52);
 					break;
 
 				case 0x3d:
 					write_key(0x1b);		/* F4 */
 					write_key(0x5b);
-					write_key(0x31);
-					write_key(0x34);
-					write_key(0x7e);
+					write_key(0x4f);
+					write_key(0x53);
 					break;
 
 				case 0x3e:
@@ -254,7 +250,7 @@ static void check_key_code(uint8_t *buf)
 				case 0x42:
 					write_key(0x1b);		/* F9 */
 					write_key(0x5b);
-					write_key(0x31);
+					write_key(0x32);
 					write_key(0x30);
 					write_key(0x7e);
 					break;
@@ -262,7 +258,7 @@ static void check_key_code(uint8_t *buf)
 				case 0x43:
 					write_key(0x1b);	       /* F10 */
 					write_key(0x5b);
-					write_key(0x31);
+					write_key(0x32);
 					write_key(0x31);
 					write_key(0x7e);
 					break;
@@ -270,7 +266,7 @@ static void check_key_code(uint8_t *buf)
 				case 0x44:
 					write_key(0x1b);	       /* F11 */
 					write_key(0x5b);
-					write_key(0x31);
+					write_key(0x32);
 					write_key(0x33);
 					write_key(0x7e);
 					break;
@@ -278,7 +274,7 @@ static void check_key_code(uint8_t *buf)
 				case 0x45:
 					write_key(0x1b);	       /* F12 */
 					write_key(0x5b);
-					write_key(0x31);
+					write_key(0x32);
 					write_key(0x34);
 					write_key(0x7e);
 					break;
@@ -290,36 +286,34 @@ static void check_key_code(uint8_t *buf)
 				case 0x49:
 					write_key(0x1b);	       /* INS */
 					write_key(0x5b);
-					write_key(0x31);
+					write_key(0x32);
 					write_key(0x7e);
 					break;
 
 				case 0x4a:
 					write_key(0x1b);	      /* HOME */
 					write_key(0x5b);
-					write_key(0x32);
-					write_key(0x7e);
+					write_key(0x48);
 					break;
 
 				case 0x4b:
 					write_key(0x1b);	      /* PgUp */
 					write_key(0x5b);
-					write_key(0x33);
+					write_key(0x35);
 					write_key(0x7e);
 					break;
 
 				case 0x4c:
 					write_key(0x1b);	       /* DEL */
 					write_key(0x5b);
-					write_key(0x34);
+					write_key(0x33);
 					write_key(0x7e);
 					break;
 
 				case 0x4d:
 					write_key(0x1b);	       /* END */
 					write_key(0x5b);
-					write_key(0x35);
-					write_key(0x7e);
+					write_key(0x46);
 					break;
 
 				case 0x4e:
-- 
2.1.4
