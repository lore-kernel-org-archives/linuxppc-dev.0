Date: Tue, 22 Dec 1998 02:11:47 -0800
Message-Id: <199812221011.CAA09825@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        linux-m68k@lists.linux-m68k.org
In-reply-to: 
	<Pine.LNX.4.03.9812221039490.5727-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Tue, 22 Dec 1998 11:01:13 +0100
	(CET))
Subject: Re: TCPv4 checksum errors
References: <Pine.LNX.4.03.9812221039490.5727-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Date: Tue, 22 Dec 1998 11:01:13 +0100 (CET)
   From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>

   On Tue, 22 Dec 1998, David S. Miller wrote:
   > My suggestion is that since you can reproduce it, you should add code
   > next to this printk statement which dumps the entire packet in HEX to
   > the console.  Then you can see what and who is at fault and where.
   > If the packet is sufficiently small you can walk the checksum
   > algorithm by hand and verify it for this test case.

   Which one do I have to dump? skb->h.raw or skb->nh.raw? I guess
   skb->nh.iph->tot_len bytes at skb->nh.raw?

Look at what the code next to the printk is verifying:

		skb->csum = csum_partial((char *)th, len, 0);
		if (tcp_v4_check(th,len,skb->nh.iph->saddr,skb->nh.iph->daddr,skb->csum))

So you need all the bytes from 'th' to 'th + len'.  You also need the
values of the source and destination addresses from the IP header (at
skb->nh.iph->{saddr,daddr}).

Good luck.

Later,
David S. Miller
davem@dm.cobaltmicro.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
