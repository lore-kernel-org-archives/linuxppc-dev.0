Message-ID: <39859AC4.C4146C1B@pop.agri.ch>
Date: Mon, 31 Jul 2000 17:27:00 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <39821DD7.ED0DA0A2@embeddededge.com>
	 <39821DD7.ED0DA0A2@embeddededge.com>
	 <v04003a00b5a8c0b923e3@[24.66.67.194]>
	 <v04003a01b5a8c8c70822@[24.66.67.194]>
	 <4.3.2.7.2.20000731140051.0351ff00@mail.munich.netsurf.de>
	 <4.3.2.7.2.20000731152113.03e44d60@mail.lauterbach.com> <4.3.2.7.2.20000731170153.03508c50@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
> >Turning CONFIG_ADBMOUSE off results in a nice kernel panic with two additional
> >keyboards connected to the adb-port of my wallstreet :-) (No additional mouse
> >connected)
>
> Now that is interesting. Did it work with Ben's 2.2? Were the keyboards
> plugged in at boot time? Modules or compiled in? Can you give a bit more
> details please?

Sure I can ;-)
Situation: Wallstreet I internal ISO-kbd , ISO-kbd, ANSI-kbd, (with and
without MouseMan)
Built-in!

- 2.2.17pre13-ben2 works flawless, no problem so far except the KP_equal.....

- 2.4.0test5 synced today no additional kbd on boot works
- 2.4.0test5 with additional kbd & MouseMan plugged in AFTER boot works
- 2.4.0test5 with additional kbd & MouseMan plugged on boot (means
before) panics.
- 2.4.0test5 with additional kbd & MouseMan plugged on boot, passing
console=ttyS0 as kernel args works
- 2.4.0test5 with additional kbd & MouseMan plugged on boot, passing
console=tty0 and console=ttyS0 as kernel args panics, see below.

The console stuff was added to collect an eventual panic :-)

The config I have to grab from the linux side

Andreas

---------

log with only console=ttyS0:

ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input1: ADB HID on ID 2:2.c4
ADB keyboard at 12, handler set to 3
Detected ADB keyboard, type ANSI.
input2: ADB HID on ID 12:2.03
ADB keyboard at 13, handler 1
Detected ADB keyboard, type ANSI.
input3: ADB HID on ID 13:2.01
ADB keyboard at 15, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input4: ADB HID on ID 15:2.05
input5: ADB HID on ID 7:7.1f
ADB mouse at 3, handler set to 4 (trackman/mouseman)
input6: ADB HID on ID 3:3.04
ADB mouse at 14, handler set to 4 (trackpad)
input7: ADB HID on ID 14:3.04
Macintosh non-volatile memory driver v1.0
event0: Event device for input7
event1: Event device for input6
event2: Event device for input5
event3: Event device for input4
event4: Event device for input3
event5: Event device for input2
event6: Event device for input1
event7: Event device for input0
usb.c: registered new driver hid
keybdev.c: Adding keyboard: input4
keybdev.c: Adding keyboard: input3
keybdev.c: Adding keyboard: input2
keybdev.c: Adding keyboard: input1
mouse0: PS/2 mouse device for input7
mouse1: PS/2 mouse device for input6
mouse2: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice

log with console=tty0 & console=ttyS0:

ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input1: ADB HID on ID 2:2.c4
NIP: C0154254 XER: 00000000 LR: C01541A0 REGS: c055f9e0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c055e000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C01541A0 C055FA90 C055E000 00000000 00000001 0000003A 00000001 081A7300
GPR08: C0270000 C0270000 00000000 000000DC 22828042 002CB0A8 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 0055FBC0 00000000 C0004BE4
GPR24: C0005A00 00000001 C055FBD0 00000001 00000034 0000003A 00000001 00000000

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
