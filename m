Date: Fri, 20 Jul 2001 11:23:43 +0100
Subject: Re: powermac (other ppc?) events
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010720102336.13001DBA25@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Look, I don't have a proper opinion on how the keys are achieved ...
>>
>> ---
>>
>> all I want is that the sound driver is:
>>
>> 1/ called through the standard ioctl() for volume - however many "volumes"
>> you want to adjust.
>>
>> This is so that *your* interface will work with *any* dmasound-supported
>> hardware (without hacking dmasound for each chipset).
>
> That was my idea in this - have some sound event daemon watch for events
> and call the proper ioctl. What was with the sound driver only permitting
> a single open() at a time? Would aumix running block the sound
> event daemon's ioctl?

The single open() rule is for /dev/dsp ... it is part of the OSS spec.
Actually, it is the opposite of what you've suggested - the OSS rule says
that open() shall *not* block - waiting for the device - but return straight
away with EBUSY.  (we *were* blocking on a sleep queue).

Up until my latest set of patches we were breaking this rule.  As of today
those patches are in Ben's tree but not BK (although they are in my ftp
space on penguinppc.org as well).

/dev/mixerXX can be opened multiple times - so this doesn't affect aumix et.
al.

However, one of the really nasty things about OSS is that you can't
guarantee that /dev/mixer0 belongs to /dev/dsp0  (cute eh?).  So, if you
have a sound dev open and want to be sure that you are sending volume
controls to the same device you have to send the mixer commands to /dev/dsp.

It's, perhaps, a moot point since "mixers" are really User Interface devices
- and there is an identification of which mixer you are talking to supplied
by one of the ioctls() - so, for example, with the latest (patch, benh)
dmasound_pmac - you will see the dmasound mixer identified as "Power Mac
Built-In Sound" on a kmixer tab.

If your GUI/Command Line mixer-of-choice doesn't identify the actual device
- it needs modifying - because otherwise it stores up trouble for the user
where there are multiple devices in the system...

as I have (perhaps wryly) noted ... most of the OSS mixer authors don't seem
to have RTF(OSS)M ;-)))

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
