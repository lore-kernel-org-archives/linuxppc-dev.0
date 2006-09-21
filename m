Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 54B5267BB2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 01:23:26 +1000 (EST)
Date: Thu, 21 Sep 2006 19:21:37 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 4/11] qe_lib: Add QE I/O ports API
Message-ID: <20060921192137.5c6af005@vitb.ru.mvista.com>
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9399B44EF@tmnt04.transmode.se>
References: <F6AD7E21CDF4E145A44F61F43EE6D9399B44EF@tmnt04.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 Sep 2006 16:52:14 +0200
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> Hi Leo
> 
> As you know I working with your earlier patches, trying to adopt them
> for
> 8321. Everthing works but ethernet on UCC2 and UCC4, ethernet on UCC3
> works though.
> 
> Anyhow I found some minor changes I had to do to match 8321 that is
> generic 83xx code.
> Below is the first:
> > ---
> >  arch/powerpc/sysdev/qe_lib/qe_io.c |  272 
> > +#define NUM_OF_PAR_IOS  7
> 
> NUM_OF_PAR_IOS is 4 on 8321
> 
> > +static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] = {
> > +	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /* 
> > 24 - 31 */
> > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0, 
> > 0,0,0,0,0,1,1,0},
> > +	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 
> > 0,0,1,1,0,0,0,0},
> > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 
> > 0,0,0,1,1,1,0,0},
> > +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0, 
> > 0,0,1,1,0,0,0,0},
> > +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 
> > 1,1,1,1,0,0,0,1},
> > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0, 
> > 0,0,0,0,0,0,0,0},
> > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 
> > 0,0,0,0,0,0,0,1}
> > +};
> 
> qe_irq_ports is diffrent on 8321 not only the number of rows.
> 
> These needs to configuruable based on CPU model and/or type of board.
>

Well, eventually this stuff aims to serve not 83xx/qe, but for cpm(1,2)-equipped stuff
too. Apparently, we'll have to do something wise to afford that...

OTOH, this is good as a starting point I guess.

-- 
Sincerely, 
Vitaly
