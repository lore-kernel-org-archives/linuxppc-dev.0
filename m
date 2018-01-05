Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zChvT0tP7zDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 22:16:52 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w05BEjrC059712
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jan 2018 06:16:51 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fa7jrsx5t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jan 2018 06:16:50 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 5 Jan 2018 04:16:49 -0700
Subject: Re: [RFC FIX v1 1/2] powerpc: Discover radix availability before
 scanning the memory nodes
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, mpe@ellerman.id.au, david@gibson.dropbear.id.au,
 anton@samba.org
References: <1515150321-24894-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1515150321-24894-2-git-send-email-bharata@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 5 Jan 2018 16:46:32 +0530
MIME-Version: 1.0
In-Reply-To: <1515150321-24894-2-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7c38335d-1d4c-cc18-7704-32c4ca12b0b5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/05/2018 04:35 PM, Bharata B Rao wrote:
> Currently device tree nodes for memory are scanned before the
> radix feature is discovered in mmu_early_init_devtree(). Move this
> routine ahead of scanning memory nodes so that we know if the
> guest is radix or not when scanning ibm,dynamic-reconfiguration-memory.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/prom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index b15bae2..079d893 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -722,6 +722,8 @@ void __init early_init_devtree(void *params)
>   	 */
>   	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
> 
> +	mmu_early_init_devtree();
> +
>   	/* Scan memory nodes and rebuild MEMBLOCKs */
>   	of_scan_flat_dt(early_init_dt_scan_root, NULL);
>   	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> @@ -783,8 +785,6 @@ void __init early_init_devtree(void *params)
>   	spinning_secondaries = boot_cpu_count - 1;
>   #endif
> 
> -	mmu_early_init_devtree();
> -
>   #ifdef CONFIG_PPC_POWERNV
>   	/* Scan and build the list of machine check recoverable ranges */
>   	of_scan_flat_dt(early_init_dt_scan_recoverable_ranges, NULL);
> 

I guess that will cause issues with pa-feature scanning. I don't think 
we finalize cpu features/mmu features that early.

-aneesh
