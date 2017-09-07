Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnpR70GhszDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 15:09:38 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8759ZVr070242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Sep 2017 01:09:36 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cts2byfc7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 01:09:36 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 Sep 2017 01:09:35 -0400
Subject: Re: [PATCH] powerpc/powernv: Increase memory block size to 1GB on
 radix
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, bharata@linux.vnet.ibm.com,
 arbab@linux.vnet.ibm.com, npiggin@gmail.com, mikey@neuling.org,
 cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
References: <20170907050551.4632-1-anton@ozlabs.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 7 Sep 2017 10:39:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170907050551.4632-1-anton@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/07/2017 10:35 AM, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Memory hot unplug on PowerNV radix hosts is broken. Our memory block
> size is 256MB but since we map the linear region with very large pages,
> each pte we tear down maps 1GB.
> 
> A hot unplug of one 256MB memory block results in 768MB of memory
> getting unintentionally unmapped. At this point we are likely to oops.
> 
> Fix this by increasing our memory block size to 1GB on PowerNV radix
> hosts.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>   arch/powerpc/platforms/powernv/setup.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 897aa1400eb8..bbb73aa0eb8f 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -272,7 +272,15 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
>   #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
>   static unsigned long pnv_memory_block_size(void)
>   {
> -	return 256UL * 1024 * 1024;
> +	/*
> +	 * We map the kernel linear region with 1GB large pages on radix. For
> +	 * memory hot unplug to work our memory block size must be at least
> +	 * this size.
> +	 */
> +	if (radix_enabled())
> +		return 1UL * 1024 * 1024 * 1024;
> +	else
> +		return 256UL * 1024 * 1024;
>   }
>   #endif
> 

There is a similar issue being worked on w.r.t pseries.

https://lkml.kernel.org/r/1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com

The question is should we map these regions ? ie, we need to tell the 
kernel memory region that we would like to hot unplug later so that we 
avoid doing kernel allocations from that. If we do that, then we can 
possibly map them via 2M size ?

-aneesh
