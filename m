Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B9FF2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 07:20:12 +1100 (EST)
Message-ID: <1390940395.8524.25.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
Date: Wed, 29 Jan 2014 07:19:55 +1100
In-Reply-To: <20140128150309.GA7428@aepfle.de>
References: <1390883744.3872.76.camel@pasglop>
 <20140128091607.GA24288@aepfle.de> <20140128150309.GA7428@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alistair Popple <alistair@popple.id.au>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-28 at 16:03 +0100, Olaf Hering wrote:
> 
> d084775738b746648d4102337163a04534a02982 is the first bad commit
> commit d084775738b746648d4102337163a04534a02982
> Author: Alistair Popple <alistair@popple.id.au>
> Date:   Mon Dec 9 18:17:03 2013 +1100
> 
>     powerpc/iommu: Update the generic code to use dynamic iommu page sizes
> 
>     This patch updates the generic iommu backend code to use the
>     it_page_shift field to determine the iommu page size instead of
>     using hardcoded values.

Interesting. This is new infrastructure but a nop in functionality, ie,
we support different page sizes for DMA but we still set it to 4k,
unless we somewhat failed to initialize something...

I'll have a look, I actually have one of those G5s here still. Thanks !

Cheers,
Ben.

>     Signed-off-by: Alistair Popple <alistair@popple.id.au>
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> :040000 040000 52a8e1ca3166e3c916f8cdc1df5c1f42c76b2359 3d4915e416b28501ff502305bd4f76d64153dbc4 M      arch
> :040000 040000 e9a9020abbef5622ffa1be381e0ff845e3741fa9 d6fc206dd372c1a8deded826cc5de8b05f71c614 M      drivers
> 
> # git bisect log
> git bisect start
> # good: [b2e448eca1a52fea181905845728ae00a138d84e] Merge branch 'ipmi' (ipmi patches from Corey Minyard)
> git bisect good b2e448eca1a52fea181905845728ae00a138d84e
> # bad: [54c0a4b46150db1571d955d598cd342c9f1d9657] Merge branch 'akpm' (incoming from Andrew)
> git bisect bad 54c0a4b46150db1571d955d598cd342c9f1d9657
> # good: [403227641533c4227d44d14f25c8f3676f6e7436] softirq: convert printks to pr_<level>
> git bisect good 403227641533c4227d44d14f25c8f3676f6e7436
> # bad: [8b52312880ecbc5beb40b313600f2903c16a59ed] powerpc/p1010rdb-pa: modify phy interrupt.
> git bisect bad 8b52312880ecbc5beb40b313600f2903c16a59ed
> # good: [2c49195b6aedd21ff1cd1e095fab9866fba3411b] powernv: Remove get/set_rtc_time when they are not present
> git bisect good 2c49195b6aedd21ff1cd1e095fab9866fba3411b
> # bad: [a68c33f3592eef63304a5f5ab68466539ccac56c] powerpc: Fix endian issues in power7/8 machine check handler
> git bisect bad a68c33f3592eef63304a5f5ab68466539ccac56c
> # good: [c34a51ce49b40b9667cd7f5cc2e40475af8b4c3d] powerpc/mm: Enable _PAGE_NUMA for book3s
> git bisect good c34a51ce49b40b9667cd7f5cc2e40475af8b4c3d
> # good: [fee26f6d5d68a8815b20c32d15dd70d5384eb937] powerpc: Remove unused REDBOOT Kconfig parameter
> git bisect good fee26f6d5d68a8815b20c32d15dd70d5384eb937
> # good: [3a553170d35d69bea3877bffa508489dfa6f133d] powerpc/iommu: Add it_page_shift field to determine iommu page size
> git bisect good 3a553170d35d69bea3877bffa508489dfa6f133d
> # bad: [d084775738b746648d4102337163a04534a02982] powerpc/iommu: Update the generic code to use dynamic iommu page sizes
> git bisect bad d084775738b746648d4102337163a04534a02982
> # first bad commit: [d084775738b746648d4102337163a04534a02982] powerpc/iommu: Update the generic code to use dynamic iommu page sizes
> 
