Date: Thu, 19 Apr 2001 15:36:07 +0100
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010419143631.8A7F72EFC2@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

copied to the list - since I think I've resolved the issues now ;-)

Franz wrote:
>I wrote:
>> I've figured out the mouse key emulation, and VT switches (by using Option
>> XkbDisable) - but I can't figure out where SysRq has ended up... and anyway
>> the idea was to see if there's a way of dealing with it so that Laptops can
>> use it too...
>
> Well, just try to setup your configuration files correctly. See the excerpt
> from my XF86Config-4 below. VT switches happen with alt(option)-ctrl-Fx if
> configured correctly.

OK.  What's happened is that the VT combination has shifted from
<CMD>-<CNTL>-Fx to <ALT>-<CNTL>-Fx ... all OK now.  (the config was correct)

[...]

>> For use of >4.0.99.x should I have CONFIG_ADB_KEYCODE disabled?
>
> For maximum compatibility options to be active you need:
>
> CONFIG_INPUT_ADBHID=y
> CONFIG_MAC_ADBKEYCODES=y
> CONFIG_MAC_EMUMOUSEBTN=y

This is what I've had (or the equivalent) since the input layer back-port to
2.2.x...

and Option "XkbModel" "macintosh"

> This will give you all the /proc entries.

yep. it does.

>> the SysRq needs to be quite low-level to be a fairly guaranteed way of
>> doing 'emergency' syncs and so on ... I'm assuming it's done individually
>> for each of the possible hid input sources.
>
> But is it enabled at all? Check /proc/sys/kernel/sysrq.

OK.  It isn't by default (which was catching me out)

Shouldn't it be enabled by default if the kernel is built CONFIG_SYSRQ?

Additionally, like VT-switching, the modifier key appears to have changed to
<ALT> from <CMD>...

SysRq doesn't appear to have _exactly_ the same behaviour as before (but
this may be a consequence of the change of Xserver - no longer using
fbdevhw).

The SysRq messages no longer break through onto the screen (I did get them
on VT-1 at one point - but couldn't reproduce it).

- and once you've got into SysRq mode it appears to be 'sticky' - i.e.
commands accepted with a single keypress until you do SysRq again.  Hmmm.
It might have been like that before - and I never noticed - because I always
did three-key-presses.

----

The issue of a "GoodWay" (tm) to support Laptops with SysRq remains - I'd
like to be able to use it on my Lombard...

====

So, now the correct place to make changes to get the right symbols out for
~/` ±/§ and so on is in  /usr/X11R6/..../xkb/symbols/gb - I assume.

====

I guess that I must have missed a place to look for the changes that
occurred to the modifier keys etc.... perhaps Kaoru should add this
information to his ftp directory.  If people who monitor the -dev list don't
know, what chance have Users got ;-?

====

anyway, thanks for the help - I'm now the proud owner of a nicely
accelerated, non-flickering, ati mach64 XF4 installation.... *and* know
which keys to press ;-))

next time I have some time - I'll do the Lombard & the 9600 (imstt could be
amusing)...

BTW: It runs MoL (almost fine) too.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
