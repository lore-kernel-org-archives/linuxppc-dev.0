Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EC36DDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 08:02:12 +1100 (EST)
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6186A8EC-8A6F-47E6-B534-D5494E5FA34C@kernel.crashing.org>
References: <1174573524.6595.509.camel@ld0161-tx32>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
	<20070322155155.GA19903@lixom.net>
	<9E7C3CAC-307E-44A9-9ACB-8A8B8C5B464C@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97FCD@az33exm25.fsl.freescale.net>
	<6186A8EC-8A6F-47E6-B534-D5494E5FA34C@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 08:01:51 +1100
Message-Id: <1174597311.10836.50.camel@localhost.localdomain>
Mime-Version: 1.0
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


> If you look at what mpic_init() does you will see that the registers  
> would be setup twice.
> 
> Also, you don't need to walk the device-tree at all.  As Olof pointed  
> out there maybe interrupts that are not described in the device  
> tree.  We can setup this information when you do a request_irq() ->  
> set_irq_type().
> 
> If you aren't doing a request_irq() for the interrupt than it doesn't  
> need to be setup.  Additionally, you should only doing a request_irq 
> () for an interrupt that is "owned" by that core.

The need to have an MPIC shared by more than one cores is something that
will be coming elsewhere too (can't give details...)

I think we should invent an MPIC specific property indicating that the
MPIC is to be shared and indicating on one of the users that it's the
"master" (the one doing the initial full setup, the others can then spin
on some bit somewhere before going on, unless we decide such a shared
setup, the PIC has to be pre-initialized by some firmware and we skip
all inits in mpic) and indicating which sources belong to which users.

Ben.
