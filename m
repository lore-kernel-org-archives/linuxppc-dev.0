Message-ID: <40F4621F.1000206@loowit.net>
Date: Tue, 13 Jul 2004 15:28:47 -0700
From: James Perkins <james@loowit.net>
MIME-Version: 1.0
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: early UART mapping in head_44x.S
References: <40F452D6.9020806@rossvideo.com>
In-Reply-To: <40F452D6.9020806@rossvideo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Siemsen wrote:

>
> I've been trying to boot a vanilla 2.6.7 kernel on a board similar to
> Ocotea (the board boots 2.4.x okay).  I wasn't getting any serial
> output, despite setting CONFIG_SERIAL_TEXT_DEBUG and doing early
> registration of a console (as per David Woodhouse's posts on this list).
>
> After much tracing and a lucky suggestion on IRC, I seem to have
> stumbled on the cause, although I don't fully understand what is going
> on.  In arch/ppc/kernel/head_44x.S (from 2.6.7 mainline) there is a
> block of code that sets up the "early UART mapping".  It does three
> tlbwe instructions, and then repeats the same a second time but in
> "Translation state 1".  This second set seems to cause my problems.
> When I comment out the 5 instructions before the isync, I magically
> start getting printk outputs.
>
> But as-written, the code causes an exception immediately upon the first
> attempt to write to the mapped space.  Of course there are no exception
> handlers in place at this point, so things grind to a halt very quickly.
>
> Can anyone explain how this is meant to work?  Specifically, the
>     ori    r3,r3,PPC44x_TLB_TS
> would clear the other bits in this register, including the "valid" bit,
> so how is this mapping supposed to work?

ori won't clear the invalid bits, it just "or"s in the TS bit itself.
What suprises me is that TLB 1 is being written twice. It may make more
sense to change the second case

         li      r0,1            /* TLB slot 1 */

to
        li      r0,2             /* TLB slot 2 */

So that there is both a TS=0 and a TS=1 mapping, in TLB entry index 1
and 2, respectively -- this will catch both the MSR[DS]=0 and MSR[DS]=1
cases.

Note I haven't explored further into the allocation the kernel uses for
TLB entries; I just looked through head_44x.S

Cheers,
James

--
James Perkins         james@loowit.net         http://loowit.net/~james
-=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=-
    I have no fear of death.... It's how you live that really counts.
		    -- Katharine Hepburn, 1907-2003


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
