Message-Id: <200401062203.QAA15156@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-2"
From: Samo Pogacnik <samo.pogacnik@s5.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory problem with fec on 8250
Date: Tue, 6 Jan 2004 23:03:14 +0100
References: <200401041555.JAA03904@lists.linuxppc.org> <200401052252.QAA10493@lists.linuxppc.org> <3FFA682D.1030402@dgt-lab.com.pl>
In-Reply-To: <3FFA682D.1030402@dgt-lab.com.pl>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 06 January 2004 08:47, Wojciech Kromer wrote:
> sure, just 4 lines addes
>
> >did you free skbuffs from the irq handler or somewhere else?
>
> just before allocation
>
> >when i run netperf (snapshot) test using the 100Mbps connection, this
> >test eats all the available RAM. the /proc/meminfo shows that most
> >of the used memory at that point is been held by internal kernel
> >structures (Slab).
>
> better reults are shwn with grep skb /proc/slabinfo
>
> here it is:
	.
	.
	.
Thank you for the tips and the patch.
Eth seems to be working now without eating the RAM.

By the way that you have solved the problem, I suspect that BDs are written
over the dirty_tx limit, before their associated skbs get freed via the irq
handler.

bye, Samo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
