To: ppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ethernet on 8260 
In-Reply-To: Message from Brad Bonkoski <bradb59@home.com>
   of "16 Jul 2001 17:19:36 MST." <20010717002518.YUJE5550.femail18.sdc1.sfba.home.com@cx263713-b.mesa1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jul 2001 14:22:21 +1000
Message-ID: <26051.995343741@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 16 Jul 2001 17:19:36 -0700, Brad Bonkoski <bradb59@home.com> writes:
>Essentailly, I have them all set up on the same
>network: 192.168.0.X.

Use different IP network numbers for each ethernet interface. e.g.

FCC1 - eth0 - 192.168.1.x
FCC2 - eth1 - 192.168.2.x
FCC3 - eth2 - 192.168.3.x

(assuming a netmask of 255.255.255.0). If they all have the same IP *network*
number (i.e. the number is the same after applying the netmask), then Linux
will only use one of them. In other words, you can only have one route for
each subnet.

By the way, if you want Linux to forward packets between the interfaces, then
ensure you enable forwarding (echo 1 > /proc/sys/net/ipv4/ip_forward).

Also, you could by-pass all this IP stuff and do things at the ethernet level
(using a RAW socket?). Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
