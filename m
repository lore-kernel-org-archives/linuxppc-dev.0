Return-Path: <k0da@opensuse.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9101E1A1D4B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 02:47:58 +1000 (AEST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 215D01402B2
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 02:47:57 +1000 (AEST)
From: Dinar valeev <k0da@opensuse.org>
To: linuxppc-dev@ozlabs.org, aik@ozlabs.ru, nikunj@linux.vnet.ibm.com,
 thuth@redhat.com
Cc: Dinar Valeev <dvaleev@suse.com>
Subject: [PATCH v2] Caps in not always shift
Date: Wed,  8 Jul 2015 18:47:44 +0200
Message-Id: <1436374064-4116-1-git-send-email-k0da@opensuse.org>
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
 lib/libusb/usb-hid.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/lib/libusb/usb-hid.c b/lib/libusb/usb-hid.c
index f0cab8a..18210ae 100644
--- a/lib/libusb/usb-hid.c
+++ b/lib/libusb/usb-hid.c
@@ -28,6 +28,10 @@
 #define HID_REQ_SET_IDLE                0x0A
 #define HID_REQ_SET_PROTOCOL            0x0B
 
+//key position for latin letters
+#define KEYP_LATIN_A 4
+#define KEYP_LATIN_Z 29
+
 //#define KEY_DEBUG
 
 /* HID SPEC - 7.2.6 Set_Protocol Request */
@@ -83,6 +87,8 @@ uint8_t set_leds;
 const uint8_t *key_std       = NULL;
 const uint8_t *key_std_shift = NULL;
 
+uint8_t ctrl; /* modifiers */
+
 /**
  * read character from Keyboard-Buffer
  *
@@ -111,6 +117,18 @@ static void write_key(uint8_t key)
 }
 
 /**
+ * Checks if keypos is a latin key
+ * @param  keypos
+ * @return -
+ */
+void check_latin(uint8_t keypos)
+	if (keypos > KEYP_LATIN_A || keypos < KEYP_LATIN_Z) {
+		return true;
+	} else {
+		return false;
+	}
+
+/**
  * Convert keyboard usage-ID to ANSI-Code
  *
  * @param   Ctrl=Modifier Byte
@@ -120,22 +138,24 @@ static void write_key(uint8_t key)
 static void get_char(uint8_t ctrl, uint8_t keypos)
 {
 	uint8_t ch;
+	bool caps = false;
 
 #ifdef KEY_DEBUG
 	printf("pos %02X\n", keypos);
 #endif
 
 	if (set_leds & LED_CAPS_LOCK)	                /* is CAPS Lock set ? */
-		ctrl |= MODIFIER_SHIFT;	                    /* simulate shift */
+		caps = true;
 
-	if (ctrl == 0) {
+	/* caps is a shift only for latin chars */
+	if ((!caps && ctrl == 0) || (caps && !check_latin(keypos))) {
 		ch = key_std[keypos];
 		if (ch != 0)
 			write_key(ch);
 		return;
 	}
 
-	if (ctrl & MODIFIER_SHIFT) {
+	if ((ctrl & MODIFIER_SHIFT) || caps) {
 		ch = key_std_shift[keypos];
 		if (ch != 0)
 			write_key(ch);
@@ -187,6 +207,12 @@ static void check_key_code(uint8_t *buf)
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
