Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 344FB67A6C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 15:08:03 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Fedin <sonic_amiga@rambler.ru>
In-Reply-To: <20050224115307.79c1d32c.sonic_amiga@rambler.ru>
References: <20050224115307.79c1d32c.sonic_amiga@rambler.ru>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 15:03:33 +1100
Message-Id: <1110341013.32524.44.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Non-DMA mode for floppy on PowerPC, new version
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-02-24 at 11:53 -0500, Pavel Fedin wrote:
>  Here is a cleaned up version of my 2.6.8 kernel patch.
>
> .../...

Where is "can_use_virtual_dma" defined ? I think that should be made
a bit more clean. Except for that, it looks ok I suppose (my knowledge
of this legacy cruft is quite poor :)

Also, do you need to re-implement your own allocation routine ? Just
use get_dma_pages in both...

A pure style issue also: your static initialization should use C99
initializers (.field = value)

"fd_routine" could be renamed to something nicer, like fd_dma_ops (more
linux-style).

I haven't looked at the logic of the vdma code itself, I suppose that if
it works, it's good enough :)

Ben.
