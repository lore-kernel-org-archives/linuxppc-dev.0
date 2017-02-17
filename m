Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPjfN0XxMzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 17:24:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/fadump: set an upper limit for boot memory size
In-Reply-To: <148717255648.1711.9357297790070400059.stgit@hbathini.in.ibm.com>
References: <148717255648.1711.9357297790070400059.stgit@hbathini.in.ibm.com>
Date: Fri, 17 Feb 2017 17:24:11 +1100
Message-ID: <87efyxjpx0.fsf@concordia.ellerman.id.au>
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

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index de7d39a..d5107f4 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -222,6 +222,18 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>  				&size, &base);
>  	if (ret == 0 && size > 0) {
>  		fw_dump.reserve_bootvar = (unsigned long)size;
> +		/*
> +		 * Adjust if the boot memory size specified is above
> +		 * the upper limit.
> +		 */
> +		if (fw_dump.reserve_bootvar >
> +		    (memblock_end_of_DRAM() / MAX_BOOT_MEM_RATIO)) {

Using memblock_end_of_DRAM() doesn't take into account the fact that you
might have holes in your memory layout.

Possibly on PowerVM that never happens, but I don't think we should
write the code to assume that, if possible.

cheers
