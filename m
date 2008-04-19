Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 668ADDE0BB
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 21:07:42 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 19 Apr 2008 13:07:40 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <Pine.LNX.4.64.0804172156390.32124@blarg.am.freescale.net>
Message-ID: <20080419110740.107700@gmx.net>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0804172156390.32124@blarg.am.freescale.net>
Subject: Re: [PATCH] [POWERPC] Port fixmap from x86 and use for kmap_atomic
To: Kumar Gala <galak@kernel.crashing.org>
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
> Datum: Thu, 17 Apr 2008 21:57:05 -0500 (CDT)
> Von: Kumar Gala <galak@kernel.crashing.org>
> An: Paul Mackerras <paulus@samba.org>
> CC: linuxppc-dev@ozlabs.org
> Betreff: [PATCH] [POWERPC] Port fixmap from x86 and use for kmap_atomic

> The fixmap code from x86 allows us to have compile time virtual addresses
> that we change the physical addresses of at run time.
...
> +/*
> + * Here we define all the compile-time 'special' virtual
> + * addresses. The point is to have a constant address at
> + * compile time, but to set the physical address only
> + * in the boot process. We allocate these special addresses
> + * from the end of virtual memory (0xfffff000) backwards.
> + * Also this lets us do fail-safe vmalloc(), we
> + * can guarantee that these special addresses and
> + * vmalloc()-ed addresses never overlap.
I don't understand how highmem works, but I'm just interested to know, if
this implementation could conflict somehow with the non coherent DMA
implementation in dma-noncoherent.c (which uses address space from
0xff100000 to 0xff300000 for DMA memory).
On the other side could dma-noncoherent.c benefit from fixmaps so that it
isn't necessary to configure a start address for DMA allocations?

Thanks!

best regards,

Gerhard
-- 
Psst! Geheimtipp: Online Games kostenlos spielen bei den GMX Free Games! 
http://games.entertainment.gmx.net/de/entertainment/games/free
