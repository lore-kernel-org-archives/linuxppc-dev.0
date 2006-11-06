Return-Path: <Simon.Richter@hogyros.de>
Received: from kleinhenz.com (static.88-198-202-190.clients.your-server.de
	[88.198.202.190]) by ozlabs.org (Postfix) with ESMTP id 3D84567CBC
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 02:43:43 +1100 (EST)
Message-ID: <454F5259.3020107@hogyros.de>
Date: Mon, 06 Nov 2006 16:18:49 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: APUS and IOs question
References: <1162767333.28571.254.camel@localhost.localdomain>
In-Reply-To: <1162767333.28571.254.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Benjamin Herrenschmidt wrote:

> Somebody who understands APUS around ?

I have one, but I don't understand all of it. :-)

> In include/asm-ppc/io.h, we have a special definition of the PCI IO
> accessors readw,writew,readl and writel for APUS that don't do byteswap
> and also don't do barriers.

APUS PCI is weird, to say the least. The PCI extension is basically
built to accomodate a single PCI device, which happens to be a Permedia2
graphics chip that allows byte-swapped mappings of both register and
framebuffer space and is never told to do DMA because nobody knows what
kind of interesting effects that would have, so the only synchronisation
that is needed is between accesses to the framebuffer and the GPU.

That, and that the 604e+ probably doesn't reorder accesses that much
anyway that the barriers would do any good here. :-)

   Simon
