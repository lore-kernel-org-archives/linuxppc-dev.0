Message-Id: <5.1.0.14.2.20010724112831.0420e4d0@mail.netsurf.de>
Date: Tue, 24 Jul 2001 11:40:51 +0200
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: userspace button controls
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010724015531.516c9985.jpgarcia@execpc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:55 24.07.2001, Joseph P. Garcia wrote:
>attached is a tar.gz of a few files I've created as a solution to
>powerbook buttons.
>
>- buttons.patch: brings all 5 adb-buttons to userspace via NIL's events
>via the keyboard.  New keys added to input.h.  With proper support, the
>user could see these keypresses, and use them.  This also does not use the
>pmac_backlight.c file, in exchange for a new framebuffer ioctl, existant
>in chipsfb, atyfb, and aty128fb.  The only interdependancy is between
>chipsfb/atyfb and via-pmu for backlight control for lombard and
>earlier.  The pmu's backlight ioctl was removed.  So sound controls are in
>the mixer (unchanged), backlight controls are in the fb rather than pmu,
>and the adbbuttons are simple keys, accessed via /dev/input/event? and,
>with some help, common console/X keycodes.  syslog logs an error with
>there is no keycode.  I changed that to a DEBUG message rather than a
>WARNING message.
>
>- adbhid_sleep.patch: checks before an adbhid is deregistered post
>sleep.  The existing code causes an open event device to dangle open
>(safely i think), but the program doesn't notice it.  This checks to see
>if the device has changed, or no longer exists before it deregisters
>it.  This works for me, but might be unsafe.  I couldn't find a cleaner
>solution that still allows for reprobing.
>
>- input_sec.patch: Fix permissions for input devices created via devfs,
>which are default readable by anyone, including the keyboard's event dev.
>(submitted to maintainer)
>
>- misc.patch: one fix (missing non-fatal include in checks.c), and a
>slightly cleaner non-TAU temp coding.  (irrelevant to button operations)
>
>- keyevd.c: a quick daemon that listens to the buttons and acts on
>them.  Simple compile builds a forking daemon that uses the mute button to
>switch between muting speaker and line out.  Key repeat is too quick
>tho.  Mostly a quick hack, not too clean.  This needs input event support.
>
>I've only tested this on my powerbook, which is a aty->pmu based backlight
>system.  I used BenH's prexisting backlight interfaces.  A better ioctl
>might be nessesary (still 0x0-0xf range), but pmu, aty, and aty128 now
>could change to fit a standard ioctl rather than a function API.
>When I find the time, I should redo the keyevd so it isn't as messy.
>
>Thanks for your time and consideration.

Wow, this looks great! Would you mind sending the input.h part of the patch
to linuxconsole-dev@lists.sourceforge.net as well? Probably you will get a
little bit different official numbers then, but thats no problem. After the
numbers are approved there, they will end up with the next merge in the
official kernel quite soon. Then we can merge your stuff into linuxppc_2_4*
and I'll do the merge into the input/console CVS for 2.5. Hmm, maybe I
should add your keyevd source to the input/console CVS as well.
I'll try to take a more detailed look during the next days, but overall I'm
very happy with this stuff :-).

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
