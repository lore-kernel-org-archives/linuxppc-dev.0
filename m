Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F250B7D3D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 09:04:01 +1100 (EST)
Date: Mon, 1 Feb 2010 22:55:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/7] powerpc: Reduce footprint of irq_stat
Message-ID: <20100201215504.GA17194@lst.de>
References: <20100201063023.GT2996@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100201063023.GT2996@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 01, 2010 at 05:30:23PM +1100, Anton Blanchard wrote:
> 
> PowerPC is currently using asm-generic/hardirq.h which statically allocates an
> NR_CPUS irq_stat array. Switch to an arch specific implementation which uses
> per cpu data:
> 
> On a kernel with NR_CPUS=1024, this saves quite a lot of memory:
> 
>    text    data     bss      dec         hex    filename
> 8767938 2944132 1636796 13348866         cbb002 vmlinux.baseline
> 8767779 2944260 1505724 13217763         c9afe3 vmlinux.irq_cpustat
> 
> A saving of around 128kB.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-cpumask/arch/powerpc/include/asm/hardirq.h
> ===================================================================
> --- linux-cpumask.orig/arch/powerpc/include/asm/hardirq.h	2010-01-31 22:07:21.037211728 +1100
> +++ linux-cpumask/arch/powerpc/include/asm/hardirq.h	2010-02-01 17:28:56.990963256 +1100
> @@ -1 +1,22 @@
> -#include <asm-generic/hardirq.h>
> +#ifndef _ASM_POWERPC_HARDIRQ_H
> +#define _ASM_POWERPC_HARDIRQ_H
> +
> +#include <linux/threads.h>
> +#include <linux/irq.h>
> +
> +typedef struct {
> +	unsigned int __softirq_pending;
> +} ____cacheline_aligned irq_cpustat_t;

No need to bother with an irq_cpustat_t type at all in this case, just
declare a softirq_pending per-cpu variable.
