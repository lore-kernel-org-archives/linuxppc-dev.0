Date: Wed, 28 Mar 2001 13:47:48 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>, <phandel@cise.ufl.edu>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
In-Reply-To: <20010328083727.6F528DB9E9@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.31.0103281320010.21214-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Mar 2001, Iain Sandoe wrote:

>
> Hi,
>
> attached is a replacement for the dmasound_awacs tx_irq routine to test out
> Takashi's idea of clearing the DEAD status and then re-starting dma.
>
> it is *not* a diff - you will have to replace the routine by cut-and-paste
>
> (I've done it this way because my current tree has lots of other changes
> which aren't relevant to this test).
>
> I checked it builds - but can't test 'cos I don't have a PowerComputing
> machine.
>
> Please try it with big-ish fragments - so that there is a chance of hearing
> whether resumed blocks repeat sound.

With a quick look it doesn't seem that it will work, you only need to return
if you restart the frame otherwise the driver will deadlock, here is what i
do at the moment, its not perfect but its the best we can do i think without
the emergency dbdma_cmd.

Do we need the in_le32(&awacs_txdma->status) & RUN check ? isn't dbdma
already inactive at that point ?


  Kostas

.....
#define DEADFRAME_RESTART 1
                if ( ((stat & ACTIVE) == 0) ) {
                        if( stat & DEAD ) {
                                int req_count, res_count;

                                req_count = ld_le16(&cp->req_count);
                                res_count = ld_le16(&cp->res_count);

                                /*
                                printk("dmasound: status = 0x%x\n",stat);
                                printk("dmasound: req_count = %d\n",req_count);
                                printk("dmasound: res_count = %d\n",res_count);
                                */

                                out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE|DEAD) << 16);
                                st_le16(&cp->xfer_status, 0);

#if(DEADFRAME_RESTART)
                                st_le16(&cp->req_count, res_count);
                                out_le32(&awacs_txdma->cmdptr, virt_to_bus(cp));
#endif

                                out_le32(&awacs_txdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));

#if(DEADFRAME_RESTART)
                                return;
#endif
                        } else {
........


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
