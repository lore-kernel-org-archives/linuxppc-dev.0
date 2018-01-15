Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKjjr0XvHzF0dY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 17:14:23 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0F6EJ3n048278
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 01:14:21 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fgkqmnv3p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 01:14:20 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Jan 2018 06:13:54 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] powerpc/mm: Enable TLB flush during
 native_register_proc_table()
In-Reply-To: <20180110045333.10550-1-khandual@linux.vnet.ibm.com>
References: <20180110045333.10550-1-khandual@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:43:49 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2qrejj6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> From: Anshuman Khandual <Khandual@linux.vnet.ibm.com>
>
> Any changes to the partition table must be followed by appropriate TLB
> flush which is not happening at present in native_register_proc_table()
> path. Fix this by calling mmu_partition_table_set_entry() which does
> take care of TLB flushing after the partition table update.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> - From code inspection
> - Compile, boot tested without CONFIG_PPC_RADIX_MMU
> - Though it seems to be not getting called from any where


For hash the patb1 is zero and hence it is not called. This is left over
from the segment table implementation. I guess we can remove
native_register_proc_table.



>
>  arch/powerpc/mm/hash_native_64.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index 640cf56..89be5a6 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -758,12 +758,14 @@ static void native_flush_hash_range(unsigned long number, int local)
>  static int native_register_proc_table(unsigned long base, unsigned long page_size,
>  				      unsigned long table_size)
>  {
> -	unsigned long patb1 = base << 25; /* VSID */
> +	unsigned long patb0, patb1;
>  
> +	patb1 = base << 25;	    /* VSID */
>  	patb1 |= (page_size << 5);  /* sllp */
>  	patb1 |= table_size;
>  
> -	partition_tb->patb1 = cpu_to_be64(patb1);
> +	patb0 = be64_to_cpu(partition_tb[0].patb0);
> +	mmu_partition_table_set_entry(0, patb0, patb1);
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
