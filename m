Date: Mon, 5 Apr 2004 10:23:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch Preview for MVME2100
Message-ID: <20040405172348.GS31152@smtp.west.cox.net>
References: <Pine.LNX.4.33.0404041321400.21042-200000@lux32.if.fh-landshut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0404041321400.21042-200000@lux32.if.fh-landshut.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Apr 04, 2004 at 01:27:58PM +0200, Oliver Korpilla wrote:

> Hello!
>
> I tried to port the available patch for MVME2100 from linux-2.4.2 HHL2.0
> to vanilla 2.4.25, and I'd like someone to have a look at it, to say if it
> makes sense, because this is a first-timer.
>
> It is not yet verified, because I cannot compile or test it before
> tomorrow, but if someone could comment on it still yet, it'd be very much
> appreciated.
>
> You can download both the original patches and my tries at new patchs
> here:
>
> http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.bz2
> http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.gz
> http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.2_hhl20.patch.bz2
> http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.2_hhl20.patch.gz
>
> The changes I made in detail are attached to this message.

- The stuff in arch/ppc/boot/mvme2100 can go.
- The open_pic.c change shouldn't be needed either.
- Your openpic_initsenses table looks wrong, and is probably the cause
  of the uart slowness you found.  What you do is only list the IRQs for
  which you have something, and use openpic_set_sources calls to skip
  over the gaps.  Look at lopec_init_IRQ and ask if you still have
  problems.  I hoped to have documented that one well the first time
  around. :)
- In mvme2100_set_bat, try something along the lines of:
{
	mb();
	mtspr(DBAT1U, 0xf8000ffe);
	mtspr(DBAT1L, 0xf800002a);
	mb();
}

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
