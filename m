Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0494067B61
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 08:22:47 +1100 (EST)
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <58E9B419-8FFE-4191-B384-A2F7C22BCAFA@embeddedalley.com>
References: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
	<B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
	<58E9B419-8FFE-4191-B384-A2F7C22BCAFA@embeddedalley.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 08:22:40 +1100
Message-Id: <1166476960.19254.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-12-15 at 12:23 -0500, Dan Malek wrote:
> On Dec 15, 2006, at 11:09 AM, Kumar Gala wrote:
> 
> >
> >> +	if (machine_is(mpc83xx))
> >> +		of_platform_bus_probe(NULL, NULL, NULL);
> >> +
> >
> > Does this every get called, meaning does anything match machine_is
> > (mpc83xx)?
> 
> 
> I truly dislike this "machine_is" method.  Other architectures
> do this and it becomes a real PITA.  It seems to evolve
> into something that never has the proper, useful granularity.
> Surprisingly, it often ends up as a guarantee you can't boot
> common kernels on similar boards, which is what
> I suspect you are trying to achieve.

Well, machine_is(mpc83xx) is certainly wrong, it should be
machine_is(whatver_my_board_name_is). It's a way to test for a given bsp
and nothing else. It's served us well for powermac/prep/chrp though I
agree that abusing it is often a sign that something is wrong with the
design.

There is one area on which is needs right now is when a platform adds
initcalls as those will be called regardless of wether that platform was
actually selected at boot or not, though I've been thinking about a way
to add board_xxx_initcall() thingies to fix that. 

In general, for better granularity, code shall test specific properties
in the device-tree exposing a given feature.

> This is a case where your board specific initialization
> should call this, or fill in a ppc_md indirect pointer that
> if set is called at the proper time.

Agreed.

Ben.
