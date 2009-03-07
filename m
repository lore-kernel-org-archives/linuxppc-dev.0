Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9454FDDF33
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 08:51:41 +1100 (EST)
Subject: Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Menchaca <ben.menchaca@gmail.com>
In-Reply-To: <64ac01180903060812n1f355207lb3fa6de3ed17ae41@mail.gmail.com>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
	<64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF98@zch01exm21.fsl.freescale.net>
	<64ac01180903060812n1f355207lb3fa6de3ed17ae41@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 08 Mar 2009 08:51:26 +1100
Message-Id: <1236462686.7260.161.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Liu Dave-R63238 <DaveLiu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-03-06 at 10:12 -0600, Ben Menchaca wrote:
> Testing now...it looks like it (almost) works, though!  Why does
> setting no-snoop cause snooping to work?  More on the effect on
> setting that bit in a few minutes...need more testing.

Maybe they got the documentation for that bit backward ? :-)

Cheers,
Ben.

> ACR is 0x00030300.
> 
> - Ben
> 
> On Fri, Mar 6, 2009 at 12:30 AM, Liu Dave-R63238
> <DaveLiu@freescale.com> wrote:
>         Did you enable the descriptor bit 3 to have a try?
>         
>                 
>                 ______________________________________________________
>                 From: Ben Menchaca [mailto:ben.menchaca@gmail.com] 
>                 
>                 Sent: Friday, March 06, 2009 2:10 PM
>                 
>                 
>                 To: Liu Dave-R63238
>                 Cc: linuxppc-dev@ozlabs.org
>                 Subject: Re: 83xx: Marking or Allocating Pages as
>                 Cache-Inhibited
>                 
>                 
>                 
>                 
>                 
>                 I can look at ACR morning...although I can say with a
>                 fair amount of certainty that I have not changed it
>                 from the POR value.
>                 
>                 I will try enabling No Snoop for CSB in the descriptor
>                 (bit 3, yes?)...this seems a bit counterintuitive to
>                 me.
>                 
>                 What is the hope regarding these two?  Some
>                 combination I am not seeing?
>                 
>                 
>                 On Thu, Mar 5, 2009 at 11:40 PM, Liu Dave-R63238
>                 <DaveLiu@freescale.com> wrote:
>                         what is the value of ACR register?
>                         
>                                 
>                                 ______________________________________
>                                 From: Ben Menchaca
>                                 [mailto:ben.menchaca@gmail.com] 
>                                 Sent: Friday, March 06, 2009 1:38 PM
>                                 To: Liu Dave-R63238
>                                 Cc: linuxppc-dev@ozlabs.org
>                                 Subject: Re: 83xx: Marking or
>                                 Allocating Pages as Cache-Inhibited
>                                 
>                                 
>                                 
>                                 
>                                 1.  BAT2 in linux is set to WIMG=0010,
>                                 and covers all 64M
>                                 2.  PEX_DEVICE_CONTROL in PCI-E Config
>                                 Space (0x54): 0x1020
>                                 3.  PEX_xDMA_CTRL is set to 0x00000401
>                                 at the initiation of the DMA.
>                                 4.  OWAR0 is set to 0xFFFFF005, so
>                                 NSNP is 0.
>                                 5.  The DMA descriptor (randomly
>                                 chosen when I hit a trigger...just
>                                 ignore the size...) contains 0002AFF3
>                                 at offset 0, so nosnoops are
>                                 cleared.  
>                                 
>                                 Core is 400MHz, and CSB is 133MHz.
>                                 
>                                 - Ben
>                                 
>                                 On Thu, Mar 5, 2009 at 11:27 PM, Liu
>                                 Dave-R63238 <DaveLiu@freescale.com>
>                                 wrote:
>                                         and what settings  is DMA
>                                         description bit 3?
>                                         
>                                         > -----Original Message-----
>                                         > From: linuxppc-dev-bounces
>                                         +daveliu=freescale.com@ozlabs.org
>                                         > [mailto:linuxppc-dev-bounces
>                                         +daveliu=freescale.com@ozlabs.org]
>                                         
>                                         
>                                         >  On Behalf Of Liu
>                                         Dave-R63238
>                                         > Sent: Friday, March 06, 2009
>                                         1:22 PM
>                                         > To: Ben Menchaca;
>                                         linuxppc-dev@ozlabs.org
>                                         > Subject: RE: 83xx: Marking
>                                         or Allocating Pages as
>                                         Cache-Inhibited
>                                         >
>                                         > Did you enable the snoop bit
>                                         at PEX_WDMA_CTRL[SNOOP] and
>                                         > PEX_RDMA_CTRL[SNOOP]?
>                                         >
>                                         > What is the freq settings?
>                                         CORE/CSB bus.
>                                         >
>                                         > Thanks, Dave
>                                         >
>                                         >
>                                         ________________________________
>                                         >
>                                         >       From:
>                                         linuxppc-dev-bounces
>                                         +daveliu=freescale.com@ozlabs.org
>                                         > [mailto:linuxppc-dev-bounces
>                                         +daveliu=freescale.com@ozlabs.org]
>                                         >  On Behalf Of Ben Menchaca
>                                         >       Sent: Friday, March
>                                         06, 2009 12:33 PM
>                                         >       To:
>                                         linuxppc-dev@ozlabs.org
>                                         >       Subject: 83xx: Marking
>                                         or Allocating Pages as
>                                         Cache-Inhibited
>                                         >
>                                         >
>                                         >       I am working on a
>                                         Freescale 8314e design, and
>                                         the
>                                         > embedded device is
>                                         configured as a PCI-e endpoint
>                                         running a
>                                         > 2.6.27-5 kernel.  For
>                                         context, we have written a
>                                         kernel
>                                         > module which, among other
>                                         things, uses the RDMA/WDMA
>                                         engine
>                                         > in the PCI-e IP block.  On
>                                         the host side, these DMAs are
>                                         > coherent.  However, on the
>                                         embedded side, things are
>                                         quite a
>                                         > bit less rosy; we must
>                                         manually flush/invalidate
>                                         cache lines
>                                         > for WDMA/RDMAs to occur
>                                         successfully.  After speaking
>                                         with
>                                         > (several) FAEs at Freescale,
>                                         we believe there is a
>                                         > configuration issue that is
>                                         the cause, but we have yet to
>                                         > have anyone successfully
>                                         point to it.
>                                         >
>                                         >       Disabling the data
>                                         cache altogether resolves the
>                                         issue
>                                         > entirely, but of course,
>                                         also completely tanks
>                                         performance.
>                                         > As a temporary workaround, I
>                                         would like to simply mark the
>                                         > pages (obtained currently
>                                         via dma_alloc_coherent)
>                                         involved as
>                                         > cache-inhibited.  I have
>                                         attempted to do this via some
>                                         > snippets remaining in fec.c
>                                         (va_to_pte, uncache_pte to set
>                                         > _PAGE_NO_CACHE,
>                                         flush_tlb_page, then
>                                         unmap_pte), but this is
>                                         > almost certainly braindead;
>                                         va_to_pte is not a part of the
>                                         > 83xx source, as far as I can
>                                         tell; 8xx only.
>                                         >
>                                         >       A quick pointer in the
>                                         correct direction for marking
>                                         > pages as cache-inhibited on
>                                         a 2.6.27-5 kernel would be
>                                         > appreciated, or if my
>                                         approach to a workaround is
>                                         flawed, a
>                                         > pointer to the correct way
>                                         would be great.
>                                         >
>                                         >       Ben Menchaca
>                                         >
>                                         >
>                                         
>                                         >
>                                         _______________________________________________
>                                         > Linuxppc-dev mailing list
>                                         > Linuxppc-dev@ozlabs.org
>                                         >
>                                         https://ozlabs.org/mailman/listinfo/linuxppc-dev
>                                         >
>                                         >
>                                 
>                                 
>                 
>                 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
