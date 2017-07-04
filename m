Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x296k6f3qzDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 02:53:02 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v64Gn0JM050012
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 12:52:59 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bgaptq3b7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 12:52:58 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 02:52:55 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v64Gqrd61769750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 02:52:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v64GqqJY022442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 02:52:52 +1000
Subject: Re: [PATCH 1/3] powerpc: do not call ppc_md.panic in panic notifier
 if fadump not used
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170704100909.8738-1-npiggin@gmail.com>
 <20170704100909.8738-2-npiggin@gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 4 Jul 2017 22:22:45 +0530
MIME-Version: 1.0
In-Reply-To: <20170704100909.8738-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <00aa9e9d-adf7-2fd9-839b-2d254e31946b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2017 03:39 PM, Nicholas Piggin wrote:
> If fadump is not registered, and no other crash or debug handlers are
> registered, the powerpc panic handler stops the guest before the generic
> panic code can push out debug information to the console.
> 
> Without this patch, system reset injection to a guest causes the guest to
> silently stop. Afterwards, we get the expected oops trace.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 94a948207cd2..39ba09965b04 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -707,12 +707,15 @@ EXPORT_SYMBOL(check_legacy_ioport);
>  static int ppc_panic_event(struct notifier_block *this,
>                               unsigned long event, void *ptr)
>  {
> -	/*
> -	 * If firmware-assisted dump has been registered then trigger
> -	 * firmware-assisted dump and let firmware handle everything else.
> -	 */
> -	crash_fadump(NULL, ptr);
> -	ppc_md.panic(ptr);  /* May not return */
> +	if (is_fadump_active()) {

Should it be !fw_dump.dump_registered check ? The function crash_dump()
already checks for !fw_dump.dump_registered before proceeding. If fadump
has not been registered then the crash_dump() will return immediately
without doing anything and then fall through next line ppc_md.panic(ptr).

fadump active is always false in the first kernel (production kernel).
Hence is_fadump_active() check here would stop triggering fadump even if
it is registered.

fadump active is true only during second kernel (dump capture kernel)
that boots after fadump crash when firmware exports 'ibm,kernel-dump'
device tree node indicating dump data is available.

Thanks,
-Mahesh.

> +		/*
> +		 * If firmware-assisted dump has been registered then trigger
> +		 * firmware-assisted dump and let firmware handle everything
> +		 * else.
> +		 */
> +		crash_fadump(NULL, ptr);
> +		ppc_md.panic(ptr);  /* May not return */
> +	}
>  	return NOTIFY_DONE;
>  }
> 
