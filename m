Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D63F7DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 07:36:59 +1000 (EST)
Date: Thu, 26 Jul 2007 16:29:21 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Re: 2.6.22-git hangs during boot on PowerBook G3 in 0.0
	seconds
Message-Id: <20070726162921.a60c76ae.kim.phillips@freescale.com>
In-Reply-To: <18088.6185.491082.875891@cargo.ozlabs.ibm.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
	<1185234923.5439.158.camel@localhost.localdomain>
	<20070724185946.722f34b5.kim.phillips@freescale.com>
	<18088.6185.491082.875891@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rutger Nijlunsing <rutger@nospam.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jul 2007 13:42:33 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Kim Phillips writes:
> 
> > > In which circumstances are you trying to translate an address with no
> > > size cell ?
> > 
> > for the enumerated PHYs. As the original commit comment states, I was
> > getting these messages:
> > 
> > prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@00
> > prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@01
> 
> Specifically, which of_address_to_resource or other call is producing
> these error messages?
> 

Turns out I mistakenly added an mdio type to the platform
of_platform_bus_probe scan list early on in my ucc phylib migration
work, and it went unnoticed. Please do a:

git-revert 3baee955953957be5496cd28e9c544d9db214262

to remove "[POWERPC] Add 'mdio' to bus scan id list for platforms with
QE UEC" (in addition to the one you've already reverted).  Reverting
both these commits eliminates the prom_parse badness messages on the
MPC8360.

Thanks, and sorry,

Kim

p.s. should the stable team be notified to fix 2.6.22 for
Lombard-nvram-style machines?
