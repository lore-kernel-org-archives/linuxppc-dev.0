Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3BB4B7BAB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 16:47:48 +1100 (EST)
Subject: Re: [PATCH, RFC] powerpc, pci: fix MODPOST warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4AC99B12.8020005@denx.de>
References: <4ABB69DA.7030306@denx.de>  <4AC99B12.8020005@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Oct 2009 16:47:33 +1100
Message-Id: <1255499253.2347.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-05 at 09:06 +0200, Heiko Schocher wrote:
> Hello,
> 
> Heiko Schocher wrote:
> > making a powerpc target with PCI support, shows the
> > following warning:
> > 
> >   MODPOST vmlinux.o
> > WARNING: vmlinux.o(.text+0x10430): Section mismatch in reference from the function pcibios_allocate_bus_resources() to the function .init.text:reparent_resources()
> > The function pcibios_allocate_bus_resources() references
> > the function __init reparent_resources().
> > This is often because pcibios_allocate_bus_resources lacks a __init
> > annotation or the annotation of reparent_resources is wrong.
> > 
> > This patch fix this warning by removing the __init
> > annotation before reparent_resources.
> 
> No comments? So, is this fix OK, or unusable?

Nah, just me missing it but it's reference on patchwork. I'll pick
the patch up. We can probably make some of that __devinit instead
of __init though but we can look at it later.

Cheers
Ben.
