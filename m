Date: Wed, 6 Feb 2002 10:39:41 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Matthias Grimm <joker@cymes.de>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Why is the Powerbook Fn-Key handled differently?
In-Reply-To: <3C5ED0F9.5060908@cymes.de>
Message-ID: <Pine.LNX.4.33.0202061003001.9154-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The old driver map the scancode for the Fn-Key to a different value and
> passes it to the Kernel keyboard driver. The new HID filters the Fn-Key
> completely out, as the attached code fragments below show.
>
> Is there any reason to cut out the Fn-Key in the new input driver?
> Nevertheless the Fn-Key is hard wired with the special keys and the
> number block, it would helpful to have an additional qualifier key on
> this small keyboard.

AFAIR with the Fn key pressed, those keys that do have a Fn key mapping
will generate separate key codes anyway (leaving the key in would generate
a 'modifier' key event followed by a different keycode so you wouldn't see
fn-u but fn followed by kp-4). The rest of the modifier keys behaves
different (the keycode of a key pressed together with ctrl won't change).
That will be the reason why the HID code drops the fn key event. In order
to leave it in as additional modifier you'd need to add another translation
table (identity, as far as the keypad codes are concerned). Other than
that, I can see no reason to drop that key event.

BTW the old driver never shows up the Fn key events either. That 'special
value' seems to be dropped by handle_scancode now. The comment there
indicates the original keycode (assuming it goes through) would confuse
the mouse button emulation. Here's why:

  /*
    The X server for MkLinux DR2.1 uses the following unused keycodes to
    read the mouse:

    0x7e  This indicates that the next two keycodes should be interpreted
          as mouse information.  The first following byte's high bit
          represents the state of the left button.  The lower seven bits
          represent the x-axis acceleration.  The lower seven bits of the
          second byte represent y-axis acceleration.

    0x3f  The x server interprets this keycode as a middle button
          release.

    0xbf  The x server interprets this keycode as a middle button
          depress.

    0x40  The x server interprets this keycode as a right button
          release.

    0xc0  The x server interprets this keycode as a right button
          depress.

    NOTES: There should be a better way of handling mice in the X server.
    The MOUSE_ESCAPE code (0x7e) should be followed by three bytes instead
    of two.  The three mouse buttons should then, in the X server, be read
    as the high-bits of all three bytes.  The x and y motions can still be
    in the first two bytes.  Maybe I'll do this...
  */

IOW, the ancient Xpmac mouse data input hack (rerouting mouse data to the
keyboard input stream, yuck). Do we need to support this any further?? If
not, the remapping in the old driver can go, as can the 'if (kbd->kbdmode
== VC_RAW)' section of mouse_input.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
