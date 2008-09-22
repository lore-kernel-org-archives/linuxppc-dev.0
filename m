Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73947DDEDE
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 15:29:12 +1000 (EST)
Subject: Re: ioremap and vmalloc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?= <chretien@enseirb.fr>
In-Reply-To: <48D3D70D.3060404@enseirb.fr>
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
	<20080919134933.GA7849@secretlab.ca> <48D3D47E.5050200@gmail.com>
	<20080919163819.GB4492@yoda.jdub.homelinux.org>
	<48D3D70D.3060404@enseirb.fr>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Sep 2008 15:28:50 +1000
Message-Id: <1222061330.12085.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@gate.crashing.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-09-19 at 18:45 +0200, Sébastien Chrétien wrote:
> if I write :
> ioremap(0x20000000,0x40000) and ioremap(0x20000000,0x50000)
> 
> Will it crash ?

To give you a rough idea, unless you tweak things like TASK_SIZE,
KERNELBASE, CONFIG_LOWMEM_SIZE, etc... and depending on what CPU you
use, you can generally count on approx. 200M of virtual space for
vmalloc/ioremap, or a bit less. I would additionally recommend against
mapping a significant portion of that for your devices as the kernel
will need space for its own use by vmalloc.

You can increase the amount available here by lowering TASK_SIZE to 2G
and KERNELBASE as well, and keeping CONFIG_LOWMEM_SIZE clamped to
something like 256M. That will give you a good GB of virtual space if I
can still count correctly.

(Note, having just looked at the MMU init code for 32 bits, I almost had
to puke, Kumar, Josh, we really need to clean that shit up one of these
days).

Cheers,
Ben.
