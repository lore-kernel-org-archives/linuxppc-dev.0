Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>, <scop@digitel.com.br>,
	<thomas@corelatus.com>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 2
Date: Fri, 1 Nov 2002 12:01:38 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLEEIOFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <IGEFJKJNHJDCBKALBJLLOEFLFHAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Tom

Will you apply this patch?  No problems reported so far.

 Jocke

> >
> > On Thu, Oct 24, 2002 at 04:23:31PM +0200, Joakim Tjernlund wrote:
> >
> > > This is the second version of my patch that removes the expensive memcpy of
> > > received
> > > ethernet frames in interrupt context.
> > >
> > > I have 1 report(from Ricardo Scop) of 20% increase in packets/second, packet
> > > size 1500 when
> > > applied to 8260 FEC(needs to be applied manually). But min packet size
> > > decreased with 10 %.
> > > This version should fix the 10% decrease case.
> > >
> > > This patch could be adapted 8xx_io/fec.c and 8260_io/enet.c and
> > > 8260/fcc_enet.c with little effort.
> > >
> > > Better fix a bug in set_multicast_list(), move the dmi list forward when
> > >     walking it(dmi = dmi->next;)
> > >
> > > New stuff:
> > >    - Configrable: copy small packets or pass them directly, see
> > > COPY_SMALL_FRAMES in code.
> > >    - Collision reporting fix form Thomas Lange.
> > >    - Don't pass receive frames which has error upwards.
> > >    - Report RX_OV errors as fifo errors, not crc errors.
> > >
> > > Please test and report any problems and performace improvements.
> >
> > All of this sounds good, but can you please break this one patch up into
> > seperate logical patches?
>
> I rather not.
>
> The logical pices in this patch are:
>  1) remove the expensive memcpy.
>    - This is the main part of the patch.
>
>  2) dmi->next fix, which is a one liner.
>     Don't pass receive frames which has error upwards.
>    - Trival stuff.
>
>  3) Collision reporting fix form Thomas Lange.
>     Report RX_OV errors as fifo errors, not crc errors.
>    - These are just minor accounting fixes.
>
> So I don't think it's worth the effort. Let's just wait a few days and see
> if it was success or not.
>
> Folks, please report you findings to the list.
>
>     Jocke
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
