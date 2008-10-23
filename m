Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 38730DDF10
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 18:51:00 +1100 (EST)
Date: Thu, 23 Oct 2008 08:22:53 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: XICS - fix getting the server number size
Message-ID: <20081023082253.68c7450d@bull.net>
In-Reply-To: <42ab1a117d74e33d84cb037bfe79fae0@bga.com>
References: <20081022163632.2c67a53d@bull.net>
	<42ab1a117d74e33d84cb037bfe79fae0@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Tim Chavez <tinytim@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Oct 2008 15:34:52 -0500 Milton Miller <miltonm@bga.com> wrote:

> 
> On Oct 22, 2008, at 9:36 AM, Sebastien Dugue wrote:
> 
> >
> >   The 'ibm,interrupt-server#-size' properties are not cpu nodes 
> > properties,
> > but rather live under the interrupt source controller nodes (compatible
> > ibm,ppc-xics).
> >
> >   Therefore, this patch moves the detection of this property outside of
> > xics_update_irq_servers() and into xics_init_IRQ().
> >
> 
> yes, PAPR says its on one of the interrupt nodes.   I am too tired to
> decipher if it on the presentation or source.

  Interrupt source nodes. I tried to check the device tree on a POWER5
box, but all those we have here are running LPAR'ed AIX and I'm not sure
the DT dump tool is not lying to me and filtering the interesting stuff
(not interrupt nodes reported).

> 
> 
> Acked-by: Milton Miller <miltonm@bga.com>
> 
> >   Also this adds a check for mismatched sizes across the interrupt 
> > source
> > controller nodes. Not sure this is necessary as in this case the 
> > firmware
> > might be seriously busted.
> 
> I am hoping you have tested this?  A POWER6 box?

  Yep, on a POWER6 box doing cpu off/onlining. Unfortunately I don't have
a POWER5 box running Linux right now to test on.

> 
> Last time I looked (POWER5 timeframe) firmware was ignoring the 
> parameter
> to set-indicator(gqirm) which is the only use of this property.

  Right, the POWER6 also seems to ignore this, but it will avoid being
bitten the day this changes.

  Thanks,

  Sebastien.
