Message-ID: <39859A08.9D224B@wanadoo.fr>
Date: Mon, 31 Jul 2000 17:23:52 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: New input layer and ADB (Was Re: CONFIG_PPC != Mac)
References: <39821DD7.ED0DA0A2@embeddededge.com>
	 <39821DD7.ED0DA0A2@embeddededge.com>
	 <v04003a00b5a8c0b923e3@[24.66.67.194]>
	 <v04003a01b5a8c8c70822@[24.66.67.194]>
	 <4.3.2.7.2.20000731140051.0351ff00@mail.munich.netsurf.de> <4.3.2.7.2.20000731152113.03e44d60@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz,

Franz Sirl wrote:
>
> At 15:11 31.07.00, Martin Costabel wrote:
[]
> >After booting, some keys don't work: The "a" key that was mentioned
> >before (it is the "q" here on my French keyboard), but also all the
> >function keys and most keypad keys. Some of them don't produce keycodes,
> >some of them weird ones.
>
> I fixed that in my tree too, just got the condition in pmac_setup.c wrong,
> it should be if (!keyboard_sends_linux_keycodes) ..., just a typo, will be
> fixed later today.

Yes, this works, the keys are now working correctly from the beginning.
Thanks!

Sometimes after a console switch, I end up in capslock mode. Switching
capslock on then gives lowercase letters (except the letter "L"). After
a further console switch, things return to normal.

> >The main problem so far is that I cannot get mouse button emulation to
> >work. Has anyone tested this on an ADB keyboard/mouse? Or does it only
> >work if one goes over completely to the "linux" keycodes? I don't want
> >to do this yet, because it will make my system unusable with any other
> >kernel (or maybe unusable at all). Last time I tried, it took me several
> >hours to get a usable system back.
>
> Mouse button emulation works for me and it works in both keycode modes, in
> 2.4 the adb_buttons kernel arg is gone though.

After another hour of trying, I still have no mouse button emulation.
Neither in the console with gpm nor in X (Free86-4.0.1 from your
devel.linuxppc.org RPMs, with OPTION "XkbModel" "macintosh_old"). What's
the trick?

Here are my relevant kernel config options. Is there something missing?

CONFIG_INPUT_ADBHID=y
CONFIG_MAC_ADBKEYCODES=y
CONFIG_INPUT=y
# CONFIG_INPUT_IFORCE_USB is not set
CONFIG_INPUT_ADBHID=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y

Remark: Since I am using devfs, I had to put a line
LOOKUP    mouse    CFUNCTION GLOBAL symlink input/mice mouse
into /etc/devfsd. Otherwise no /dev/mouse got created.

Final question: What is /proc/sys/dev/mac_hid/keyboard_lock_keycodes
for?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
