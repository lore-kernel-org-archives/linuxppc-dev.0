Date: Sat, 4 Mar 2000 19:18:19 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Paul Mackerras <paulus@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch to fix imps2 emulation for usb mice in stable 2.2.X series
In-Reply-To: <00030409183800.00482@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10003041853430.15981-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Will you please install this patch into the 2.2.X stable kernel series?  It
> will make our imps2 usb mouse properly follow the conventions for imps2 mice
> and make it more like what the 2.3.XX kernels are doing right now

You remind me of another USB mouse issue I stumbled on with 2.2.15: I had
happily set up X to use the USB mouse as secondary mouse in the Xinput
section for some time, when suddenly 2.2.15 changed the USB mouse
behavior. All USB mouse clicks were doubled or tripled ...

Just feeding USB mouse events to ADB might seem like a cute hack, but what
happens if somebody actually opens the USB mouse device (horror) and wants
to feed mouse events to X for his own purpose ? This patch makes the hack
a config option; what's missing is a test to determine whether the mouse
device has already been opened, so we get redirection of mouse events to
ADB as long as the mouse isn't in use for something else. mouse->active=1
is already used to enable the hack, so we probably need to check for
mouse->active < 2 before calling adb_mouse_interrupt (haven't tested
that).

Works For Me (tm) with XFree 3.3.3.1 ...

	Michael

--- drivers/usb/mouse.c.org	Wed Mar  1 13:59:15 2000
+++ drivers/usb/mouse.c	Sat Mar  4 18:52:31 2000
@@ -117,7 +117,7 @@
 	if (mouse->fasync)
 		kill_fasync(mouse->fasync, SIGIO, POLL_IN);

-#ifdef CONFIG_ADBMOUSE
+#ifdef CONFIG_USB_ADBMOUSE
 	/* XXX send the movement/buttons to the ADB mouse code as well */
 	{
 		extern void adb_mouse_interrupt(unsigned char *, int);
@@ -130,7 +130,7 @@
 		buf[3] = ((~data[0] << 6) & 0x80);
 		adb_mouse_interrupt(buf, 4);
 	}
-#endif /* CONFIG_ADBMOUSE */
+#endif /* CONFIG_USB_ADBMOUSE */

 	return 1;
 }
@@ -418,11 +418,11 @@

 	printk(KERN_INFO "USB HID boot protocol mouse driver registered.\n");

-#ifdef CONFIG_ADBMOUSE
+#ifdef CONFIG_USB_ADBMOUSE
 	/* make the mouse(s) work as an adb mouse even when
 	   the usb mouse device isn't open */
 	mouse->active = 1;
-#endif /* CONFIG_ADBMOUSE */
+#endif /* CONFIG_USB_ADBMOUSE */

 	return 0;
 }
--- drivers/usb/Config.in.org	Sat Mar  4 18:51:42 2000
+++ drivers/usb/Config.in	Sat Mar  4 18:51:30 2000
@@ -31,6 +31,9 @@
 comment 'USB Devices'
    dep_tristate '  USB hub support (Required!)' CONFIG_USB_HUB $CONFIG_USB
    dep_tristate '  USB mouse support' CONFIG_USB_MOUSE $CONFIG_USB
+   if [ "$CONFIG_USB_MOUSE" != "n" -a "$CONFIG_ADBMOUSE" != "n" ]; then
+      bool '    Feed USB mouse packets to ADB mouse driver?' CONFIG_USB_ADBMOUSE
+   fi
    dep_tristate '  USB HP scanner support' CONFIG_USB_HP_SCANNER $CONFIG_USB
    dep_tristate '  USB keyboard support' CONFIG_USB_KBD $CONFIG_USB
    dep_tristate '  USB Audio support' CONFIG_USB_AUDIO $CONFIG_USB

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
