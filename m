Message-ID: <3C5EDC64.9050405@cymes.de>
Date: Mon, 04 Feb 2002 20:09:24 +0100
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] Superflous code in mac_hid.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

The following patch deletes some code lines in mac_hid.c which were from
my point of view an copy-&-paste artefact from char/pc_keyb.c.

--- drivers/macintosh/mac_hid.c.orig	Thu Feb  4 01:06:49 1904
+++ drivers/macintosh/mac_hid.c	Mon Feb  4 12:10:30 2002
@@ -363,11 +363,9 @@

			prev_scancode = 0;

			return 0;

		}
-
		} else {
+
		} else

		prev_scancode = 0;
-
			if (scancode == 0x2a || scancode == 0x36)
-
				return 0;
-
		}
+

	if (e0_keys[scancode])

		*keycode = e0_keys[scancode];

	else {
----------------
The code is only nessecary to fix a misbehaviour of a special pc
keyboard as described in char/pc_keyb.c. I think it's not relevant
for macintosh computers.

The reason to delete this lines is that two scancodes can't be used.
I found this problem, as I tried to assign the Keycode 209 to the Fn-Key
for test purposes. After all translations and mappings the key sequence
0xe0 0x36 was generated and quashed by this code lines.

This is a low priority and temporary patch (until the new input device is
fully integrated in the kernel), but temporary solutions mostly have
incredible livespans. ;-)

Kind regards
   Matthias Grimm


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
