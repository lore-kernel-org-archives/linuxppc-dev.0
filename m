Date: Thu, 23 Oct 2003 13:55:58 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: __restore_flags shows in kernel profile
In-reply-to: <1066906206.29481.268.camel@hermes>
To: Gary Thomas <gary@mlbassoc.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEJHGAAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Thu, 2003-10-23 at 01:55, Joakim Tjernlund wrote:
> > I did a kernel profile(included below) of the bootup of my custom MPC862 board and I
> > noticed that __restore_flags gets a very high count. I am suprised that such a small
> > assembler routine gets such a high count. __cli, _save_flags_ptr and __sti are much lower.
> > A small test program with a tight select loop on fds 0,1 or 2 also makes __restore_flags
> > go wild.
> > Anyone know why?
> >
>
> Simple: when interrupts are off (typically after a __save_flags),
> there can't be any profiling interrupts.  As soon as you restore
> the interrupts (_restore_flags), the interrupt used for profiling
> will fire.

I see, thanks.
Now I wonder what keeps interrupts off for so long and what those nops are doing
in __restore_flags.

   Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
