Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B37F9140096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 13:10:28 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 17 Apr 2014 08:40:24 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1674D3940048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 08:40:21 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3H3AF2C6488420
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 08:40:15 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3H3AKO6014649
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 08:40:20 +0530
Message-ID: <534F4618.6080405@linux.vnet.ibm.com>
Date: Thu, 17 Apr 2014 11:10:16 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Fix ".__node_distance" undefined
References: <1397570417-1714-1-git-send-email-qiudayu@linux.vnet.ibm.com>
In-Reply-To: <1397570417-1714-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sfr@canb.auug.org.au, jlarrew@linux.vnet.ibm.com, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, alistair@popple.id.au,
 nfont@linux.vnet.ibm.com, akpm@linux-foundation.org, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any update about this patch ?

Thanks
Mike
On 04/15/2014 10:00 PM, Mike Qiu wrote:
>    CHK     include/config/kernel.release
>    CHK     include/generated/uapi/linux/version.h
>    CHK     include/generated/utsrelease.h
>    ...
>    Building modules, stage 2.
> WARNING: 1 bad relocations
> c0000000013d6a30 R_PPC64_ADDR64    uprobes_fetch_type_table
>    WRAP    arch/powerpc/boot/zImage.pseries
>    WRAP    arch/powerpc/boot/zImage.epapr
>    MODPOST 1849 modules
> ERROR: ".__node_distance" [drivers/block/nvme.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> make: *** Waiting for unfinished jobs....
>
> The reason is symbol "__node_distance" not been exported in powerpc.
>
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>   arch/powerpc/mm/numa.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 4ebbb9e..3b181b2 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -232,6 +232,7 @@ int __node_distance(int a, int b)
>
>   	return distance;
>   }
> +EXPORT_SYMBOL(__node_distance);
>
>   static void initialize_distance_lookup_table(int nid,
>   		const __be32 *associativity)
