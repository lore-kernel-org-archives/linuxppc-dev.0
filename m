Message-ID: <XFMail.000731090136.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000730071543.1508E-100000@ofey.inetnebr.com>
Date: Mon, 31 Jul 2000 09:01:36 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Takashi Oe <toe@unlserve.unl.edu>
Subject: Re: Stealth port problems
Cc: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I've just tried the old non-dma code. Same problem :-(((
>
> If so, could you check if you have DMA enabled with dma code?
>
>       $ cat /proc/interrupts
>            CPU0
>         2:          0   PMAC-PIC      MACE-txdma
>         3:          0   PMAC-PIC      MACE-rxdma
>         4:          0   PMAC-PIC      SCC-txdma
>         5:          0   PMAC-PIC      SCC-rxdma
>         6:          0   PMAC-PIC      SCC-txdma
>         7:      15593   PMAC-PIC      SCC-rxdma
>         8:         17   PMAC-PIC      AWACS out
>        12:          7   PMAC-PIC      53C94
>        13:    3411091   PMAC-PIC      MESH
>        14:          0   PMAC-PIC      MACE
>        15:          0   PMAC-PIC      SCC
>        16:     594667   PMAC-PIC      SCC
>        17:          0   PMAC-PIC      AWACS
>        18:     991629   PMAC-PIC      VIA
>        19:          0   PMAC-PIC      SWIM3
>        25:          0   PMAC-PIC      usb-ohci, ohci-usb
>       BAD:          0
>       $
>
> If you don't see "SCC-rxdma", then it's not enabled.

Uhmm, IFAI can remember, there wasn't any SCC-XXdma (the G3 is at home, I'm
writing from workplace).

> The reason I ask is
> that a G3-blue's SCC device node has more than three addresses if I
> remember correctly, and, if that's the case, the dma code won't be enabled
> due to the following sniplet in chan_init() of macserial.c:
>
>#if !defined(CONFIG_KGDB) && defined(SUPPORT_SERIAL_DMA)
>       if (ch->n_addrs == 3 && ch->n_intrs == 3)
>               zss->has_dma = 1;
>#endif
>
> It can be fixed if the above is changed to something like:
>
>#if !defined(CONFIG_KGDB) && defined(SUPPORT_SERIAL_DMA)
>       if (ch->n_addrs >= 3 && ch->n_intrs == 3)
>               zss->has_dma = 1;
>#endif
>
> I think the last two addresses correspond to DMA addresses for all
> SCC capable machines so far, so this change should be ok.

Ok, this night I'll try this. Tnx.


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
