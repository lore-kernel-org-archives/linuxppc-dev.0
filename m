From: Benjamin Herrenschmidt <bh40@calva.net>
To: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>,
        "T.R.
 Kobayashi" <tkoba@ike-dyn.ritsumei.ac.jp>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCMCIA card eject does not work?
Date: Fri, 22 Sep 2000 18:56:53 +0200
Message-Id: <19340817102837.20051@mailhost.mipsys.com>
In-Reply-To: <39CB407E.DF3494EF@mpifr-bonn.mpg.de>
References: <39CB407E.DF3494EF@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Thanks for your links... Your patches do indeed eject a CardBus card on my
>Wallstreet. Great! However, I think the mechanics is a little problematic on
>this box, as the card sometimes seems to have contact to the connector
>after the
>eject. This leads to an immediate re-recognition of the card, and as the
>contact
>is everything but perfect, I get a panic. Maybe I try to file more than one
>eject command to the PMU and see what happens...

Here, 2.4 may help. I think the PCMCIA layer has some de-bouncing
mecanism, and inb/outb should no longer cause a panic when accessing non-
existent HW. For memory-mapped devices, you may still have a problem,
which could be solved by the oops patch (in linuxppc_2_5 but not in _2_3
yet) which would cause the driver to oops rather than panic (well, in
most cases...)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
