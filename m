Return-Path: <k0da@opensuse.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30A9C1A071F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 19:58:36 +1000 (AEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A7617AC20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:58:32 +0000 (UTC)
From: Dinar valeev <k0da@opensuse.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Dinar Valeev <dvaleev@suse.com>
Subject: [PATCH] Caps in not always shift
Date: Fri, 29 May 2015 11:58:23 +0200
Message-Id: <1432893503-19197-1-git-send-email-k0da@opensuse.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dinar Valeev <dvaleev@suse.com>

Caps behaves like shift only for latin characters.
In case we're typing - for example with caps enabled, SLOF picks _ char
from shifted table.

Threat caps as shift only for letters.

Signed-off-by: Dinar Valeev <dvaleev@suse.com>
---
 lib/libusb/usb-hid.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/libusb/usb-hid.c b/lib/libusb/usb-hid.c
index f0cab8a..9e14cf5 100644
--- a/lib/libusb/usb-hid.c
+++ b/lib/libusb/usb-hid.c
@@ -83,6 +83,8 @@ uint8_t set_leds;
 const uint8_t *key_std       = NULL;
 const uint8_t *key_std_shift = NULL;
 
+uint8_t ctrl; /* modifiers */
+
 /**
  * read character from Keyboard-Buffer
  *
@@ -120,22 +122,27 @@ static void write_key(uint8_t key)
 static void get_char(uint8_t ctrl, uint8_t keypos)
 {
 	uint8_t ch;
+	int caps = 0;
+//key position for latin letters
+#define KEYP_LATIN_A 4
+#define KEYP_LATIN_Z 29
 
 #ifdef KEY_DEBUG
 	printf("pos %02X\n", keypos);
 #endif
 
 	if (set_leds & LED_CAPS_LOCK)	                /* is CAPS Lock set ? */
-		ctrl |= MODIFIER_SHIFT;	                    /* simulate shift */
+		caps = 1;
 
-	if (ctrl == 0) {
+	/* caps is a shift only for latin chars */
+	if ((caps == 0 && ctrl == 0) || (caps == 1 && (keypos < KEYP_LATIN_A || keypos > KEYP_LATIN_Z))) {
 		ch = key_std[keypos];
 		if (ch != 0)
 			write_key(ch);
 		return;
 	}
 
-	if (ctrl & MODIFIER_SHIFT) {
+	if ((ctrl & MODIFIER_SHIFT) || caps == 1) {
 		ch = key_std_shift[keypos];
 		if (ch != 0)
 			write_key(ch);
@@ -187,6 +194,12 @@ static void check_key_code(uint8_t *buf)
 					set_leds ^= LED_CAPS_LOCK;
 					break;
 
+				case 0x36:		                /*Shift pressed*/
+					ctrl |= MODIFIER_SHIFT;
+					break;
+				case 0xb6:		                /*Shift unpressed*/
+					ctrl &= ~MODIFIER_SHIFT;
+					break;
 				case 0x3a:	                        /* F1 */
 					write_key(0x1b);
 					write_key(0x5b);
-- 
2.1.4
