Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 133E5DDFF2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 10:02:53 +1100 (EST)
In-Reply-To: <1174597311.10836.50.camel@localhost.localdomain>
References: <1174573524.6595.509.camel@ld0161-tx32>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
	<20070322155155.GA19903@lixom.net>
	<9E7C3CAC-307E-44A9-9ACB-8A8B8C5B464C@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97FCD@az33exm25.fsl.freescale.net>
	<6186A8EC-8A6F-47E6-B534-D5494E5FA34C@kernel.crashing.org>
	<1174597311.10836.50.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8bb8cd590716fe5709e79331c3823f4a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
Date: Fri, 23 Mar 2007 00:02:21 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think we should invent an MPIC specific property indicating that the
> MPIC is to be shared and indicating on one of the users that it's the
> "master" (the one doing the initial full setup, the others can then 
> spin
> on some bit somewhere before going on, unless we decide such a shared
> setup, the PIC has to be pre-initialized by some firmware and we skip
> all inits in mpic) and indicating which sources belong to which users.

There certainly are way more things then just the MPIC
that both CPUs could do both only one should.  And this
is really the kernel's business, not something to pollute
the device tree with -- well perhaps a global flag (in
/chosen, perhaps) that says "this or that CPU initialises
the shared resources".

It might make sense to have the firmware setup the devices
on these strange strange boards, dunno -- let's worry about
that if/when a board where someone wants that shows up :-)


Segher
