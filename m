Message-ID: <002101c27ea6$ee3ad860$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <FCEAKDJJAPHPLJFINDAJCEHFCKAA.Stephan.Linke@epygi.de>
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 2
Date: Mon, 28 Oct 2002 18:24:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Stephan

> Hi Jocke,
>
> I just had a look at the code. So far it is running fine. on my board. :)
> Following question:
> In scc-enet_rx you use invalidate_dcache_range() for the skb data area.
> Why don't you do the same in scc_enet_init() for the first set of skb's?
> Isn't it required too at this place.

Thanks for trying this!

I did this in my first version, but in my second version I moved the
invalidate_dcache_range() to AFTER the ethernet frame had been received.

invalidate_dcache_range() can either be called when you add the buffer to the
HW(BD) or after you have received a packet but before you try to use it. Doing it
after has one advantage, you know the packet len and therefore you only need
to invalidate "packet len" bytes.

In my tree I also removed the "sync" instruction in  invalidate_dcache_range()
because I don't think it's needed. My contact at Motorola thinks so too.
I have been running without the sync instruction for 2-3 weeks and
has yet to see any problems. Would be intresting to hear if others
can try this out and if it gives any performance improvement.

            Jocke
>
> Thanks, Stephan
>
> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Joakim
> > Tjernlund
> > Sent: Donnerstag, 24. Oktober 2002 16:24
> > To: linuxppc-embedded@lists.linuxppc.org
> > Cc: scop@digitel.com.br; thomas@corelatus.com
> > Subject: [PATCH] arch/ppc/8xx_io/enet.c, version 2
> >
> >
> >
> > Hi
> >
> > This is the second version of my patch that removes the expensive
> > memcpy of
> > received
> > ethernet frames in interrupt context.
> >
> > I have 1 report(from Ricardo Scop) of 20% increase in
> > packets/second, packet
> > size 1500 when
> > applied to 8260 FEC(needs to be applied manually). But min packet size
> > decreased with 10 %.
> > This version should fix the 10% decrease case.
> >
> > This patch could be adapted 8xx_io/fec.c and 8260_io/enet.c and
> > 8260/fcc_enet.c with little effort.
> >
> > Better fix a bug in set_multicast_list(), move the dmi list forward when
> >     walking it(dmi = dmi->next;)
> >
> > New stuff:
> >    - Configrable: copy small packets or pass them directly, see
> > COPY_SMALL_FRAMES in code.
> >    - Collision reporting fix form Thomas Lange.
> >    - Don't pass receive frames which has error upwards.
> >    - Report RX_OV errors as fifo errors, not crc errors.
> >
> > Please test and report any problems and performace improvements.
> >
> >         Jocke
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
