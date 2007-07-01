Return-Path: <geert@linux-m68k.org>
Received: from ananke.telenet-ops.be (ananke.telenet-ops.be [195.130.137.78])
	by ozlabs.org (Postfix) with ESMTP id 59F43DDF73
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2007 09:24:34 +1000 (EST)
Date: Mon, 2 Jul 2007 01:24:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] ppc: remove APUS support
In-Reply-To: <20070701230843.GD10869@stusta.de>
Message-ID: <Pine.LNX.4.64.0707020114220.30442@anakin>
References: <20070701202206.GO10869@stusta.de>
	<Pine.LNX.4.64.0707020053530.30442@anakin>
	<20070701230843.GD10869@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Jul 2007, Adrian Bunk wrote:
> On Mon, Jul 02, 2007 at 12:55:36AM +0200, Geert Uytterhoeven wrote:
> > On Sun, 1 Jul 2007, Adrian Bunk wrote:
> > > Current status of APUS:
> > > - arch/powerpc/: a patch to remove it is in powerpc.git
> > > - arch/ppc/: marked BROKEN since 2 years
> > > 
> > > This patch therefore removes the remaining parts of APUS support.
> > 
> > > --- linux-2.6.22-rc6-mm1/include/asm-m68k/pgtable.h.old	2007-06-30 01:23:33.000000000 +0200
> > > +++ linux-2.6.22-rc6-mm1/include/asm-m68k/pgtable.h	2007-06-30 01:23:43.000000000 +0200
> > > @@ -107,8 +107,6 @@ extern void *empty_zero_page;
> > >  /* 64-bit machines, beware!  SRB. */
> > >  #define SIZEOF_PTR_LOG2			       2
> > >  
> > > -#define mm_end_of_chunk(addr, len)	0
> > > -
> > >  extern void kernel_set_cachemode(void *addr, unsigned long size, int cmode);
> > >  
> > >  /*
> > > --- linux-2.6.22-rc6-mm1/drivers/scsi/a2091.c.old	2007-06-30 01:23:53.000000000 +0200
> > > +++ linux-2.6.22-rc6-mm1/drivers/scsi/a2091.c	2007-06-30 01:24:08.000000000 +0200
> > > @@ -46,8 +46,7 @@ static int dma_setup(struct scsi_cmnd *c
> > >      struct Scsi_Host *instance = cmd->device->host;
> > >  
> > >      /* don't allow DMA if the physical address is bad */
> > > -    if (addr & A2091_XFER_MASK ||
> > > -	(!dir_in && mm_end_of_chunk (addr, cmd->SCp.this_residual)))
> > > +    if (addr & A2091_XFER_MASK)
> > >      {
> > >  	HDATA(instance)->dma_bounce_len = (cmd->SCp.this_residual + 511)
> > >  	    & ~0x1ff;
> > > --- linux-2.6.22-rc6-mm1/drivers/scsi/a3000.c.old	2007-06-30 01:24:17.000000000 +0200
> > > +++ linux-2.6.22-rc6-mm1/drivers/scsi/a3000.c	2007-06-30 01:24:26.000000000 +0200
> > > @@ -54,8 +54,7 @@ static int dma_setup(struct scsi_cmnd *c
> > >       * end of a physical memory chunk, then allocate a bounce
> > >       * buffer
> > >       */
> > > -    if (addr & A3000_XFER_MASK ||
> > > -	(!dir_in && mm_end_of_chunk (addr, cmd->SCp.this_residual)))
> > > +    if (addr & A3000_XFER_MASK)
> > >      {
> > >  	HDATA(a3000_host)->dma_bounce_len = (cmd->SCp.this_residual + 511)
> > >  	    & ~0x1ff;
> > > --- linux-2.6.22-rc6-mm1/drivers/scsi/gvp11.c.old	2007-06-30 01:24:35.000000000 +0200
> > > +++ linux-2.6.22-rc6-mm1/drivers/scsi/gvp11.c	2007-06-30 01:24:46.000000000 +0200
> > > @@ -54,8 +54,7 @@ static int dma_setup(struct scsi_cmnd *c
> > >      static int scsi_alloc_out_of_range = 0;
> > >  
> > >      /* use bounce buffer if the physical address is bad */
> > > -    if (addr & HDATA(cmd->device->host)->dma_xfer_mask ||
> > > -	(!dir_in && mm_end_of_chunk (addr, cmd->SCp.this_residual)))
> > > +    if (addr & HDATA(cmd->device->host)->dma_xfer_mask)
> > >      {
> > >  	HDATA(cmd->device->host)->dma_bounce_len = (cmd->SCp.this_residual + 511)
> > >  	    & ~0x1ff;
> > 
> > These seem to be completely unrelated to removing APUS support?
> 
> For APUS mm_end_of_chunk() was an actual function, otherwise it was 
> always 0.

Oops, you're right.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
