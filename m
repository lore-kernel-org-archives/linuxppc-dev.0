Return-Path: <srs0=0sgf=jo=redhat.com=dyoung@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GVjn4RSbzF1Pp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 16:48:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41GVjn3t9Tz8syV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 16:48:45 +1000 (AEST)
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41GVjn0xWFz9s29
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 16:48:44 +1000 (AEST)
Date: Thu, 28 Jun 2018 14:48:32 +0800
From: Dave Young <dyoung@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, dgibson@redhat.com
Subject: Re: [PATCH] powerpc/kdump: handle crashkernel memory reservation
 failure
Message-ID: <20180628064832.GB2925@dhcp-128-65.nay.redhat.com>
References: <153016319642.8584.7868984232962915832.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153016319642.8584.7868984232962915832.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/18 at 10:49am, Hari Bathini wrote:
> Memory reservation for crashkernel could fail if there are holes around
> kdump kernel offset (128M). Fail gracefully in such cases and print an
> error message.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/kernel/machine_kexec.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index 936c7e2..6181442 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -188,7 +188,12 @@ void __init reserve_crashkernel(void)
>  			(unsigned long)(crashk_res.start >> 20),
>  			(unsigned long)(memblock_phys_mem_size() >> 20));
>  
> -	memblock_reserve(crashk_res.start, crash_size);
> +	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
> +	    memblock_reserve(crashk_res.start, crash_size)) {
> +		printk(KERN_ERR "Failed to reserve memory for crashkernel!\n");
> +		crashk_res.start = crashk_res.end = 0;
> +		return;
> +	}
>  }
>  
>  int overlaps_crashkernel(unsigned long start, unsigned long size)
> 

It would be better to print a separate error message for !memblock_is_region_memory
But I think memblock_reserve is unlikly to fail so this patch is also
good.

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
