Message-ID: <3C5EE8D9.1000408@cymes.de>
Date: Mon, 04 Feb 2002 21:02:33 +0100
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] PowerBook button device control back to user space
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

The following patch removes a unlucky shortcut from keyboard device to the PMU backlight
device from the kernel and gives control back to user space.

The Apple PowerBooks have a special button device to control special functions like
display brightness, speaker volume, etc. The Keys for volume control generate keycodes,
which were sent to user space. The keys for controlling the display brightness were
directly handled by the kernel. This is not consequent and additionally an unlucky
cross reference between different and independent parts of the kernel.

Due to the existance of multiply sound systems, it would be very annoying to put all
the volume control features into the kernel like the brightness control and at the end
the user still hasn't any visual feedback during his volumem/brightness adjustments.

So I suggest to remove the direct handling of the display brightness from the kernel.
The correspondent keys should also send key codes to user space and allow a user space
programm to get into control. It could react more flexible to users needs and disburden
the kernel from secondary jobs.

I could provide a first release of this user space program to control all PowerBook
special keys including visual feedback. (under GPL)

My patch only concerns the new adbhid driver. In the old macintosh keyboard driver the
button device keys can't be assigned to scancodes, because there are none free. So in
this driver I keep the direct control of the backlight device because it is better
than nothing.

The patch based on kernel 2.4.16-benh but work straight forward with 2.4.18-pre7-benh0.

Kind regards
   Matthias Grimm


diff -urN -X dontdiff kernel-2.4.16-benh/drivers/macintosh/adbhid.c kernel-2.4.16-mgr/drivers/macintosh/adbhid.c
--- kernel-2.4.16-benh/drivers/macintosh/adbhid.c	Tue Nov 27 00:07:02 2001
+++ kernel-2.4.16-mgr/drivers/macintosh/adbhid.c	Mon Feb  4 12:20:58 2002
@@ -42,9 +42,6 @@
  #include <linux/adb.h>
  #include <linux/cuda.h>
  #include <linux/pmu.h>
-#ifdef CONFIG_PMAC_BACKLIGHT
-#include <asm/backlight.h>
-#endif

  MODULE_AUTHOR("Franz Sirl <Franz.Sirl-kernel@lauterbach.com>");

@@ -274,9 +271,7 @@
  	case 0x1f: /* Powerbook button device */
  	  {
  	  	int down = (data[1] == (data[1] & 0xf));
-#ifdef CONFIG_PMAC_BACKLIGHT
-
	int backlight = get_backlight_level();
-#endif
+
  		/*
  		 * XXX: Where is the contrast control for the passive?
  		 *  -- Cort
@@ -284,44 +279,28 @@

  		switch (data[1] & 0x0f) {
  		case 0x8:	/* mute */
-
		input_report_key(&adbhid[id]->input, KEY_MUTE,
-
			data[1] == (data[1] & 0xf));
+
		input_report_key(&adbhid[id]->input, KEY_MUTE, down);

	break;

  		case 0x7:	/* volume decrease */
-
		input_report_key(&adbhid[id]->input, KEY_VOLUMEDOWN,
-
			data[1] == (data[1] & 0xf));
+
		input_report_key(&adbhid[id]->input, KEY_VOLUMEDOWN, down);

	break;

  		case 0x6:	/* volume increase */
-
		input_report_key(&adbhid[id]->input, KEY_VOLUMEUP,
-
			data[1] == (data[1] & 0xf));
+
		input_report_key(&adbhid[id]->input, KEY_VOLUMEUP, down);
   			break;

  		case 0xb:	/* eject */
-
		input_report_key(&adbhid[id]->input, KEY_EJECTCD,
-
			data[1] == (data[1] & 0xf));
+
		input_report_key(&adbhid[id]->input, KEY_EJECTCD, down);

	break;

-#ifdef CONFIG_PMAC_BACKLIGHT
  		case 0xa:	/* brightness decrease */
-
		if (!down || backlight < 0)
-
			break;
-
		if (backlight > BACKLIGHT_OFF)
-
			set_backlight_level(backlight-1);
-
		else
-
			set_backlight_level(BACKLIGHT_OFF);
+
		input_report_key(&adbhid[id]->input, KEY_BRIGHTNESSDOWN, down);

	break;

  		case 0x9:	/* brightness increase */
-
		if (!down || backlight < 0)
-
			break;
-
		if (backlight < BACKLIGHT_MAX)
-
			set_backlight_level(backlight+1);
-
		else
-
			set_backlight_level(BACKLIGHT_MAX);
+
		input_report_key(&adbhid[id]->input, KEY_BRIGHTNESSUP, down);

	break;
-#endif /* CONFIG_PMAC_BACKLIGHT */
  		}
  	  }
  	  break;
@@ -521,6 +500,8 @@

	set_bit(KEY_MUTE, adbhid[id]->input.keybit);

	set_bit(KEY_VOLUMEUP, adbhid[id]->input.keybit);

	set_bit(KEY_VOLUMEDOWN, adbhid[id]->input.keybit);
+
		set_bit(KEY_BRIGHTNESSUP, adbhid[id]->input.keybit);
+
		set_bit(KEY_BRIGHTNESSDOWN, adbhid[id]->input.keybit);

	set_bit(KEY_EJECTCD, adbhid[id]->input.keybit);

	break;
  		}
diff -urN -X dontdiff kernel-2.4.16-benh/drivers/macintosh/mac_hid.c kernel-2.4.16-mgr/drivers/macintosh/mac_hid.c
--- kernel-2.4.16-benh/drivers/macintosh/mac_hid.c	Thu Feb  4 01:06:49 1904
+++ kernel-2.4.16-mgr/drivers/macintosh/mac_hid.c	Mon Feb  4 12:06:53 2002
@@ -204,7 +204,7 @@
  	0, 0, 0, 0, 0, KEY_VOLUMEDOWN, KEY_MUTE, 0,		/* 0x20-0x27 */
  	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x28-0x2f */
  	0, 0, 0, 0, 0, KEY_KPSLASH, 0, KEY_SYSRQ,		/* 0x30-0x37 */
-
KEY_RIGHTALT, 0, 0, KEY_EJECTCD, 0, 0, 0, 0,		/* 0x38-0x3f */
+
KEY_RIGHTALT, KEY_BRIGHTNESSUP, KEY_BRIGHTNESSDOWN, KEY_EJECTCD, 0, 0, 0, 0,		/* 0x38-0x3f */
  	0, 0, 0, 0, 0, 0, 0, KEY_HOME,				/* 0x40-0x47 */
  	KEY_UP, KEY_PAGEUP, 0, KEY_LEFT, 0, KEY_RIGHT, 0, KEY_END, /* 0x48-0x4f */
  	KEY_DOWN, KEY_PAGEDOWN, KEY_INSERT, KEY_DELETE, 0, 0, 0, 0, /* 0x50-0x57 */
diff -urN -X dontdiff kernel-2.4.16-benh/include/linux/input.h kernel-2.4.16-mgr/include/linux/input.h
--- kernel-2.4.16-benh/include/linux/input.h	Fri Nov 30 10:55:04 2001
+++ kernel-2.4.16-mgr/include/linux/input.h	Mon Feb  4 11:55:33 2002
@@ -305,6 +305,9 @@
  #define KEY_SUSPEND		205
  #define KEY_CLOSE		206

+#define KEY_BRIGHTNESSUP	210
+#define KEY_BRIGHTNESSDOWN	211
+
  #define KEY_UNKNOWN		220

  #define BTN_MISC		0x100

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
