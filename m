Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3DC9DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 10:55:30 +1100 (EST)
Subject: Re: [PATCH 0/11] Patches for Toshiba Cell reference set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200702020734.l127Ysfg013490@toshiba.co.jp>
References: <200702020734.l127Ysfg013490@toshiba.co.jp>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:55:21 +1100
Message-Id: <1170633321.2620.56.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-02 at 16:34 +0900, Ishizaki Kou wrote:
> Paul-san,
> 
> This is a revised version of the patch set for Toshiba Cell reference
> set (aka Celleb). It is against powerpc.git. Please apply.
> 
> 
> Changes from our previous patch set:
> 
> [PATCH 5/11] Celleb: htab routines
> * use spin_lock_irqsave() instead of spin_lock()

In which circumstances was that a problem ? iSeries uses spin_lock() ...
the caller should have disable IRQs before calling any of the low level
htab routines. If not, then there is a bug that needs to be fixed.

> [PATCH 8/11] Celleb: consolidate spu management ops
> * (already posted)
>   fix compile error in arch/powerpc/platforms/cell/spu_priv1_mmio.h

Ben.
