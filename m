Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5305D67BB4
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 13:51:23 +1000 (EST)
Subject: RE: [PATCH] qe_ic: Do a sync when masking interrupts.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D2071C2@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D2071C2@zch01exm20.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 13:51:14 +1000
Message-Id: <1161748274.22582.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-24 at 15:17 +0800, Li Yang-r58472 wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:scottwood@freescale.com]
> > Sent: Tuesday, October 24, 2006 2:27 AM
> > To: Segher Boessenkool
> > Cc: mrz5149@acm.org; Li Yang-r58472; Paul Mackerras;
> linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
> > 
> > Segher Boessenkool wrote:
> > > If a sync after an MMIO write is enough, then (in almost all
> > > cases) so is an eieio.
> > 
> > In this case, the spurious interrupts still happen with eieio, but not
> > with sync.  
> 
> eieio on e300 core is just a no-op.

It's not sent to the bus on non-cahed storage (like the PCI bridge ?)
That's pretty bad ... there is quite a bit of code that assumes that
eieio's will prevent write combining...

Ben.
