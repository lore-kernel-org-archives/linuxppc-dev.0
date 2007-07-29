Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DEACDDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 09:34:35 +1000 (EST)
Subject: Re: Using video memory on PS3 e.g. as SWAP?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>
In-Reply-To: <200707291904.55700.rene@exactcode.de>
References: <200707291904.55700.rene@exactcode.de>
Content-Type: text/plain; charset=utf-8
Date: Mon, 30 Jul 2007 09:34:24 +1000
Message-Id: <1185752064.5495.375.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-07-29 at 19:04 +0200, René Rebe wrote:
> Hi all,
> 
> looking at the PS3 as one of the few PowerPC workstation options the RAM
> is obviously quite limitted with just 256MB. I wonder if the 256MB of
> video memory can be mapped or at least be used as super-fast SWAP?
> 
> Or are there news regarding accessing the video chip from Linux beside
> the unaccelerated frame-buffer?

I can be mapped, and accessed directly with MMIO. Some folks did a
driver for that, not sure where about. It's fairly slow though. The
problem is that MMIO accesses to VRAM aren't fast. DMAs are supposed to
be but then, we don't have access to those.

Cheers,
Ben
