Message-ID: <3A25DC44.FD584E71@denise.shiny.it>
Date: Wed, 29 Nov 2000 23:49:08 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] sysrq (2.2.18-pre23)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sysrq support doesn't compile without this patch:




--- drivers/macintosh/mac_hid.old	Wed Nov 29 23:44:07 2000
+++ drivers/macintosh/mac_hid.c	Tue Nov 28 22:58:35 2000
@@ -293,14 +293,14 @@
 	    && keyboard_sends_linux_keycodes != val) {
 		if (!keyboard_sends_linux_keycodes) {
 #ifdef CONFIG_MAGIC_SYSRQ
-			ppc_md.ppc_kbd_sysrq_xlate   = mac_hid_kbd_sysrq_xlate;
+			ppc_md.sysrq_xlate   = mac_hid_kbd_sysrq_xlate;
 			SYSRQ_KEY                = 0x69;
 #endif
 			memcpy(pc_key_maps_save, key_maps, sizeof(key_maps));
 			memcpy(key_maps, mac_key_maps_save, sizeof(key_maps));
 		} else {
 #ifdef CONFIG_MAGIC_SYSRQ
-			ppc_md.ppc_kbd_sysrq_xlate   = pckbd_sysrq_xlate;
+			ppc_md.sysrq_xlate   = pckbd_sysrq_xlate;
 			SYSRQ_KEY                = 0x54;
 #endif
 			memcpy(mac_key_maps_save, key_maps, sizeof(key_maps));


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
