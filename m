Date: Wed, 6 Jan 1999 04:41:23 -0600
From: Kelly Campbell <camk@telecom.ksu.edu>
To: Konstantinos Margaritis <kmargar@cc.uoa.gr>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: MouseSystems MacoPoint Pro, 3 btn mouse
Message-ID: <19990106044123.C377@chippewa.telecom.ksu.edu>
References: <Pine.CVX.3.93.990106024359.12580B-100000@atlas.cc.uoa.gr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=da4uJneut+ArUgXk
In-Reply-To: <Pine.CVX.3.93.990106024359.12580B-100000@atlas.cc.uoa.gr>; from Konstantinos Margaritis on Wed, Jan 06, 1999 at 03:01:12AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii

On Wed, Jan 06, 1999 at 03:01:12AM +0200, Konstantinos Margaritis wrote:

> I have just bought this mouse, and while it works ok with the mac, I can't
> get it to work in linux (well, it works, but it doesn't use all 3
> buttons). Yes I know, I should get mousemode and do 'mousemode 15 3' or
> something like that, I did search the faq, but found no mention of this
> particular mouse. Problem is that I use Debian/PPC and the mousemode
> included (in package pmac-utils 1.1.1-1) seems to be old, or at least it
> works only with /dev/adb. As I use 2.1.131, the proper device
> is /dev/adbmouse and mousemode fails with an Input/Output Error.

What you need is the MacX kernel patch. I don't know who wrote it and I
can't find it by searching on the list archives (I tried real hard too),
so I guess I'll attach my most recent copy here. It works for my Mouse
Systems Pro just fine with no tweaking mousemode... just had to recompile
the kernel.

It'd be nice to have stuff like this in the FAQ's on linuxppc.org, and
also it'd be nice if someone could look at getting this into the cvs
kernel if it doesn't cause too many problems with other mice. 

Kelly
-- 
Kelly A. Campbell                       Applications Programmer/Analyst 
<camk@telecom.ksu.edu>  <camk@acm.org>  Kansas State University
http://www.telecom.ksu.edu/~camk/       Department of Telecommunications
109 East Stadium, Manhattan KS 66506    http://www.telecom.ksu.edu/
Voice: (785) 532-7067                   Fax: (785) 532-7114

--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=macx-patch-fb-19981022

diff -ru linux-pmac/arch/ppc/config.in linux-2.1.125/arch/ppc/config.in
--- linux-pmac/arch/ppc/config.in	Tue Oct 13 02:20:16 1998
+++ linux-2.1.125/arch/ppc/config.in	Thu Oct 22 20:58:25 1998
@@ -80,6 +80,7 @@
 bool 'Support for PowerMac floppy' CONFIG_MAC_FLOPPY
 bool 'Support for PowerMac serial ports' CONFIG_MAC_SERIAL
 bool 'Support for PowerMac ADB mouse' CONFIG_ADBMOUSE
+bool 'Support for PowerMac MacX 3 btn. mouse' CONFIG_MACX_MOUSE
 bool 'Support for Open Firmware device tree in /proc' CONFIG_PROC_DEVICETREE
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
diff -ru linux-pmac/drivers/macintosh/mac_keyb.c linux-2.1.125/drivers/macintosh/mac_keyb.c
--- linux-pmac/drivers/macintosh/mac_keyb.c	Sun Oct 11 17:32:52 1998
+++ linux-2.1.125/drivers/macintosh/mac_keyb.c	Thu Oct 22 21:03:11 1998
@@ -184,6 +184,11 @@
 
 extern int console_loglevel;
 
+#ifdef CONFIG_MACX_MOUSE
+/* DKH:9/98 -- Fake packet for the mouse data / also button state*/
+static unsigned char fake_mouse_packet[4] = { 0x3c, 0x80, 0x80, 0x80 };
+#endif /*CONFIG_MACX_MOUSE*/
+
 extern struct kbd_struct kbd_table[];
 extern struct wait_queue * keypress_wait;
 
@@ -246,13 +251,70 @@
 static void
 keyboard_input(unsigned char *data, int nb, struct pt_regs *regs, int apoll)
 {
+
+#ifdef CONFIG_MACX_MOUSE
+	/* Treat all ADB devices as _potential_ MacX mice,
+	   then determine later which ones aren't based on data */
+	/* XXX: Can 0 ever be a device? */
+	static char mice[16] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}; 
+	char button_state;
+	struct kbd_struct *kbd;
+	
+ 	kbd = kbd_table + fg_console;
+#endif
+
 	/* first check this is from register 0 */
 	if (nb != 3 || (data[0] & 3) != KEYB_KEYREG)
 		return;		/* ignore it */
+	
+#ifdef CONFIG_MACX_MOUSE
+    if ( !mice[ data[0]>>4 ]){ /* A _known_ keyboard */
+regular_keyboard:
+#endif
+
 	kbd_pt_regs = regs;
 	input_keycode(data[1], 0);
 	if (!(data[2] == 0xff || (data[2] == 0x7f && data[1] == 0x7f)))
 		input_keycode(data[2], 0);
+
+#ifdef CONFIG_MACX_MOUSE
+    } else { 
+	/* This _could_ be a MacX mouse.  If it is then send
+	   the data to the X server and possibly FB, else
+	   pass it back to the keyboard code and mark this
+	   device as a known keyboard.  (HACK) */
+	  
+	switch(data[1]){
+	case 0x3b:
+		fake_mouse_packet[2] = 0;
+		button_state = 0x3f;
+		break;
+	case 0xbb:
+		fake_mouse_packet[2] = 0x80;
+		button_state = 0xbf;
+		break;
+	case 0x3c:
+		fake_mouse_packet[3] = 0;
+		button_state = 0x40;
+		break;
+	case 0xbc:
+		fake_mouse_packet[3] = 0x80;
+		button_state = 0xc0;
+		break;
+	default:
+		mice[ data[0]>>4 ] = 0; /* Nope, not a mouse */
+		goto regular_keyboard;
+	}
+
+	/* XXX Wont this loose the first button state? */
+
+	if (adb_mouse_interrupt_hook) /* New style */
+		adb_mouse_interrupt_hook(fake_mouse_packet,4);
+
+	if (kbd->kbdmode == VC_RAW) /* Old style */
+		mac_put_queue( button_state );
+    }
+#endif
 }
 
 static void
@@ -467,6 +529,33 @@
 }
 #endif /* CONFIG_ADBMOUSE */
 
+#ifdef CONFIG_MACX_MOUSE
+static void
+macx_mouse_input(unsigned char *data, int nb, struct pt_regs *regs, int autopoll)
+{
+	/* It would be nice if this would check to see if we have mouse data from
+	   a real three button mouse and then re-register the real handler
+	   function. */
+
+	struct kbd_struct *kbd;
+	/* Store the button states in data (nuking extranious button info)*/
+	data[2] = ( data[2] & 0x7f) | fake_mouse_packet[2];
+	data[3] = ( data[3] & 0x7f) | fake_mouse_packet[3];
+
+	if (adb_mouse_interrupt_hook)
+		adb_mouse_interrupt_hook(data, nb);
+	kbd = kbd_table + fg_console;
+
+	/* Only send mouse codes when keyboard is in raw mode. */
+	if (kbd->kbdmode == VC_RAW) {
+		mac_put_queue( 0x7e );
+		mac_put_queue( data[1] );
+		mac_put_queue( data[2] );
+	}
+
+}
+#endif /*CONFIG_MACX_MOUSE*/
+
 /* Map led flags as defined in kbd_kern.h to bits for Apple keyboard. */
 static unsigned char mac_ledmap[8] = {
     0,		/* none */
@@ -546,7 +635,12 @@
 	/* initialize mouse interrupt hook */
 	adb_mouse_interrupt_hook = NULL;
 
+#ifndef CONFIG_MACX_MOUSE /* Not sure if this is the best way */
 	adb_register(ADB_MOUSE, 1, &mouse_ids, mouse_input);
+#else
+	adb_register(ADB_MOUSE, 3, &mouse_ids, macx_mouse_input);
+#endif /* CONFIG_MACX_MOUSE */
+
 #endif /* CONFIG_ADBMOUSE */
 
 	adb_register(ADB_KEYBOARD, 5, &keyboard_ids, keyboard_input);

--da4uJneut+ArUgXk--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
