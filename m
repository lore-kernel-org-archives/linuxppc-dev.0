Date: Tue, 26 Mar 02 18:37:29 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203270237.AA03006@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> First, we need to see if this is going to fit with everything else in
> 2_4/2_4_devel and then it will get implemented.

It would set a very bad example if it is implemented. In your proposal the
records containing the GT-64260 Ethernet information have no indication in them
whatsoever that they are for GT-64260 and not some other Ethernet. If you make
the gt64260_eth driver call a function to grab all bi_recs of this kind, the
next engineer who designs a board with other hard-wired Ethernet interfaces on
it besides the GT-64260 (like an MPC8260 + GT-64260 system) will be simply
stuck out of luck as the gt64260_eth driver will unceremoniously grab all
records for all Ethernets and there will be no way to tell which MAC address
belongs to each Ethernet.

Bad bad bad.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
