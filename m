Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5632D67EEC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 05:18:32 +1000 (EST)
Date: Sun, 7 Aug 2005 12:18:29 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050807191829.GA5375@gate.ebshome.net>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
	<e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com>
	<20050807043110.GA6316@dmt.cnet>
	<09b0792f426f1d5883cf5d437723f075@embeddededge.com>
	<20050807154432.GE5210@cathedrallabs.org>
	<20050807155731.GA2715@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050807155731.GA2715@dmt.cnet>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Aug 07, 2005 at 12:57:31PM -0300, Marcelo Tosatti wrote:
> On Sun, Aug 07, 2005 at 12:44:32PM -0300, Aristeu Sergio Rozanski Filho wrote:
> > > It depends how you define the semantics of this function call.
> > > Can you call it any (and all of the) time you need it, or does it
> > > actually perform an ioremap() and you only want to call it
> > > once?
> > what about don't cache it and call ioremap() from driver? (I guess
> > ioremap() already check if an area is already mapped, no?)
> 
> Yep, ioremap() should be doing virtual address caching already, no?

In general, ioremap() doesn't do any caching currently. Some subarchs 
do some limited caching, e.g. if BATs (classic PPC) or CAMs (e500) are 
available and were used previously for ioremap() mappings. 

Some time ago I made a trivial ioremap cache patch (useful on 4xx, 
which doesn't have BATs nor CAMs), although it wass really a hack and 
it was never merged :).

-- 
Eugene
