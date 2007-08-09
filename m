Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B106DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 17:02:16 +1000 (EST)
Subject: Re: Fix small race in 44x tlbie function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CEBBAD6A-9C83-4E9A-9752-8F089894E56C@kernel.crashing.org>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
	<20070808110029.43c110ef@weaponx.rchland.ibm.com>
	<57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
	<20070809053423.GJ8261@localhost.localdomain>
	<CEBBAD6A-9C83-4E9A-9752-8F089894E56C@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 17:01:31 +1000
Message-Id: <1186642891.938.219.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Todd Inglett <tinglett@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Volkmar Uhlig <vuhlig@us.ibm.com>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-09 at 01:35 -0500, Kumar Gala wrote:
> >>>> Did you actually see this happen?
> >>>
> >>> Yes.
> >>
> >> When?
> >>
> >> We don't have critical wired to anything, I don't expect watchdog to
> >> cause another fault.. so just wondering.
> >
> > On debug (trace) interrupts on blue gene.
> 
> Do you know why the debug code caused a fault?

Sure, it may access vmalloc space for example, which can cause a TLB
miss...

Ben.
