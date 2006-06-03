Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64AC867AC7
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 10:40:50 +1000 (EST)
Subject: Re: [PATCH] [2.6.18] U4 DART improvements
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <61e1e9d0ada7e9648b8590cfac2b67b9@kernel.crashing.org>
References: <20060602040426.GA28528@pb15.lixom.net>
	<61e1e9d0ada7e9648b8590cfac2b67b9@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 10:40:38 +1000
Message-Id: <1149295238.7972.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-02 at 14:44 +0200, Segher Boessenkool wrote:
> Hi Olof,
> 
> Looks good.  One request:
> 
> > +static inline void dart_tlb_invalidate_one(unsigned long bus_rpn)
> > +{
> > +	unsigned int reg;
> > +	unsigned int l, limit;
> > +
> > +	reg = DART_CNTL_U4_ENABLE | DART_CNTL_U4_IONE |
> > +		(bus_rpn & DART_CNTL_U4_IONE_MASK);
> > +	DART_OUT(DART_CNTL, reg);
> > +	mb();
> 
> Could you please comment the memory barriers, to say exactly _why_ a
> certain barrier is needed?  I can't see why wmb() wouldn't work here,
> for example (note I'm not saying it would -- I just don't see why it
> wouldn't).
> 
> Same goes for every single memory barrier in the whole kernel source
> code, but I have to start somewhere, heh.

In fact I doubt we need a barrier at all...

Ben.
