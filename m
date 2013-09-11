Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4F4E2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:37:40 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 11 Sep 2013 16:30:08 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 768C42BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:37:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8B6bQr15177620
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:37:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8B6baKP020534
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:37:37 +1000
Message-ID: <52300FB9.5020104@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2013 12:07:45 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vladimir Murzin <murzin.v@gmail.com>
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_chip_id
References: <1378831135-2179-1-git-send-email-murzin.v@gmail.com>
In-Reply-To: <1378831135-2179-1-git-send-email-murzin.v@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 chenhui.zhao@freescale.com, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/10/2013 10:08 PM, Vladimir Murzin wrote:
> While cross-building for PPC64 I've got
>
Vladimir,

Below commit ID fixes this issue.

commit 256588fda10f2a712631f8a4e72641a66adebdb8
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Mon Sep 9 18:37:56 2013 -0700

     powerpc: Export cpu_to_chip_id() to fix build error

-Vasant

> ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
>
> mtip32xx refer to topology_physical_package_id, which stands for
> cpu_to_chip-id.
>
> Make cpu_to_chip-id (and topology_physical_package_id) available for
> external users.
>
> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> ---
>   arch/powerpc/kernel/smp.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 442d8e2..1d9c1c2 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -611,6 +611,7 @@ int cpu_to_chip_id(int cpu)
>   	of_node_put(np);
>   	return of_get_ibm_chip_id(np);
>   }
> +EXPORT_SYMBOL_GPL(cpu_to_chip_id);
>
>   /* Helper routines for cpu to core mapping */
>   int cpu_core_index_of_thread(int cpu)
>
