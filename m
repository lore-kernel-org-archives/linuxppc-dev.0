Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C51801A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 04:40:56 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 12:40:54 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CD92319D8026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 12:31:55 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3EIeoBS36372490
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 11:40:50 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3EIenO6009417
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 12:40:49 -0600
Message-ID: <552D5F30.6080902@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 13:40:48 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/pseries: Fix compile of memory hotplug
 without CONFIG_MEMORY_HOTREMOVE
References: <1428994916-25779-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1428994916-25779-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/14/2015 02:01 AM, Alexey Kardashevskiy wrote:
> 51925fb3c5 "powerpc/pseries: Implement memory hotplug remove in the kernel"
> broke compile when CONFIG_MEMORY_HOTREMOVE is not defined due to missing
> symbols. This fixes the issue by adding the missing symbols.
> 
I think the real fix should be a more invasive patch so that these routines
are not used outside of CONFIG_MEMORY_HOPLUG. These symbols really
are only needed for memory remove.

I'm fine with this patch to correct the build break and will work
on a patch to move code aound when I return from vacation next week.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> 
> This is made against ad30cb99465 (mpe/next) and can be squashed into 51925fb3c5
> if not too late.
> 
> 
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 5cefcad..0ced387 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -369,6 +369,19 @@ static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
> +					struct property *prop)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
> +{
> +	return -EOPNOTSUPP;
> +}
> 
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> 
