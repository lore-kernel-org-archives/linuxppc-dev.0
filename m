From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15181.27768.208731.839676@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jul 2001 19:23:04 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel-2.4.7.pre5
In-Reply-To: <3B4AF521.45E57FAD@mandrakesoft.com>
References: <20010710210004.Postino-030256@smtp01.highway.ne.jp>
	<20010710142113.B21458@suse.de>
	<3B4AF521.45E57FAD@mandrakesoft.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff Garzik writes:

> > The "correct" fix would be somthing like that:
> > /mirror/kernel/people/andrea/kernels/v2.4/2.4.7pre3aa1/00_ksoftirqd-7_ppc-2
> >
> > But Paul was/is not very happy about that softirq thing...
>
> *shrug*   linux-2.4.7-pre5 softirqs should finally (a) have a coherent
> implementation with no special cases, and (b) sort through all the bugs
> and API weirdness that Ingo added in 2.4.6-preXX.

I just looked and the 2.4.7-pre6 implementation looks OK to me.  We do
need the __ksoftirq_task field in the irq_cpustat_t structure.

I remain unconvinced by some of the arguments for having the ksoftirqd
thread(s).  In particular the notion that you reduce your maximum
stack usage that way is bogus - once the softirq is marked pending it
will be executed the next time we take an interrupt, which means that
it can be executed at any time that interrupts are enabled.  But I
don't think the current implementation is wrong, just a bit
unnecessarily complex.  As Jeff says, *shrug*.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
