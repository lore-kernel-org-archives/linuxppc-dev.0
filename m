Date: Fri, 4 Aug 2000 10:08:17 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: iounmap
In-Reply-To: <14730.9953.112006.773228@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.21.0008041006320.653-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Paul Mackerras wrote:

> Ronald Wahl writes:
>
> > I'm currently writing a device driver for an pci controller and have to
> > map very large amounts of pci memory and i/o ranges via ioremap. The
> > problem is that there is no iounmap and ioremap returns NULL after some
> > insmod/rmmod cycles. When gets this implemented?
>
> This should do the trick:
>
> void iounmap(void *addr)
> {
> 	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
> 		vfree((void *) (PAGE_MASK & (unsigned long) addr));
> }
>
> Could you replace the null iounmap in arch/ppc/mm/init.c with that,
> test it, and let me know if it works?

Yes, it seems to work. Thanx!

ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
