Date: Sat, 17 Feb 2001 20:41:25 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: calling giveup_altivec on machine with no altivec!?
Message-ID: <20010217204125.D12991@altus.drgw.net>
References: <20010215160658.P26702@altus.drgw.net> <3A8C5ECE.29670E5A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A8C5ECE.29670E5A@mvista.com>; from dan@mvista.com on Thu, Feb 15, 2001 at 05:57:18PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 15, 2001 at 05:57:18PM -0500, Dan Malek wrote:
> Troy Benjegerdes wrote:
>
> > Somehow prev->thread.regs->msr & MSR_VEC turned out true. I'm suspecting
> > something got overwritten somewhere..
>
> Crap....
>
> > This is an SMP machine so I'm wondering if there wasn't a race condition
> > on something with task structs..
>
> Ahhhh, wait a minute......does SMP do the lazy Altivec or does it
> always switch it?  On uP systems, MSR_VEC isn't set unless you get an
> Altivec trap, but I seem to remember comments about always switching it
> on SMP systems.  On an SMP system, if you don't really have Altivec
> you probably shouldn't enable it in the configuration.....no common
> config here :-).

Well, in theory yes, but the fact that MSR_VEC mysteriously got set
implies some other problem somewhere... I also think Common config's are
just too usefull, since more code paths get tested on more machines..
there's something that set MSR_VEC that shouldn't have, and I'd never have
seen it if I didn't have a common config.

SMP does 'somewhat' lazy altivec.. if the process used altivec, it
always switches. UP I think switches only when a second process actually
tries to use altivec, and another process already has data in registers.


--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shulz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
