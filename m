Date: Tue, 22 Dec 1998 11:38:01 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "David S. Miller" <davem@dm.cobaltmicro.com>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        linux-m68k@lists.linux-m68k.org
Subject: Re: TCPv4 checksum errors
In-Reply-To: <199812221011.CAA09825@dm.cobaltmicro.com>
Message-ID: <Pine.LNX.4.03.9812221133590.9840-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Dec 1998, David S. Miller wrote:
>    Date: Tue, 22 Dec 1998 11:01:13 +0100 (CET)
>    From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
> 
>    On Tue, 22 Dec 1998, David S. Miller wrote:
>    > My suggestion is that since you can reproduce it, you should add code
>    > next to this printk statement which dumps the entire packet in HEX to
>    > the console.  Then you can see what and who is at fault and where.
>    > If the packet is sufficiently small you can walk the checksum
>    > algorithm by hand and verify it for this test case.
> 
>    Which one do I have to dump? skb->h.raw or skb->nh.raw? I guess
>    skb->nh.iph->tot_len bytes at skb->nh.raw?
> 
> Look at what the code next to the printk is verifying:

Ooch, didn't notice there was no `break' in between the two cases...

> 		skb->csum = csum_partial((char *)th, len, 0);
> 		if (tcp_v4_check(th,len,skb->nh.iph->saddr,skb->nh.iph->daddr,skb->csum))
> 
> So you need all the bytes from 'th' to 'th + len'.  You also need the
> values of the source and destination addresses from the IP header (at
> skb->nh.iph->{saddr,daddr}).

Thanks! Rebooting...

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
