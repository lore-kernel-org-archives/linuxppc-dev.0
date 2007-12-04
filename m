Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A908FDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 18:39:22 +1100 (EST)
Subject: RE: [PATCH] ipic: change ack operation that register
	isaccessedonly when needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF029708189001B4D360@zch01exm26.fsl.freescale.net>
References: <1196684780-28408-1-git-send-email-leoli@freescale.com>
	<1196715747.13230.233.camel@pasglop>
	<989B956029373F45A0B8AF029708189001B4D2DE@zch01exm26.fsl.freescale.net>
	<1196734556.13230.258.camel@pasglop>
	<989B956029373F45A0B8AF029708189001B4D360@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 18:39:05 +1100
Message-Id: <1196753945.13230.280.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-04 at 15:23 +0800, Li Yang wrote:
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> > Sent: Tuesday, December 04, 2007 10:16 AM
> > To: Li Yang
> > Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org
> > Subject: RE: [PATCH] ipic: change ack operation that register 
> > isaccessedonly when needed
> > 
> > 
> > On Tue, 2007-12-04 at 10:06 +0800, Li Yang wrote:
> > > > That should be handled by the higher level flow handler. 
> > The generic 
> > > > edge one calls ack and the level one mask_and_ack.
> > > > Just make them do the right thing, no need to test for 
> > the flow type 
> > > > in the low level function.
> > > 
> > > But actually ack is called by edge and per cpu handlers.  
> > Mask_and_ack 
> > > is also called by edge handler when the same interrupt is 
> > already in 
> > > progress.  So I don't think that ack/mask_and_ack 
> > implicates flow type 
> > > by design.
> > 
> > They do and you can pass different irq_chip with different 
> > mask/ack routines if necessary.
> Hi Ben,
> 
> I mean that mask_ack_irq() routine is used by both generic
> handle_edge_irq() and handle_level_irq().  mask_ack_irq doesn't know if
> the flow type is level or edge.  Do you suggest to use different
> irq_chip for level and edge?

That would be an option. I dislike testing the flow type in the fast
path.

Ben.
