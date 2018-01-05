Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zD1753Vz3zDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 10:28:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au, anton@samba.org,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: Re: [RFC FIX v1 1/2] powerpc: Discover radix availability before
 scanning the memory nodes
In-Reply-To: <1515150321-24894-2-git-send-email-bharata@linux.vnet.ibm.com>
References: <1515150321-24894-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1515150321-24894-2-git-send-email-bharata@linux.vnet.ibm.com>
Date: Sat, 06 Jan 2018 10:28:00 +1100
Message-ID: <87shbj3myn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bharata B Rao <bharata@linux.vnet.ibm.com> writes:

> Currently device tree nodes for memory are scanned before the
> radix feature is discovered in mmu_early_init_devtree(). Move this
> routine ahead of scanning memory nodes so that we know if the
> guest is radix or not when scanning ibm,dynamic-reconfiguration-memory.

Sorry this doesn't work.

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index b15bae2..079d893 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -722,6 +722,8 @@ void __init early_init_devtree(void *params)
>  	 */
>  	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
>  
> +	mmu_early_init_devtree();
> +

You've moved this above parse_early_param(), but
mmu_early_init_devtree() uses disable_radix, which is an early param. So
this will break disable_radix handling.

It will probably break other things too because the ordering of this
init code is very fragile - bootstrapping is hard :)

>  	/* Scan memory nodes and rebuild MEMBLOCKs */
>  	of_scan_flat_dt(early_init_dt_scan_root, NULL);
>  	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> @@ -783,8 +785,6 @@ void __init early_init_devtree(void *params)
>  	spinning_secondaries = boot_cpu_count - 1;
>  #endif
>  
> -	mmu_early_init_devtree();
> -
>  #ifdef CONFIG_PPC_POWERNV
>  	/* Scan and build the list of machine check recoverable ranges */
>  	of_scan_flat_dt(early_init_dt_scan_recoverable_ranges, NULL);

cheers
