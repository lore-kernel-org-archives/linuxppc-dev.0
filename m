Date: Tue, 08 Apr 2003 14:01:31 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: I2C RTC causes boot delay...
In-reply-to: <3E92A9E8.7060101@imc-berlin.de>
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAENCFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I wrote,
>
> > I have an I2C RTC connected to my MPC855T to substitute the internal one.
> >
> > I noticed that between
> >
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK
> >
> > and the next lines printed while booting "nothing" happens for THREE
> > seconds.
> >
> > I reckon that is has something to do with not having an external 32kHz
> > clock on the MPC. But I can't find the place in the sources!
>
> I migth have found it:
>
> Is it ok and enough to set
>
>          ppc_md.set_rtc_time             = NULL;
>          ppc_md.get_rtc_time             = NULL;
>
> in platform_init()? And then later - when I2C is initialized - set it
> to the appropriate I2C RTC functions?

Yes, that's it. If your kernel ever hangs after printing out
"calibrating delay loop ...", try adding a set_tb(0,0) somewhere in m8xx_setup.c,
to see if it fixes it.

You may also want to add an "I2C reset sequence" in your firmware/kernel
if your I2C clock gets stuck and don't respond(can happen if reset/power down while
reading the RTC). Look in u-boot for details.

    Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
