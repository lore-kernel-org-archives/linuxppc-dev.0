Message-ID: <3691F885.77C7D466@mpifr-bonn.mpg.de>
Date: Tue, 05 Jan 1999 12:33:25 +0100
From: "Albrecht =?iso-8859-1?Q?Dre=DF?=" <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Strange PMAC IDE performance problem
References: <v04011700b2b76717bf6b@[209.86.156.101]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Timothy A. Seufert wrote:
[snip]
> Needless to say, the IDE performance figures are far less than those drives
> are capable of!  Under MacOS they benchmark much higher (for example, the
[snip]

I can confirm this behaviour on my PowerBook G3/300 with almost the same rate
under 2.1.130 (the disk is an IBM DYLA 28100). Furthermore, the whole system
nearly freezes under heavy io load (I simply used a program which writes and
reads blocks of data to/from the disk using read and write calls in a loop;
during the run the reaction to console input or a "cat" needs several seconds,
etc.). I posted this problem several times, but got no reaction, so I am glad
that I am not alone ... :-(

The problem might be connected to LOADS of "Bogus interrupts" from do_IRQ in
arch/ppc/kernel/irq.c (try "dmesg" and do a "cat /proc/interrupts" before and
after your test; you will see the increase in the "BAD" line).

I think that this is a serious problem, as it makes the machine nearly unusable
fore some applications. Hope it will get fixed ;-)

Yours, Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\3                                      ----           |
| Max-Planck-Institut f"ur Radioastronomie    |\       /      /o  o\          |
| Technische Abt. Optische Interferometrie    |  \    /      |  /   |         |
| Auf dem H"ugel 69                           |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
