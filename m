Date: Tue, 6 Apr 2004 11:47:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch Preview for MVME2100
Message-ID: <20040406184703.GA31152@smtp.west.cox.net>
References: <Pine.LNX.4.33.0404041321400.21042-200000@lux32.if.fh-landshut.de> <20040405172348.GS31152@smtp.west.cox.net> <4071A024.6020005@fh-landshut.de> <20040405183052.GU31152@smtp.west.cox.net> <4072E904.7010409@fh-landshut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4072E904.7010409@fh-landshut.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 06, 2004 at 07:29:40PM +0200, Oliver Korpilla wrote:

>
> Tom Rini wrote:
>
> Applied changes today, and the serial console is coming along nicely,
> can log into my board, use ethernet, boot off NFS. :)
>
> I'm very happy and very grateful. Thank you!
>
> >>Maybe the CONFIG_EPIC_SERIAL_MODE should be set, shouldn't it? Will add
> >>it tomorrow. Should I add that cascade hookup stuff even if there is no
> >>cascaded 8259?
> >>
> >>
> >
> >You don't need to call openpic_hookup_cascade, if there is no cascade.
> >You only want to set EPIC_SERIAL_MODE if the controller really is in
> >serial mode.
>
> As far as I can see from the (sometimes very unspecific) documentation
> for the MVME2100 and from the probing in the Linux kernel there doesn't
> seem to be an external interrupt (= no 8259) on-board. So I guess I
> could drop CONFIG_EPIC_SERIAL_MODE, because I don't need to probe for
> interrupts on that source, do I? (I'm a bit confused about that, because
> I delved a bit in the MPC107, the LoPEC board, the MPC8240 and the
> MVME2100 manuals without very clear info about that)

This is all from memory, but..
EPIC_SERIAL_MODE means that the OpenPIC is put into serial mode.  This
means that the OpenPIC is wired for a number of interrupt, as opposed to
4.  Looking at the old patch, this is something you can turn off for the
MVME2100.

> Can I drop
>
>       /* Map serial interrupts 0-15 */
>       openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
>
> too? No connected 8259 should mean no interrupt sources there, I guess.

Looking at the old table, yes.

> >No.  The '0's are wrong.  You only need to describe, in terms of
> >level/edge, documented interrupts.  You then make multiple calls to
> >openpic_set_sources(), to skip over the non-existant interrupts.
>
> For initial testing I have still 0s in there - for the unused interrupts
> within the range after the external interrupts. I get a bad interrupt at
> 1 - this would be the first interrupt in the cascade I guess, but
> interrupts of the ethernet and the UART serial (17  - 2nd internal
> interrupt and 29 - 13th internal interrupt) work just fine - console is
> responsive, ethernet is stable and fine.

If you drop the openpic_set_sources() call for 0-15, you need to drop
these from the table as well, FWIW.  Similarly for any other '0's you've
had.

> A very big "Thank" You! indeed. Your advice was indispensable for my
> work and it was to the point, too.

You're welcome.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
