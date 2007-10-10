Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E6A7DDFA8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 05:45:17 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l9AIaZIh001977
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 14:36:35 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9AJjEVL452488
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 13:45:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9AJjDjn026094
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 13:45:14 -0600
Subject: Re: [PATCH 2/3] [POWERPC] Add AMCC Kilauea eval board support to
	platforms/40x
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200710091334.16682.sr@denx.de>
References: <200710081108.51625.sr@denx.de>
	<20071008193404.GA10348@lixom.net>  <200710091334.16682.sr@denx.de>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 14:44:26 -0500
Message-Id: <1192045466.5534.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-10-09 at 13:34 +0200, Stefan Roese wrote:
> Hi Olof,
> 
> On Monday 08 October 2007, Olof Johansson wrote:
> > > +config KILAUEA
> > > +	bool "Kilauea"
> > > +	depends on 40x
> > > +	default y
> > > +	select 405EX
> > > +	help
> > > +	  This option enables support for the AMCC PPC405EX evaluation board.
> > > +
> > >  #config REDWOOD_5
> > >  #	bool "Redwood-5"
> > >  #	depends on 40x
> > > @@ -89,14 +97,17 @@ config 403GCX
> > >  	#depends on OAK
> > >  	select IBM405_ERR51
> > >
> > > +config 405EP
> > > +	bool
> > > +
> > > +config 405EX
> > > +	bool
> > > +
> >
> > Do you really need config options for 405EP/EX? I don't seem them used
> > anywhere else in the code (and it's also contradictory to the whole new
> > multiplatform way of looking at stuff :).
> >
> > I know the 405/440 is still somewhat #ifdef:ed on the cpu here and there,
> > but since this doesn't add any such code I don't see a need for the config
> > options?
> 
> Yes, I'm still used to needing these defines from arch/ppc (for example for 
> the 4xx EMAC driver). But its possible, that we really don't need it at all 
> in arch/powerpc with all the device tree information. Not sure though.
> 
> Josh, what do you think? Should I remove the 405EX define completely?

If it's not needed, it can go.  As Olof said, it doesn't appear to be
used anywhere in the code so I think it's fine.

One question I do have is if 405EX and 405EP need any of the 405GP
errata config options selected.  I would like to think those don't apply
because the hardware is fixed, but I haven't checked to be sure.

josh
