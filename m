Date: Thu, 29 Mar 2001 10:04:17 -0500 (EST)
From: Daniel Berlin <dan@www.cgsoftware.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 fixed soon...
In-Reply-To: <15042.57778.640138.923390@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10103290950010.11075-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Mar 2001, David S. Miller wrote:

>
> Daniel Berlin writes:
>  > If the patches + removing the bitfields for self-id
>  > (which it sounds like you already did) give you the ability to
>  > at least attempt to send packets (IE it runs the dma programs),
>  > you are in very good shape.  I had to get the byteswapping basically
>  > perfect to even get it to not just laugh at me and do nothing when we told
>  > ia dma context to run.
>
> What do you mean specifically when you say "removing the bitfields fo
> self-id"?  I notice in your patches that you don't byte swap
> q[0] and q[1] when they arrive for a self-id interrupt.  Are these
> quadlets supposed to be big-endian in memory?  Here is the change I made:

On the powerbook, they are in big-endian in memory (IE self-id always
worked okay). I tget the feeling this is one of the bugs in the
implementation, since people with G4's and OHCI chips get the self-ids in
the reverse order.

As for using pci_alloc_consistent more efficiently, I have changes to
convert to using a kmem_cache for the packets, rather than do a kmalloc
each time, and to remove the bottom half handlers in ohci1394.c and
replace it with tasklets.

As sopon as the the ieee1394 maintainer gets on the ball, i'll submit
them again.
> > For one thing, in your stuff, the comments and code near the comment
> "Pretty heinous." are totally bogus and wrong:
>
> 	p->value &= cpu_to_le32(0xfffffff0);
>
> works _PERFECTLY_ fine.
Not for me, i tried it before putting the code there. It's of course
possible that I fixed a different bug and attributed the fix to the wrong
part of the code. I'm pretty sure, however, that I did that change
individually, and it made a difference.

 >
> It would really be nice if the IEEE1394 developers kept on top of
> our patches and merged them to Linus soon.
>

Hey, I agree completely, but it hasn't happened yet.

>  > I also assumed readl/writel do byteswapping, and thus, there was no need
>  > to swap the register reads/writes since they would be swapped for us.
>
> Right, readl/writel push little-endian onto little-endian busses like
> PCI.
>
>  > At the absolute least, it'll give you an idea of what needs to be swapped
>  > for big endian architectures.
>
> I know what needs to be swapped thats why I did the patches I did :-)
It's trickier than you may think, because motherboard implementations of
firewire aren't required to honor the byte swapping setting, making it
pretty useless.

 >
>  > I have
>  > patches to do this somewhere, it didn't matter for powerppc, so it was
>  > only a half hearted attempt.
>
> Please push it to the ieee1394 maintainers, so the work need not
> be duplicated by others.  Thanks.
sure, as soon as they start actually maintaining ieee1394.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
