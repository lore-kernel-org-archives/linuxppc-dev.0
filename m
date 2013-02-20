Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E94362C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 20:32:28 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 20 Feb 2013 14:59:25 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 25FE91258054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 15:03:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1K9WGH226738888
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 15:02:16 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1K9WIdk025326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 20:32:18 +1100
Message-ID: <5124982D.1090504@linux.vnet.ibm.com>
Date: Wed, 20 Feb 2013 15:02:29 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc/rtas_flash: Free kmem upon module exit
References: <20130208111742.31083.67858.stgit@hegdevasant.in.ibm.com>
In-Reply-To: <20130208111742.31083.67858.stgit@hegdevasant.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

	Let me know your thoughts on this patch.

-Vasant


On 02/08/2013 04:48 PM, Vasant Hegde wrote:
> Memory allocated to rtas_firmware_flash_list in rtas_flash_write
> is not freed during module exit. We hit below call trace if we
> unload rtas_flash module after loading new firmware image and
> before rebooting the system.
>
> Call trace:
> ----------
> Feb  6 08:42:10 eagle3 kernel: kmem_cache_destroy rtas_flash_cache: Slab cache still has objects
> Feb  6 08:42:10 eagle3 kernel: Call Trace:
> Feb  6 08:42:10 eagle3 kernel: [c00000001c303b40] [c000000000014940] .show_stack+0x70/0x1c0 (unreliable)
> Feb  6 08:42:10 eagle3 kernel: [c00000001c303bf0] [c000000000199bec] .kmem_cache_destroy+0x15c/0x170
> Feb  6 08:42:10 eagle3 kernel: [c00000001c303c90] [d000000006fa1208] .rtas_flash_cleanup+0x3c/0x80 [rtas_flash]
> Feb  6 08:42:10 eagle3 kernel: [c00000001c303d20] [c0000000000f8970] .SyS_delete_module+0x1d0/0x2e0
> Feb  6 08:42:10 eagle3 kernel: [c00000001c303e30] [c000000000009954] syscall_exit+0x0/0x94
>
> This patch frees rtas_firmware_flash_list during module exit.
>
> Signed-off-by: Vasant Hegde<hegdevasant@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/rtas_flash.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
> index 8329190..e22ef34 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -790,6 +790,11 @@ static void __exit rtas_flash_cleanup(void)
>   {
>   	rtas_flash_term_hook = NULL;
>
> +	if (rtas_firmware_flash_list) {
> +		free_flash_list(rtas_firmware_flash_list);
> +		rtas_firmware_flash_list = NULL;
> +	}
> +
>   	if (flash_block_cache)
>   		kmem_cache_destroy(flash_block_cache);
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
