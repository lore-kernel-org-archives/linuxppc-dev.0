From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Highmem on PPC?
Date: Tue, 5 Feb 2002 20:33:16 +0100
Message-Id: <20020205193316.19866@smtp.wanadoo.fr>
In-Reply-To: <20020205115618.D6834@boardwalk>
References: <20020205115618.D6834@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The dual 7450 is an apple machine.  I also have one of our beta
>boards, a dual 7410 with 1 GB RAM, and we're planning on having a dual
>7450 with 1 GB RAM just as soon as we get the chips.
>
>What's your philosophy about highmem?  We map all lowmem with BATs on
>SMP in order to avoid trashing SRR0/SRR1 according to your new comment
>in entry.S, but it also mentions "other cpus" without saying which cpu
>you're talking about. :) How are you avoiding recursive TLB faults on
>the highmem pages themselves?  What cpus did you have in mind when you
>wrote the SMP stuff?

By "other CPUs", I'm thinking about CPUs that have no BATs. However,
currently, and except for the Power4 which is handled differently, those
are the embedded (4xx, 8xx) which don't do SMP, at least not now.

I don't think kernel stacks & code can ever be in highmem pages, so there
should be no risk taking a fault on highmem page in the return from
exception path.

>I'm currently getting hard crashes on the dual 7410 with highmem.  Not
>even the SMI starts xmon.  I'm not sure that it's a software bug,
>which is why I'm getting the dual 7450.

Interesting. I have similar reports about dual 800s with 1.5G of RAM.
I don't personally have a machine with that much RAM, so it makes things
a bit difficult to debug. All I noticed so far is that
enabling interrupt distribution will cause occasional lockups on my
dual 7400 at work (not related to highmem). So if you plan to chase
this highmem bug, start by disabling that option to avoid mixing
problems.

Just in case it's a spinlock bug (who knows...) you may want to hack
the spinlock debug output to use the btext engine (basically #define
printf to xmon_printf in the spinlock code and hack xmon/start.c to
force use_screen).

And let me know if you find something ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
