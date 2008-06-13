Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83514.mail.sp1.yahoo.com (web83514.mail.sp1.yahoo.com
	[216.252.120.170]) by ozlabs.org (Postfix) with SMTP id 2378EDDF43
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 09:52:33 +1000 (EST)
Date: Fri, 13 Jun 2008 16:52:32 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <094E5361-18FC-47D7-BB7C-8A8AF89DBEC1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <470944.9117.qm@web83514.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't know why request_irq is succeeding when the fsldma and dmaengine drivers are installed. 
I'm using the same dts in both cases.

Ron
--- Kumar Gala <galak@kernel.crashing.org> wrote:

> That's a bit odd.  How is your driver getting the IRQ its requesting?   
> Are you using the same .dts in both cases?
> 
> - k
> 
> On Jun 13, 2008, at 2:02 PM, Ron Madrid wrote:
> 
> > So after I've built the kernel to include the dmaengine and fsldma  
> > drivers, my driver is allowed
> > to register its ISR via request_irq.  However, if these drivers are  
> > not installed then request_irq
> > fails in my driver.  So it seems that there is some other  
> > initialization happening before
> > request_irq is being called in fsldma and subsequently my driver.   
> > Does anyone know what this is?
> >
> > Ron
> > --- Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> >> The dmaengine provides a generic set of APIs w/a FSL dma backend.  It
> >> might be the case that your need of dma doesnt fit into the current
> >> set of APIs.
> >>
> >> - k
> >>
> >> On Jun 12, 2008, at 3:04 PM, Ron Madrid wrote:
> >>
> >>> Well in that case wouldn't I need to use the fsldma driver?  Or is
> >>> dmaengine a generic dma driver?
> >>>
> >>> Ron
> >>> --- Kumar Gala <galak@kernel.crashing.org> wrote:
> >>>
> >>>>
> >>>> On Jun 12, 2008, at 2:35 PM, Ron Madrid wrote:
> >>>>
> >>>>> I'm trying to write a driver that would make use of the DMA on the
> >>>>> MPC8313.  I'm attempting to
> >>>>> register the interrupt with request_irq but it is not passing.  Is
> >>>>> there something that I need to
> >>>>> do before I call request_irq, maybe in the dts or somewhere else?
> >>>>
> >>>>
> >>>> any reason you aren't using the dmaengine driver?
> >>>>
> >>>> - k
> >>>>
> >>
> >>
> 
> 
