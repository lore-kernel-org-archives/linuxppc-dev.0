Return-Path: <srs0=eibx=4l=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK2k966XgzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 16:56:33 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wK2k95ZmKz8t79
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 16:56:33 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wK2k92cmgz9s8V
 for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2017 16:56:33 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v456rslr117470
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 02:56:23 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a8b9yc4j1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 05 May 2017 02:56:21 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 5 May 2017 16:55:45 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v456tYaf61538514
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 16:55:42 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v456tArP027200
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 16:55:10 +1000
Subject: Re: [PATCH 2/2] powerpc/fadump: avoid holes in boot memory area when
 fadump is registered
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <149392041651.10802.10097444663269312695.stgit@hbathini.in.ibm.com>
 <149392044508.10802.11008391107873058533.stgit@hbathini.in.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Pingfan Liu <piliu@redhat.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 12:24:51 +0530
MIME-Version: 1.0
In-Reply-To: <149392044508.10802.11008391107873058533.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <57fd94b9-ce08-5751-a269-1374126ce42c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2017 11:24 PM, Hari Bathini wrote:
> To register fadump, boot memory area - the size of low memory chunk that
> is required for a kernel to boot successfully when booted with restricted
> memory, is assumed to have no holes. But this memory area is currently
> not protected from hot-remove operations. So, fadump could fail to
> re-register after a memory hot-remove operation, if memory is removed
> from boot memory area. To avoid this, ensure that memory from boot
> memory area is not hot-removed when fadump is registered.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/fadump.h               |    1 +
>  arch/powerpc/kernel/fadump.c                    |   12 ++++++++++++
>  arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> index 0031806..609fccc 100644
> --- a/arch/powerpc/include/asm/fadump.h
> +++ b/arch/powerpc/include/asm/fadump.h
> @@ -198,6 +198,7 @@ struct fad_crash_memory_ranges {
>  	unsigned long long	size;
>  };
> 
> +extern int is_fadump_boot_memory_area(u64 addr, ulong size);
>  extern int early_init_dt_scan_fw_dump(unsigned long node,
>  		const char *uname, int depth, void *data);
>  extern int fadump_reserve_mem(void);
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 03563c6..ea7dfdc 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -114,6 +114,18 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
>  	return 1;
>  }
> 
> +/*
> + * If fadump is registered, check if the memory provided
> + * falls within boot memory area.
> + */
> +int is_fadump_boot_memory_area(u64 addr, ulong size)
> +{
> +	if (!fw_dump.dump_registered)
> +		return 0;
> +
> +	return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
> +}
> +
>  int is_fadump_active(void)
>  {
>  	return fw_dump.dump_active;
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index e104c71..a186b8e 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -22,6 +22,7 @@
>  #include <asm/machdep.h>
>  #include <asm/prom.h>
>  #include <asm/sparsemem.h>
> +#include <asm/fadump.h>
>  #include "pseries.h"
> 
>  static bool rtas_hp_event;
> @@ -406,6 +407,12 @@ static bool lmb_is_removable(struct of_drconf_cell *lmb)
>  	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
>  	phys_addr = lmb->base_addr;
> 
> +#ifdef CONFIG_FA_DUMP
> +	/* Don't hot-remove memory that falls in fadump boot memory area */
> +	if (is_fadump_boot_memory_area(phys_addr, block_sz))
> +		return false;
> +#endif
> +
>  	for (i = 0; i < scns_per_block; i++) {
>  		pfn = PFN_DOWN(phys_addr);
>  		if (!pfn_present(pfn))
> 
