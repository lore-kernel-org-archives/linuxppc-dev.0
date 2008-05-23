Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABF37DE07D
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 22:51:09 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering (Was: [PATCH] [POWERPC] Improve
	(in|out)_beXX() asm code)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1211546197.8297.308.camel@pasglop>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
	<20080520.155326.195407196.davem@davemloft.net>
	<1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
	<1211546197.8297.308.camel@pasglop>
Content-Type: text/plain
Date: Fri, 23 May 2008 08:50:16 -0400
Message-Id: <1211547016.8297.310.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-23 at 08:36 -0400, Benjamin Herrenschmidt wrote:
> 
>         - mandate some kind of dma_sync_for_device/cpu on consistent memory.
> Almost no driver do that currently tho. They only do that for non
> consistent memory mapped with dma_map_*.
> 
>         - mandate the use of wmb,rmb,mb barriers for use between memory
> accesses and MMIOs for ordering them. (ie. fix drivers that don't do
> it). Advantage for powerpc is that I can remove (after some auditing of
> course) the added heavy barriers in the MMIO accessors themselves.

Note that the above is my preferred approach, and a lot of drivers
happen to already do this.

>         - stick a full memory clobber in all MMIO (and PIO) accessors on all
> archs.
> 
> Any other idea ? preference ?
