Subject: Re: __restore_flags shows in kernel profile
From: Gary Thomas <gary@mlbassoc.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <200310230755.h9N7tLIr024281@blooper.utfors.se>
References: <200310230755.h9N7tLIr024281@blooper.utfors.se>
Content-Type: text/plain
Message-Id: <1066906206.29481.268.camel@hermes>
Mime-Version: 1.0
Date: 23 Oct 2003 04:50:07 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2003-10-23 at 01:55, Joakim Tjernlund wrote:
> I did a kernel profile(included below) of the bootup of my custom MPC862 board and I
> noticed that __restore_flags gets a very high count. I am suprised that such a small
> assembler routine gets such a high count. __cli, _save_flags_ptr and __sti are much lower.
> A small test program with a tight select loop on fds 0,1 or 2 also makes __restore_flags
> go wild.
> Anyone know why?
>

Simple: when interrupts are off (typically after a __save_flags),
there can't be any profiling interrupts.  As soon as you restore
the interrupts (_restore_flags), the interrupt used for profiling
will fire.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
