From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Wed, 9 Aug 2000 10:48:39 +0200
Message-Id: <20000809084839.8039@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000808194747.24030A-100000@ofey.earthlink.net>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000808194747.24030A-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Personally, I think UTC <-> local time conversion should be handled in
>userland.  Both hwclock and clock can handle both local time and UTC just
>fine.

If we do that this way, we can't have proper in-kernel NTP update of the
RTC without a hack that let it only "correct" for less than 1 hour.

>Does Mac OS handle different timezone information in xpram well?  Timezone
>information is saved in xpram but it's also saved in some of config files.
>So, it appears to me that Mac OS will get confused or ignore or delete the
>timezone setting in xpram if it doesn't agree with the config file.

It used to be only in xpram. Recent MacOS also have a prefs file, I have
to check what happens when this file is out of sync with the xpram.
Saving the tz to xpram also makes sure the kernel is fine at boot accross
multiple boots.

It may be a "cultural" difference due to my years of MacOS background,
but rather than having userland set the timezone, I'd personally rather
see userland read the kernel timezone coming from xpram, and set the
appropriate userland env. vars depending on this timezone (especially
useful for portables). Well, that's my 2 cents, of course, nobody will
agree wit me ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
