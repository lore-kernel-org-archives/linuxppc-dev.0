Date: Sat, 29 Dec 2001 19:10:19 +0100 (CET)
From: Lukas Geyer <geyer@ml.kva.se>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Eject CD button on the iBook, kernel keymap translations
Message-ID: <Pine.LNX.4.33.0112291859090.14745-100000@mandelbrot.ml.kva.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a question regarding the CD eject button (F12) on the iBook2. On
the console this button generates exactly the same keycode as CursorDown
(keycode 108, not in raw mode), at least under 2.4.17-benh0. The reason
for this is that adbhid_input_buttons() calls input_report_key() with
keycode 161 (KEY_EJECT_CD) and then the input layer has the undocumented
translation table x86_keycodes[], which maps 161 to 108, which is usually
CursorDown. The raw scancodes are still different for CursorDown (it
generates two scancodes, 224 as prefix and 80 afterwards, which combine to
a keycode of 108) but it is still kind of annoying. Either the EjectCD-key
should not generate any keycode at all or something "free" which does not
get interpreted by normal terminals. I do not completely understand all
these translations in the kernel, is there some documentation somewhere?

A related question: What is the right way to make the special keys/buttons
on the iBook really work as labelled, i.e. eject CD, adjust and mute
volume?

Lukas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
