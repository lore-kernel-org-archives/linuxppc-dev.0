Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02F5BB7D52
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Feb 2010 21:04:36 +1100 (EST)
Subject: Re: [PATCH 5/5] powerpc: Increase NR_IRQS Kconfig maximum to 32768
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20100201090946.GA22966@iram.es>
References: <20100131110938.GL2996@kryten> <20100131111012.GM2996@kryten>
	<20100131111155.GN2996@kryten> <20100131111315.GO2996@kryten>
	<20100131111403.GP2996@kryten>  <20100201090946.GA22966@iram.es>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 21:04:25 +1100
Message-ID: <1265018665.8287.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-02-01 at 10:09 +0100, Gabriel Paubert wrote:
> On Sun, Jan 31, 2010 at 10:14:03PM +1100, Anton Blanchard wrote:
> > 
> > With dynamic irq descriptors the overhead of a large NR_IRQS is much lower
> > than it used to be. With more MSI-X capable adapters and drivers exploiting 
> > multiple vectors we may as well allow the user to increase it beyond the
> > current maximum of 512.
> > 
> > 32768 seems large enough that we'd never have to bump it again (although I bet
> > my prediction is horribly wrong). It boot tests OK and the vmlinux footprint
> > increase is only around 500kB due to:
> 
> Only 1/2 MB? 
> 
> I'm running Linux on 12 year old PPC machines which have 16MB
> or RAM (ok, they are still running an old kernel, but a few
> patches like this and they wont't even boot). The kernels
> I have are well below 1MB, code+data+bss. 
> 
> Yes it is configurable, thanks, and 64 is enough for these
> machines (8259 plus an MPIC), so it's not that crucial.
> 
> What I object to is calling 1/2MB negligible.

Yeah well, all Anton did was to push up the -max- value you can set in
the config, not the default :-)

But yeah, it's not "negligible" per-se.

Cheers,
Ben.
