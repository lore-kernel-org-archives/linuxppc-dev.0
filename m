Message-ID: <3C5ED0F9.5060908@cymes.de>
Date: Mon, 04 Feb 2002 19:20:41 +0100
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Why is the Powerbook Fn-Key handled differently?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I own an Powerbook G3 which has a Fn-Key for his special functions.
During my kernel source studies I learned that there are two keyboard
drivers: 1. The old machintosh keyboard driver and
          2. The new event driven Human Input Device from Vojtech Pavlik

The old driver map the scancode for the Fn-Key to a different value and
passes it to the Kernel keyboard driver. The new HID filters the Fn-Key
completely out, as the attached code fragments below show.

Is there any reason to cut out the Fn-Key in the new input driver?
Nevertheless the Fn-Key is hard wired with the special keys and the
number block, it would helpful to have an additional qualifier key on
this small keyboard.

For now this is to check if it makes sense for me to work further in
this direction.

  Thanks for your help in advance
    Matthias Grimm


Sourcefile: driver/machintosh/mac_keyb.c, old-style keyboard driver

static void
input_keycode(int keycode, int repeat)
{
	[...]

	/* remap the "Fn" key of the PowerBook G3 Series to 0x48
	   to avoid conflict with button emulation */
    >>>     if (keycode == 0x3f)
    >>>		keycode = 0x48;

	[...]
}

Sourcefile: driver/machintosh/adbhid.c, new-style keyboard event driver

static void
adbhid_input_keycode(int id, int keycode, int repeat)
{
	[...]

	switch (keycode) {
	[...]
   >>>	case 0x3f: /* ignore Powerbook Fn key */
   >>>		return;
	}

	[...]
}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
