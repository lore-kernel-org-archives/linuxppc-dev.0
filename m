Date: Fri, 27 Aug 1999 15:09:41 +0200 (CET)
From: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: bug in l2cr status display? 
Message-Id: <Pine.A41.4.05.9908271508310.19776-100000@c2.hrz.uni-giessen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello out there,

I've downloaded the 750 PDF Manuel and to Bit #9 (L2DO) it says:
"L2 Data-only. Setting this bit enables data-only operation in the L2
cache..."                                    ^^^^
So setting this bit disables instruction caching therefore it should'nt be
set on bootup. 

It seems to me, that the L2CR programming is implemented but disabled in
current kernel version. The L2CR=xxxxxxx doesn't work for me.

By the way, it seems that Motola (or IBM) uses different cache chips on
the 750 CPU - one with 0.5 and one with 1.0 ns timings. 0.5 ns are the
common used chips while mine has a 1.0ns timing. This causes the
PowerLogix Cache Control to crash my Mac. Has anyone expiriances on this?
How has this been to recocnice in the kernel boot-up?


Marc

On Thu, 26 Aug 1999, Michel Lanners wrote:

> 
> Hi all,
> 
> While playing with the l2cr in order to set it manually after OF
> booting, I've come across the following.
> 
> It seems that the effect of the L2CR[DO] bit isn't clear. In the 750
> user manual, in the table describing l2cr, it says '... setting  this
> bit enables the caching of instructions'. This doesn't corrsspond to
> the name of the register, nor to what I see with my G3 upgrade card: in
> normal operation, L2CR[DO] isn't set, but it makes no sense to disable
> instruction caching excpet for test purposes.
> 
> So, what's happening? Is the user manual wrong? In that case, we should
> correct arch/ppc/kernel/ppc_htab.c accordingly.
> 
> Any Motorola engineer around? Others with better docs? FWIW, I checked
> the 750 errata already... nothing.
> 
> Michel

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
