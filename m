Message-ID: <3920AA9F.2DCA0B2E@charter.net>
Date: Mon, 15 May 2000 20:55:43 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Richard Hendricks <richard.hendricks@motorola.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:
>
> Richard Hendricks wrote:
> >
> > "Dan A. Dickey" wrote:
...
> > > #if 1
> > >         /* position IMMR */
> > >
> > >         lis     r1, IMMR_VALUE@h
> > >         ori     r1, r1, 0
> > >         mtspr   638, r1
> > >
> > > bror1start:
> > >         /* need to setup BR1/OR1 to get to the BCSR on the fads */
> > >         lis r9,0xffff
> > >         ori r9,r9,0x8110
> > >         lis r10,0x0210
> > >         ori r10,r10,0x0001
> > >         stw r9,0x10C(r1)
> > >         stw r10,0x108(r1)
> >
> >
> > >         /* signal on */
> > >         lis     r8,0x210
> > >         ori     r8,r8,16
> > >         lis r9,0x210
> > >         ori r9,r9,16
> > >         lwz r10,0(r9)
> > >         rlwinm r9,r10,0,4,2
> > >         stw r9,0(r8)
> >
> > Hm.. Whay are you ori'ing in 16?  BCSR1 should be at 0x4, not 0x10.  You
> > end
> > up dropping r9 onto BCSR0, which can't be a good thing.  Try changing
> > the
> > two ori's to ori r8,r8,4 and ori r9, r9, 4.  Let me know what happens!
>
> Going along with my ignorance of assembly, the above I copied out
> of a .s file - the result of writing the above in C and asking the
> compiler
> to produce the .s.  Cut & paste is a wonderful thing.  :)  However,
> sometimes it comes back to haunt you.  It'd be my guess that I did
> not change one of the register names correctly (after doing the cut &
> paste, I changed the registers to be something more "appropriate").
>
> I'll try your suggestion shortly - however, the processor never
> reaches this point in execution.

Ok, I've backed out your change, and am now or'ing in the 16.
Things work again.  Well; the signal lamp goes on & off.
Checking the fads users manual, the address of BCSR1 is clearly
at 02100010.  Perhaps you were thinking of word addresses or something?

And, I'm currently still stuck at the development port interrupt...
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
