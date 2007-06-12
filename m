Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A73B9DDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 23:31:12 +1000 (EST)
In-Reply-To: <20070611162135.GS2591@chiana.homelinux.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
	<3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
	<1181169093.31677.260.camel@localhost.localdomain>
	<d3c57096eec4553de180adab085d0145@kernel.crashing.org>
	<20070611162135.GS2591@chiana.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <894636D6-AC2E-4D28-8698-EB43C7354BB5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Tue, 12 Jun 2007 08:31:40 -0500
To: Marc Leeman <marc.leeman@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> What is more disturbing though, is that a number of operations on the
> powerpc arch seems significantly slower wrt the ppc arch.
>
> ioremap and iounmap being the most important one: we are using a small
> driver that uses one of the UPMs in combination with GPIOs for HPI  
> (Host
> Port Interface) for TI DSPs.
>
> Where the loading of a DSP took only 3 seconds, it went up to over a
> minute on powerpc (same driver code).

I'm confused what you are comparing here, 3 seconds on arch=ppc vs  
over a minute on arch=powerpc?

> Changing the driver to ioremap and unmap 0xe2400000 only once at  
> driver
> initialisation and unloading (not really relevant on this embedded
> system, shame on me) instead twice for every word greatly improves the
> time (around one second). However, this optimisation has the same  
> effect
> on ppc too :-/
>
> Running the same application with the same modules on ppc and powerpc
> (transferring data from the network to an FPGA) has a 50% higher  
> load on
> powerpc. The transfer is done with mapping user pages into the kernel
> and DMA'ing them over PCI. What all driver have in common is that  
> there
> are quite some writes/reads to the IMMR configuration.

I'd expect the driver to be exactly the same (or close to it) for  
arch=ppc vs arch=powerpc.

> Decreasing the read and writes to the LBC for HPI (0xe2400000)  
> seems to
> improve the overall load.
>
> So my question would be if I need to specify a special section in the
> dts file for some reason; next to the U-Boot configuration that sends
> writes to this address through the UPMB?
>
> If not, is there any other reason that might account for these
> significant performance drops?

There shouldn't be, but if you are seeing this we really should  
figure out what's going on.

What kernel is this on?  What processor are you using?

- k
