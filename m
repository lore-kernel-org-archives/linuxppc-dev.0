Date: Mon, 03 Feb 2003 11:21:37 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 3
In-reply-to: <IGEFJKJNHJDCBKALBJLLCEKKFJAA.joakim.tjernlund@lumentis.se>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIENMFJAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > This is the second version of my patch that removes the expensive memcpy of
> > received
> > ethernet frames in interrupt context.
> >
> > I have 1 report(from Ricardo Scop) of 20% increase in packets/second, packet
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
>
> Hi
>
> This is the third version of my optimized enet.c patch.
> Changes since version 2:
>   1) invalidate the whole buffer BEFORE it is given to he CPM. Previously
>      it was invalidated after the packet was received and that could lead to buffer
>      corruption in some cases.
>
>   2) use dma_cache_inv() instead of invalidate_dcache_range() since that will work
>      for both 8xx and 82xx.
>
>   3) decrease the allocated buffer length.
>
>   4) disabled COPY_SMALL_FRAME. Define it somewhere if you want to save some memory.
>
>   5) probably some white space changes got in too.
>
> Any chance to see it the devel tree?
>
> More than 3 months has passed since version 2 and the only problem reported was
> 1) and the fix has been know since mid November.
>
> Dan, you said you would integrate this patch(or some version of it) in November. I
> think I have waited long enough now. Please do ASAP.
>
>  Jocke
[SNIP]

Zero feedback so far. Is there zero interest to improve the mpc code in linuxppc?
Anyhow, I give up. Don't have the energy to resend over and over again.

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
