Date: Wed, 28 Mar 2001 09:37:24 +0100
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328083727.6F528DB9E9@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

attached is a replacement for the dmasound_awacs tx_irq routine to test out
Takashi's idea of clearing the DEAD status and then re-starting dma.

it is *not* a diff - you will have to replace the routine by cut-and-paste

(I've done it this way because my current tree has lots of other changes
which aren't relevant to this test).

I checked it builds - but can't test 'cos I don't have a PowerComputing
machine.

Please try it with big-ish fragments - so that there is a chance of hearing
whether resumed blocks repeat sound.

ciao,
Iain.

=====

static void
pmac_awacs_tx_intr(int irq, void *devid, struct pt_regs *regs)
{
 int i = write_sq.front;
 int stat;
 volatile struct dbdma_cmd *cp;

 while (write_sq.active > 0) {
  cp = &awacs_tx_cmds[i];
  stat = ld_le16(&cp->xfer_status);
  if ( ((stat & ACTIVE) == 0) ) {
   if (stat & DEAD) {
    int count = 300 ; /* > 2 samples at slowest AWACS rate */
    out_le32(&awacs_txdma->control, (RUN) << 16);
    st_le16(&cp->xfer_status, 0); /* reset the xfer status */

    /* this is a bit nasty - we could hold IRQs off for up to
       300 us
    */
    while ( (in_le32(&awacs_txdma->status) & RUN) && count--)
     udelay(1) ;
/* debug */
if (count <= 0)
 printk("dmasound_pmac: tx IRQ: timed out trying to restart DEAD dma\n") ;

    /* may as well try anyway - I guess all bets are off now */
    out_le32(&awacs_txdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));

    return; /* we want to be as quick out of here as possible */
   } else {
    break; /* this frame is still going */
   }
  }
  --write_sq.count;
  --write_sq.active;
  if (++i >= write_sq.max_count)
   i = 0;
 }

 if (i != write_sq.front)
  WAKE_UP(write_sq.action_queue);
 write_sq.front = i;

 PMacPlay();

 if (!write_sq.active)
  WAKE_UP(write_sq.sync_queue);
}

=========

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
