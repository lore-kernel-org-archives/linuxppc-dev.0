Date: Thu, 14 Oct 1999 11:18:29 -0400
From: "Peter A. Padilla" <p.a.padilla@larc.nasa.gov>
To: linuxppc-dev@lists.linuxppc.org, Damir Buskulic <buskulic@lapp.in2p3.fr>,
        "The Dark Bard"@goog.larc.nasa.gov
Subject: Macally mouse patch
Message-ID: <19991014111829.A1327@goog.larc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


<poetman@bookastudios.com>
Cc: 
Bcc: 
Subject: Macally mouse code
Reply-To: "Peter A. Padilla" <p.a.padilla@larc.nasa.gov>
In-Reply-To: 

I received many requests for the patch to get the macally mouse to work
without the mousemode command and to emulate the third button. The emulation
is not perfect, depending on the application you might have to press both
buttons almost simultaneously. I will try to provide a more robust
emulation eventually.

Here is the patch for "mac_keyb.c" in drivers/macintosh:

270a271
> #define ADBMOUSE_MACALLY	8	/* Macally mouse  */
514a516,523
> 	   case ADBMOUSE_MACALLY:
> 		/* Emulate third button, use xmodmap to assign */
> 		data[3] = (data[1] & 0x80) | (data[2] & 0x80) | 0x08;
> 		if ((data[3] & 0x80) == 0x00) {
> 		  data[2] = (data[2] & 0x7f) | 0x80;
> 		  data[1] = (data[1] & 0x7f) | 0x80;
> 		}
> 		break; 
753a763,767
> 	/* Changed the order from the specific to more general, also
> 	 * added new code for Macally mouse and, in order for the second
> 	 * button to be enabled it needs to be set to handler 66 (0x42)
> 	 * but it won't accept that handler unless it has been set to
> 	 * handler 4 first. */
756,762c770,772
< 		if (adb_try_handler_change(id, 4)) {
< 			printk("ADB mouse at %d, handler set to 4", id);
< 			adb_mouse_kinds[id] = ADBMOUSE_EXTENDED;
< 		}
< 		else if (adb_try_handler_change(id, 2)) {
< 			printk("ADB mouse at %d, handler set to 2", id);
< 			adb_mouse_kinds[id] = ADBMOUSE_STANDARD_200;
---
> 		if (adb_try_handler_change(id, 0x5F)) {
> 			printk("ADB mouse at %d, handler set to 0x5F", id);
> 			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
767a778,781
> 		else if (adb_try_handler_change(id, 0x66)) {
> 			printk("ADB mouse at %d, handler set to 0x66", id);
> 			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
> 		}
772,774c786,789
< 		else if (adb_try_handler_change(id, 0x66)) {
< 			printk("ADB mouse at %d, handler set to 0x66", id);
< 			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
---
> 		else if (adb_try_handler_change(id, 4) &&
> 		         adb_try_handler_change(id, 0x42)) {
> 			printk("ADB mouse at %d, handler set to 0x42", id);
> 			adb_mouse_kinds[id] = ADBMOUSE_MACALLY;
776,778c791,797
< 		else if (adb_try_handler_change(id, 0x5F)) {
< 			printk("ADB mouse at %d, handler set to 0x5F", id);
< 			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
---
> 		else if (adb_try_handler_change(id, 4)) {
> 			printk("ADB mouse at %d, handler set to 4", id);
> 			adb_mouse_kinds[id] = ADBMOUSE_EXTENDED;
> 		}
>    		else if (adb_try_handler_change(id, 2)) {
> 			printk("ADB mouse at %d, handler set to 2", id);
> 			adb_mouse_kinds[id] = ADBMOUSE_STANDARD_200;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
