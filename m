Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSmLX4BVZzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 21:36:36 +1000 (AEST)
Message-ID: <1502364964.2563.64.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Date: Thu, 10 Aug 2017 21:36:04 +1000
In-Reply-To: <e1759aa5-68d0-54ef-87fd-32908ff9ffbc@kaod.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
 <20170810042849.GU13670@umbus.fritz.box>
 <e1759aa5-68d0-54ef-87fd-32908ff9ffbc@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-10 at 09:19 +0200, Cédric Le Goater wrote:
> > > > > +  /* Perform the acknowledge hypervisor to register cycle */
> > > > > +  ack = be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_REG));
> > > > 
> > > > Why do you need the raw_readw() + be16_to_cpu + mb, rather than one of
> > > > the higher level IO helpers?
> > > 
> > > This is one of the many ways to do MMIOs on the TIMA. This memory 
> > > region defines a set of offsets and sizes for which loads and 
> > > stores have different effects. 
> > > 
> > > See the arch/powerpc/include/asm/xive-regs.h file and 
> > > arch/powerpc/kvm/book3s_xive_template.c for some more usage.
> > 
> > Sure, much like any IO region.  My point is, why do you want this kind
> > of complex combo, rather than say an in_be16() or readw_be().
> > 
> 
> The code is inherited from the native backend. 
> 
> I think this is because we know what we are doing and we skip 
> the synchronization routines of the higher level IO helpers. 
> That might not be necessary for sPAPR. Ben ? 

It's a performance optimisation, we know we don't need the
sync,twi,isync crap of the higher level accessor here.

Cheers,
Ben.
