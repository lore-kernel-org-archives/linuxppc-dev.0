Date: Wed, 18 Jul 2001 07:43:06 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: "Iain Sandoe" <iain@sandoe.co.uk>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
Message-Id: <20010718074306.39ad09e3.jpgarcia@execpc.com>
In-Reply-To: <20010718111339.6EF762EFBD@apollo.valhalla.net>
References: <20010718111339.6EF762EFBD@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Jul 2001 12:11:42 +0100
"Iain Sandoe" <iain@sandoe.co.uk> wrote:
> How does the action end up getting routed to the sound driver?

In the current set up, it is very similar to how the pmac backlight is.  The dmasound_awacs[module] registers a volume controller using a function defined in arch/ppc/kernel that simply stores a function pointer.  That function is called indirectly in the button handler code in adbhid.c.  The volume controller function in dmasound_awacs is a mix of calls awacs_volume_setter and direct calls to awacs_write.  The increment and such are all in that function.  I used this route, as opposed to something more direct, so dmasound could still be a module.  I should point out that this implementation can't control sound volume until something has used the sound card.  not sure why..

so this mostly ignores ioctls and mixers altogether.  I said it wasn't pretty.

This behavior is all bypassed if the user desires keycodes instead, in which case, if it worked, the adbhid code would send a keycode event rather than call the volume controller.  So adbhid.c's button handling code is where our kernel->userspace event should go, whatever we settle on.  if i understand my code correctly, the NIL support is always enabled, even if you don't enable the volume config option.  so this could mean anything encased in an ifdef CONFIG_PMAC_VOLUME would be the interlocking fragile code that should/will not make the trip into a public kernel.  but i'd have double check to make sure..

> ----
>
> I'd definitely favour a daemon that didn't imply dependence on a particular
[...]
> so that coverage would come as part of a standard install?

I'm not familiar with what kind of apis already exist, but your suggestion to make something like esound sounds good.  Given that these daemons try to allow for such things that we can provide in hardware (iirc), like multiple opens of /dev/dsp.  So would this be like taking most of the kernel's sound interface (like mixer too?) and bringing it into a userspace daemon?  You mention ALSA a bit.  Would this be a better fit than OSS, or are we better making our own?  but then again, I always lean a bit too much toward the generic all-purpose APIs created by Mr./Ms. Someone Else whenever userspace is involved.

And so with this, how much would stay kernel side?  is this a new api'ed kernel driver, or a userspace driver/daemon using a semi-generic ioctl interface for ppc sound hardware that also listens to other devices for control?  Can this be achieved in a kernel thread?  or would that still be considered kernel-bloat?  not to sure on userspace scheduling reliability.

(i talk alot when im trying to help)

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
