Date: Fri, 6 Sep 2002 09:37:14 +0100 (BST)
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: <slowforce@zju.edu.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ATM issue: one Host Four Nodes
In-Reply-To: <200209060357.WAA15082@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.44.0209060930210.2961-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 6 Sep 2002,  wrote:


Well, if you have 2 PHYs per node you can set up the ring as you've drawn
it - i.e. with each ATM node connected by one PHY to the previous node,
and by the other PHY to the next node.  Alternatively, if you only have
one PHY per node, you can put a switch in the middle and have the host and
each node connected to the switch.

The other solution (I've just realised this) is to use an OC3 PHY.  With
this physical medium you can seperate RX and TX streams.  I suppose that
was what you were suggesting in the first place.

Alex



>
> Hi Alex，
> you mean that maybe i need an ATM switch to creat the ring topology
> how can i implement it? can you give more detail info on it?
> Regards
> Li
> 在您的来信中曾经提到:
> >From:Alex Zeffertt <ajz@cambridgebroadband.com>
> >Reply-To:
> >To: <slowforce@zju.edu.cn>
> >Subject: Re: ATM issue: one Host Four Nodes
> >
> >On Thu, 5 Sep 2002,  wrote:
> >
> >
> >In each NODE set up 1 terminated VC, and 3 switched VCs (using the
> >atm-860.o specific /proc/net/atm/switch interface).
> >
> >here's an example of how to set up a switched VC from 0.0.32 to 0.0.32
> >using the atm-860.o driver:
> >
> >echo add 0.0.32 0.0.32 1000 cbr > /proc/net/atm/switch
> >
> >           ^      ^     ^    ^
> >         from-VC to-VC  PCR  TT
> >
> >See http://mpc860sar.sourceforge.net for the source code.
> >
> >Alex
> >
> >BTW:  If you're board only has one PHY then you need an ATM switch in the
> >middle to create the ring topology.  If it's multi PHY then you will need
> >to modify the atm-860.o driver because it doesn't support this yet.  (I
> >think that multi-PHY is only available on MPC862s anyway....)
> >
> >>
> >> Hi all,
> >> We just have such a system to build.
> >>                                 ________
> >>                                 |      |
> >>                             RX  | ATM  |_TX____________________________
> >>   |---------------------------->| HOST |                              |
> >>   |                             |      |                              |
> >>   |                             |______|                              |
> >>   |                                                                   |
> >>   |      ________       ________        ________       ________       |
> >>   |      |      |       |      |        |      |       |      |       |
> >>   |   TX | ATM  | RX  TX| ATM  | RX   TX| ATM  | RX  TX| ATM  |  RX   |
> >>   |------| NODE |<------| NODE |<-------| NODE |<------| NODE |<------|
> >>          |      |       |      |        |      |       |      |
> >>          |______|       |______|        |______|       |______|
> >>              A              B               C              D
> >> It's used to perform high speed data acqusition.
> >> ATM HOST -- a pc with an ATM card
> >> ATM NODE -- MPC860 with linux-2.4.4
> >>
> >> The ATM HOST is responisble for sending controlling information to ATM NODEs
> >> and receiving data from each NODEs.
> >> The ATM NODE is responsible for performing data acqusition.
> >>
> >> As the diagram show,ATM NODEs are connected one after another.
> >> we use one VPI/VCI to identify one ATM NODE, so if the ATM HOST send the
> >> control message to ATM NODE D, the message will touch  ATM NODE A、B、C first,
> >> then ATM NODE D. In order to improve the system capacity and efficiency,
> >> the ATM NODE A、B、C should ignore this message(not parse it) and send it
> >> to the next node, in another words, this message should be bypassed in low
> >> level(e.g. PHY level) by ATM NODE A、B、C. How can i get this point?
> >> Any advice will be greatly appreciated!
> >> Best Regards!
> >> Li
> >>
> >>
> >>
> >
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
