Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 650A9B7D4C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2010 14:29:57 +1100 (EST)
Subject: Re: [PATCHv2 2/2] Update ibm,client-architecture call field based
	on device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <4B6870DF.9030408@austin.ibm.com>
References: <1263501508.4869.133.camel@jschopp-laptop>
	<1263501674.4869.142.camel@jschopp-laptop>
	<1265064662.5391.19.camel@jschopp-laptop>
	<20100202034832.GD12389@ozlabs.org> <4B6870DF.9030408@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Feb 2010 14:27:45 +1100
Message-ID: <1265254065.8287.147.camel@pasglop>
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

On Tue, 2010-02-02 at 12:37 -0600, Joel Schopp wrote:
> >> +		if(*cores != NR_CPUS)
> >> +			prom_printf("client-architecture structure corrupted\n");
> >> +		*cores = (NR_CPUS / prom_smt_way());
> >> +		prom_printf("setting client-architecture cores to %x\n", *cores);
> >>     
> >
> > I don't know if I'm painting a bike shed of if this is a real concern, but if
> > *cores isn't NR_CPUS shouldn't we do nothing rather then clobbering it?
> >
> > Yours Tony
> >   
> If it isn't NR_CPUS we're pretty broken if we set it or if we don't.  My 
> previous version did a BUILD_BUG_ON() but Ben didn't like that and said 
> he preferred just a warning message. 

BUILD_BUG_ON would probably not have worked unless gcc smarter than I
think it is :-) Your latest approach is bad because when you detect
you are poking at the wrong thing ... you still proceed and do it. In
fact you -are- poking at the wrong thing always since you are missing
PTRRELOC() to relocate the pointer to the vec.

I'll post a new variant of that patch.

Cheers,
Ben.
