Return-Path: <maddy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C83FF1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 12:19:56 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1F66714012C
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 12:19:55 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 07:49:53 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F1637E0059
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 07:54:06 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t772Jnv231850748
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 07:49:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t772JndQ004835
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 07:49:49 +0530
Message-ID: <55C415C4.9080704@linux.vnet.ibm.com>
Date: Fri, 07 Aug 2015 07:49:48 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [PATCH] powerpc/prom: Use DRCONF flags while processing detected
 LMBs
References: <1438866307-19637-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1438866307-19637-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 06 August 2015 06:35 PM, Anshuman Khandual wrote:
> This patch just replaces hard coded values with existing

  Please drop "This patch just" and start with "Replace hard ..."

  https://www.kernel.org/doc/Documentation/SubmittingPatches 

  Maddy

> DRCONF flags while procesing detected LMBs from the device
> tree. This does not change any functionality.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/prom.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 8b888b1..70a8cab 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -476,9 +476,10 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  		flags = of_read_number(&dm[3], 1);
>  		/* skip DRC index, pad, assoc. list index, flags */
>  		dm += 4;
> -		/* skip this block if the reserved bit is set in flags (0x80)
> -		   or if the block is not assigned to this partition (0x8) */
> -		if ((flags & 0x80) || !(flags & 0x8))
> +		/* skip this block if the reserved bit is set in flags
> +		   or if the block is not assigned to this partition */
> +		if ((flags & DRCONF_MEM_RESERVED) ||
> +				!(flags & DRCONF_MEM_ASSIGNED))
>  			continue;
>  		size = memblock_size;
>  		rngs = 1;
