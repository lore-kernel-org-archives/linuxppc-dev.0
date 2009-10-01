Return-Path: <bones@secretlab.ca>
Received: from mail-fx0-f208.google.com (mail-fx0-f208.google.com
	[209.85.220.208]) by ozlabs.org (Postfix) with ESMTP id 55C7BB7BD2
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 04:45:35 +1000 (EST)
Received: by fxm4 with SMTP id 4so455155fxm.40
	for <linuxppc-dev@ozlabs.org>; Thu, 01 Oct 2009 11:45:32 -0700 (PDT)
Subject: Re: [PATCH] powerpc/5200: add LocalPlus bus FIFO device driver
From: John Bonesio <bones@secretlab.ca>
To: Albrecht =?ISO-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
In-Reply-To: <1254335663.3681.0@antares>
References: <1254335663.3681.0@antares>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Oct 2009 11:45:21 -0700
Message-Id: <1254422721.689.0.camel@riker>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Albrecht,

Thanks for the comments. My replies are below.

- John

On Wed, 2009-09-30 at 20:34 +0200, Albrecht Dreß wrote:
> Hi John:
> 
> Cool stuff - Grant's original one also helped me a lot to get Bestcomm  
> running for me (I use it only for read dma)!
> 
> Am 29.09.09 22:43 schrieb(en) John Bonesio:
> [snip]
> > +		 * It may be worth experimenting with the ALARM value  
> > to see if
> > +		 * there is a performance impacit.  However, if it is  
> > wrong there
> > +		 * is a risk of DMA not transferring the last chunk of  
> > data
> > +		 */
> > +		if (write) {
> > +			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM,  
> > 0x1e4);
> > +			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL,  
> > 7);
> > +			lpbfifo.bcom_cur_task = lpbfifo.bcom_tx_task;
> > +		} else {
> > +			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM,  
> > 0x1ff);
> > +			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL,  
> > 0);
> > +			lpbfifo.bcom_cur_task = lpbfifo.bcom_rx_task;
> 
> Hmmm, the MPC5200B User's manual, sect. 9.7.3.3 LPC Rx/Tx FIFO Control  
> Register (pg. 323) seems to imply that only 0 or 1 are valid settings  
> here.  Where does the 7 come from?

When I read that section, I read that GR is a 3 bit field for high water
mark (the number of free bytes * 4). I didn't read that 0 and 1 are the
only possible values, but that those are two example values to help the
reader understand the meaning of the field.

Nowhere in the text does it say 0 and 1 are the only possible values.
And since GR is a 3 bit field instead of a 1 bit field, that implied
that to me that other values are allowed.

I can see how one could read the text as saying 0 and 1 are the only
values allowed. However, empirical the testing I've done, seems to
indicate that the '7' is a valid value, as it produced different
behavior than 1.

> 
> [snip]
> > +			 * In the DMA read case, the DMA doesn't  
> > complete,
> > +			 * possibly due to incorrect watermarks in the  
> > ALARM
> > +			 * and CONTROL regs. For now instead of trying  
> > to
> > +			 * determine the right watermarks that will  
> > make this
> > +			 * work, just increase the number of bytes the  
> > FIFO is
> > +			 * expecting.
> 
> My experience is that for reads I have to set a granularity of 0 (as  
> you already do) *and* set the 'flush' bit in the SCLPC Control  
> Register.  See the remarks for that bit in the MPC5200B User's manual,  
> pg. 318.  With these settings and my driver, I made several tests  
> reading blocks (in one Bestcomm operation) between 16 bytes and 2  
> MBytes, and *never* had any problem, so your remark here makes me  
> somewhat nervous!

I've put in the suggested change to set the 'flush' bit. It didn't seem
to help. I'm not sure what else might be different between my system and
yours.

I agree that this solution feels "hacky" and is probably not a good long
term solution. I think this solution may need to stay in temporarily
until we can discover a better one.

> 
> In my dma read tests, the watermark (LPC Rx/Tx FIFO Alarm Register)  
> seems to have only a (small) performance impact.  If I set the  
> watermark to 0 (i.e. fill the fifo completely), I *never* saw any  
> under- or overruns.  My assumption is that the fifo would stop reading  
> the peripheral when it is full, and only resume when Bestcomm emptied  
> it at least partly.  You you know if that is really the case?

We were testing using the Bestcomm on a framebuffer to refresh the
display. Without the watermarks, the DMA was getting clogged.

> 
> [snip]
> > +
> > +	bit_fields = req->cs << 24 | 0x000008;
> > +	if (!write)
> > +		bit_fields |= 0x010000; /* read mode */
> 
> See above - should be "bit_fields |= 0x030000" IMHO...
> 
> [snip]
> > +	/* Request the Bestcomm receive (fifo --> memory) task and IRQ  
> > */
> > +	lpbfifo.bcom_rx_task =
> > +		bcom_gen_bd_rx_init(2, res.start +  
> > LPBFIFO_REG_FIFO_DATA,
> > +				    BCOM_INITIATOR_SCLPC,  
> > BCOM_IPR_SCLPC,
> > +				    16*1024*1024);
> 
> Is the limit really correct?  The manual (sect. 9.7.2.1 SCLPC Packet  
> Size Register, pg. 316) says the maximum packet size is 16 M - 1 byte.

You are right. I've made the fix. A new patch will go out soon.

> 
> Cheers,
> Albrecht.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
