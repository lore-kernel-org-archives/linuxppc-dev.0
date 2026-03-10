Return-Path: <linuxppc-dev+bounces-17976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605BFFD4F19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 18:27:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVj5y53t8z3bmM;
	Wed, 11 Mar 2026 05:27:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773167238;
	cv=none; b=aaV6ycmtwp1hJ4tKOoxU9rfcLnTF0+P51f6sj5/1c8FUgqr4Y7hOSKuO4LC/GAPGZWkUafs0iLok0J9fv3nmASapnOnQOWYCAngV7NJEbgy/PKay6Q6TxHS3hXiaowbYsci4vvy3z+CJRUTJ1NaiZuqdBnB+PmY6IHTMOIlSVeieaCtw3qs5HHgTP83/KNV/b+wDnbh6hlFJi1W+BMhrLgS0AxtwWqTttq1hsyanmeyz3jXkvHuu+nbg7LbxGgt5DOcxKzWDK0Gc2RQvujAWg6m4uIByvuJ0+fAXFx9pARLYCRqZHklGvgjYYJdur9P5d2DJRJyNu5khwcI9F7nWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773167238; c=relaxed/relaxed;
	bh=R1/mlvtAuEpLwt0CAiez//WsTw+/EMUNNqryDcYUQIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3WoI6wRpxmmg07It+bpFSWGfP4keA5RWg2eKo52qCaSfG+KSjjnZKkTfwmh2tUt39QeAs9KurtYkj9qg5PyONJEkrOAagvWwdSzG3LcLeEVFx52CAf9551wFkV+sh6ZPUrp6AzFsKq4ziZv5Msz/PladI9CIuI4CZJYo98jTcLlOH2nPWaHNX3NPucHUnWKFeMduX4h/wwiJYVGzf7PMHKyr1Dk08FT59MLZ7VeruGaRiQOZXpUj5wt4bM/YW+aU3MWefd0zcSP5aD8QC4JiRY4i54UFgrmPiRWlJk+0Xf3ttlRfaHYOHY3Gzz0vYpxeBrwCU0UQ/AQiK26rocLOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
X-Greylist: delayed 1581 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 05:27:17 AEDT
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVj5x1WYgz3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 05:27:17 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id 6441ED4;
	Tue, 10 Mar 2026 19:00:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 6441ED4
Received: from t14g4 (dan-vpn.danny.cz [10.8.0.6])
	by server.danny.cz (Postfix) with ESMTP id 1033316A001;
	Tue, 10 Mar 2026 19:00:51 +0100 (CET)
Date: Tue, 10 Mar 2026 19:00:50 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Donet
 Tom <donettom@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mem: Move CMA reservations to arch_mm_preinit
Message-ID: <20260310190050.533044e6@t14g4>
In-Reply-To: <6e532cf0db5be99afbe20eed699163d5e86cd71f.1772303986.git.ritesh.list@gmail.com>
References: <6e532cf0db5be99afbe20eed699163d5e86cd71f.1772303986.git.ritesh.list@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ritesh,

On Sun,  1 Mar 2026 00:17:59 +0530
"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> wrote:

> commit 4267739cabb8 ("arch, mm: consolidate initialization of SPARSE memo=
ry model"),
> changed the initialization order of "pageblock_order" from...
> start_kernel()
>     - setup_arch()
>        - initmem_init()
>          - sparse_init()
>            - set_pageblock_order();  // this sets the pageblock_order
>        - xxx_cma_reserve();
>=20
> to...
> start_kernel()
>     - setup_arch()
>        - xxx_cma_reserve();
>     - mm_core_init_early()
>        - free_area_init()
>           - sparse_init()
>              - set_pageblock_order() // this sets the pageblock_order.
>=20
> So this means, pageblock_order is not initialized before these cma
> reservation function calls, hence we are seeing CMA failures like...
>=20
> [    0.000000] kvm_cma_reserve: reserving 3276 MiB for global area
> [    0.000000] cma: pageblock_order not yet initialized. Called during ea=
rly boot?
> [    0.000000] cma: Failed to reserve 3276 MiB
> ....
> [    0.000000][    T0] cma: pageblock_order not yet initialized. Called d=
uring early boot?
> [    0.000000][    T0] cma: Failed to reserve 1024 MiB
>=20
> This patch moves these CMA reservations to arch_mm_preinit() which
> happens in mm_core_init() (which happens after pageblock_order is
> initialized), but before the memblock moves the free memory to buddy.
>=20
> Fixes: 4267739cabb8 ("arch, mm: consolidate initialization of SPARSE memo=
ry model")
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Reported-and-tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Closes: https://lore.kernel.org/linuxppc-dev/4c338a29-d190-44f3-8874-6cfa=
0a031f0b@linux.ibm.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

awesome, this fixes KVM initialization issues in 7.0-rc. Successfully
started a KVM guest on a Power8 based host system.

...
Mar 10 16:48:11 fedora kernel: NODE_DATA(0) allocated [mem 0x3ff4f9c00-0x3f=
f50197f]
Mar 10 16:48:11 fedora kernel: kvm_cma_reserve: reserving 819 MiB for globa=
l area
Mar 10 16:48:11 fedora kernel: cma: pageblock_order not yet initialized. Ca=
lled during early boot?
Mar 10 16:48:11 fedora kernel: cma: Failed to reserve 819 MiB
Mar 10 16:48:11 fedora kernel: rfi-flush: ori type flush available
Mar 10 16:48:11 fedora kernel: rfi-flush: patched 12 locations (ori type fl=
ush)
...
was the error message in 7.0-rc3


Tested-by: Dan Hor=C3=A1k <dan@danny.cz>


		Dan

> ---
>  arch/powerpc/kernel/setup-common.c | 10 ----------
>  arch/powerpc/mm/mem.c              | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 10 deletions(-)
>=20
> --
> 2.53.0
>=20
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index cb5b73adc250..b1761909c23f 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -35,7 +35,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/hugetlb.h>
>  #include <linux/pgtable.h>
> -#include <asm/kexec.h>
>  #include <asm/io.h>
>  #include <asm/paca.h>
>  #include <asm/processor.h>
> @@ -995,15 +994,6 @@ void __init setup_arch(char **cmdline_p)
>=20
>  	initmem_init();
>=20
> -	/*
> -	 * Reserve large chunks of memory for use by CMA for kdump, fadump, KVM=
 and
> -	 * hugetlb. These must be called after initmem_init(), so that
> -	 * pageblock_order is initialised.
> -	 */
> -	fadump_cma_init();
> -	kdump_cma_reserve();
> -	kvm_cma_reserve();
> -
>  	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
>=20
>  	if (ppc_md.setup_arch)
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index a985fc96b953..b7982d0243d4 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -30,6 +30,10 @@
>  #include <asm/setup.h>
>  #include <asm/fixmap.h>
>=20
> +#include <asm/fadump.h>
> +#include <asm/kexec.h>
> +#include <asm/kvm_ppc.h>
> +
>  #include <mm/mmu_decl.h>
>=20
>  unsigned long long memory_limit __initdata;
> @@ -268,6 +272,16 @@ void __init paging_init(void)
>=20
>  void __init arch_mm_preinit(void)
>  {
> +
> +	/*
> +	 * Reserve large chunks of memory for use by CMA for kdump, fadump, KVM
> +	 * and hugetlb. These must be called after pageblock_order is
> +	 * initialised.
> +	 */
> +	fadump_cma_init();
> +	kdump_cma_reserve();
> +	kvm_cma_reserve();
> +
>  	/*
>  	 * book3s is limited to 16 page sizes due to encoding this in
>  	 * a 4-bit field for slices.

