From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: ethtool failure with tulip 21143
Date: Sun, 16 Dec 2001 22:59:48 +0100
Message-Id: <20011216215948.15249@smtp.wanadoo.fr>
In-Reply-To: <p04330107b84297e5c096@[24.163.44.170]>
References: <p04330107b84297e5c096@[24.163.44.170]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Jeff Garzik wrote:
>
>>correct, it does not support anything but basic driver info yet
>
>oops. Sorry, I didn't know the tool only did this so far. I read all
>the dox I could find, but somehow I missed this point?
>
>Benjamin Herrenschmidt wrote:
>
>>Jeff, afaik, this one has the broken bridge I told you about.
>
>How "broken" is it? With the card in the 6500, the tulip driver sort
>of works, sometimes. The only error message I get out of it ever is
>
>Internal fault: The skbuff addresses do not match in tulip_rx [plus hex
>output]

Which match my idea about broken cache coherency on 6400/6500 machines
and possibly other derivatives (5x00 ?).

>but this message doesn't always seem to correspond with the
>driver/interface/NIC failing. And on the 9500, the card seems to work
>significantly better than on the 6500 (but we already know the 6500
>seems to be a pathological beast in places). For example, I have
>never seen the skbuff message on the 9500, and AFAICT, the card just
>works.

Yes, cache coherency in the 9500 is much better, fortunately ;)

>Actually your comment is an interesting one. When you are saying
>"bridge" are you talking about something related to the ethernet
>function or the PCI function? Over time on the 6500, I have been
>wondering if this card's problems are related to PCI rather than
>ethernet.

I suspect the cache coherency isn't properly maintained by the
PCI host bridge, which would break drivers (or cause memory corruptions)
when DMA happens. It's not completely incoherent however, but you'd
rather avoid having cache lines shared.

de4x5 has a tweak to align descriptors so that only one exist per
cache line. This solved the problem for some 6400 users, but
that tweak must be enabled by hacking the driver a bit.

Try defining CACHE_ALIGN to CAL_32LONG, and DESC_ALIGN to u32 dummy[4]
(as in the commented out example).

If this also solve your problem, then we'll need Jeff to add a similar
tweak to tulip, possibly as a config option.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
