Return-Path: <jdub@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B75C679E2
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 04:07:19 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87I7GYY017683
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 14:07:16 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k87I7Fev029326
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 12:07:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k87I7F3R018884
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 12:07:15 -0600
Subject: Re: [PATCH] [v3] PPC 4xx: Enable XMON on PPC 4xx boards
From: Josh Boyer <jdub@us.ibm.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20060907171916.GB18929@gate.ebshome.net>
References: <1157639720.6098.49.camel@zod.rchland.ibm.com>
	<20060907171916.GB18929@gate.ebshome.net>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 13:08:45 -0500
Message-Id: <1157652525.6098.61.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: paulus@samba.org, mporter@embeddedalley.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 10:19 -0700, Eugene Surovegin wrote:
> On Thu, Sep 07, 2006 at 09:35:20AM -0500, Josh Boyer wrote:
> 
> [snip]
> 
> > --- linux-2.6.orig/arch/ppc/xmon/start.c
> > +++ linux-2.6/arch/ppc/xmon/start.c
> > @@ -73,6 +73,27 @@ xmon_map_scc(void)
> >  	TXRDY = 0x20;
> >  	RXRDY = 1;
> >  	DLAB = 0x80;
> > +#elif defined(CONFIG_440EP)
> > +	sccd = (volatile unsigned char *) ioremap(0xef600300, 8);
> > +	sccc = sccd + 5;
> > +	TXRDY = 0x20;
> > +	RXRDY = 1;
> > +	DLAB = 0x80;
> > +#elif defined(CONFIG_440SP)
> > +	sccd = (volatile unsigned char *) ioremap64(0x00000001f0000200ULL, 8);
> > +	sccc = sccd + 5;
> > +	TXRDY = 0x20;
> > +	RXRDY = 1;
> > +	DLAB = 0x80;
> > +#elif defined(CONFIG_44x)
> > +	/* This is the default for 44x platforms.  Any boards that have a
> > +	   different UART address need to be put in cases before this or the
> > +	   port will be mapped incorrectly */
> > +	sccd = (volatile unsigned char *) ioremap64(0x0000000140000200ULL, 8);
> > +	sccc = sccd + 5;
> > +	TXRDY = 0x20;
> > +	RXRDY = 1;
> > +	DLAB = 0x80;
> 
> There is only one line which is different, why did you put all other 
> under #ifdef?
> 
> Also, all these hardcoded addresses are already available as defines, 
> why just not use them?

Blindly following the existing convention.  I agree it's ugly.  I'll fix
it up shortly and send out another patch.  It'll also fix 440SPE, which
also has a different UART address.

josh
