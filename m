Message-ID: <000f01c28b67$8f14e9c0$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Hans Feldt" <Hans.Feldt@uab.ericsson.se>,
	<linuxppc-embedded@lists.linuxppc.org>, <scop@digitel.com.br>,
	<thomas@corelatus.com>
References: <IGEFJKJNHJDCBKALBJLLAEPLFHAA.joakim.tjernlund@lumentis.se> <001c01c28b4b$28665b80$4f158a86@default> <002901c28b5a$55f60820$0200a8c0@telia.com> <3DD2CE30.6090708@embeddededge.com>
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 2
Date: Wed, 13 Nov 2002 23:54:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > OK, anyone against? Dan?
>
> I'm currently looking at the patches and I'll be integrating something
> that hopefully works :-)
Please tell me if there is something in that patch you don't like(besides the
moving the invalidate call).

>
> This isn't something new that hasn't been tried before.  The problem
> in the past with non-coherent processors, incoming DMA, and skbufs is
> the buffers would share cache lines with other data which would get
> corrupted as the result of the invalidate for the DMA.  Typically,
> data that was corrupted were flags and control information for the IP
> stack, and under "normal" use you wouldn't notice this.  However,
> forwarding/bridging applications would fail to work properly and you
> would sometimes see packet retransmits that weren't necessary.
>
> The "trick" is to ensure you allocate a larger than necessary sk buffer
> and then align the start and end such that they consume entire cache
> lines.  There has been sufficient discussion about this that I hope
> the sk buffer mechanism will allow this alignment now, as it didn't
> work well in the past.  This is what I want to check out when I
> apply and test the patches.

Tell me about it, I got severely bitten by a non cache aligned invalidate call
in the i2c-algo-8xx.c driver :-(

I too checked carefully that the buffer returned from __dev_alloc_skb()/dev_alloc_skb()
cache aligned, turns out that it kmalloc's a buffer and reserves 16 bytes in the
beginning so it's safe.

>
> This isn't necessary on the 8260 family due to cache snooping, but it
> is required on the 8xx.
>
> Of course, a packet checksum still needs to be performed, and if it
> is done as part of the data copy (and if the IP stack doesn't do it
> again), it would seem that this implementation rather than DMA would
> be more efficient.

Are referring to eth_copy_and_sum()? That function has never done
a csum, just a plain memcpy(). The IP stack has always done
it's own csum(just as well since it would be doing this in IRQ context),
unless you set ip_summed(I think).

Perhaps a backwards memcpy() would be more efficient? That way
the  IP header get copied last and will be in cache longer. I believe memmove()
will do that.

Some drivers also try cache align the IP header. I tried that to but
eth_type_trans() could not handle this.

Finally, why does passing the Ethernet CRC upwards mess-up bridging applications?

        Jocke
>
> Thanks.
>
>
> -- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
