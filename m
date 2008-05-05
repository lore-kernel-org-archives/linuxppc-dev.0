Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D00B4DDEF7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 05:51:00 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 05 May 2008 21:50:54 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
Message-ID: <20080505195054.172000@gmx.net>
MIME-Version: 1.0
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
Subject: Re: [PATCH] Sam440ep support
To: Kumar Gala <galak@kernel.crashing.org>, cjg@cruxppc.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 5 May 2008 13:27:28 -0500
> Von: Kumar Gala <galak@kernel.crashing.org>
> An: "Giuseppe Coviello" <cjg@cruxppc.org>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH] Sam440ep support

> 
> On May 5, 2008, at 1:23 PM, Giuseppe Coviello wrote:
> 
> > This patch adds the support for the sam440ep board.
> >
> > arch/powerpc/boot/Makefile                  |    5 +-
> > arch/powerpc/boot/cuboot-sam440ep.c         |   35 +
> > arch/powerpc/boot/dts/sam440ep.dts          |  292 ++++++
> > arch/powerpc/boot/sam440ep.c                |   53 +
> > arch/powerpc/configs/44x/sam440ep_defconfig | 1429 ++++++++++++++++++ 
> > +++++++++
> > arch/powerpc/platforms/44x/Kconfig          |    9 +
> > arch/powerpc/platforms/44x/Makefile         |    1 +
> > arch/powerpc/platforms/44x/sam440ep.c       |   66 ++
> > arch/powerpc/sysdev/Makefile                |    1 +
> > arch/powerpc/sysdev/sam440ep.c              |  112 +++
> > include/asm-powerpc/dma-mapping.h           |   30 +
> > sound/core/memalloc.c                       |   31 +-
> 
> The changes to dma-mapping.h and sound/core/memalloc.c need to be  
> explained and odds are will not go in as is.
This is a (bad) hack that I also use on the AmigaOne to get the ALSA sound
drivers working with DMA, because ALSA doesn't work with dma-noncoherent.c.
The problem is the "nopage" mechanism, which fails with non coherent DMA
allocations due to their own virtual address space (correct me, if I'm
wrong).

See this thread for more info:
http://readlist.com/lists/vger.kernel.org/linux-kernel/45/226541.html

This is a general problem that affects all powerpc boards that use
dma-noncoherent.c with ALSA PCI drivers.

Gerhard
-- 
249 Spiele für nur 1 Preis. Die GMX Spieleflatrate schon ab 9,90 Euro.
Neu: Asterix bei den Olympischen Spielen: http://flat.games.gmx.de
