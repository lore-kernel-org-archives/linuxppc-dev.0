Date: Wed, 22 Aug 2001 22:29:28 +0100
Subject: Re: Mixer support on the iBook2
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Olaf Hering <olh@suse.de>, Bastien Nocera <hadess@hadess.net>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010822212924.38109DBA5D@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> What I have found so far is that you have sound working after modprobe
> dmasound_pmac. when you launch kmix the volume slider is at 100%. but as
> soon as you move the volume control a bit the sound gets really loud. So
> I guess the driver reports the wrong volume level to the userland.

Missed most of this thread ... I've been overseas on business...

----

kmix (in common  with all the mixers I've tried so far) does not obey the
OSS rules - which say that the mixer *should not* rely on the return value
from the driver.

a lot of chips need the driver to modify the User's parameter before
supplying it to the chip... so you might, for example, lose precision when
it is stored in the chip.

For AWACS/Screamer I have fixed this problem in the driver by maintaining a
cached version of the value the User has set and just echoing this back.

This is, perhaps, not correct behaviour for the driver really, one day I
should ping all the mixer maintainers that it doesn't work for and ask them
to fix it there.   However, it's not an extravagant or particularly bloated
work-around for the short-term... it's also justifiable for situations where
you have write-only regs, or need to restore from sleep.

---

Looking at the TAS3001C data sheet reminds me that the value range is
greater than 0..100 so there must be some scaling needed.

Maybe that is related to the problem?

OSS does *not* (AFAIR) specify whether the steps are supposed to be linear
or logarithmic - just that they represent 0 .. 100%.  From a perceptual POV
logarithmic makes most sense - but you might want to expand the 0..100 into
the full range available from TAS3001C.

It is TAS3001C we're considering here (yes?) ... same comment apply also to
iBook1 with DACA but in a less severe way because the DACA range is
smaller...

----

Has anyone made the keywest-i2c driver interrupt-driven yet?
(I assume this is what's being used to control the mixer).

----

There are quite a lot of things to sort out to integrate the new chips into
dmasound_pmac tidily... I didn't do any re-coding yet - still working out
the layout changes - and I've also got to do the work-to-eat-stuff...  ;-)

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
