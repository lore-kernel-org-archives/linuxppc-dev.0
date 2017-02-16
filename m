Return-Path: <nfont@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP25l59VCzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 14:42:03 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vP25l1nHBz9s8F
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 14:42:02 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G3d5HC004341
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2017 22:42:00 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28my2r2xy4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2017 22:41:59 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 20:41:59 -0700
Subject: Re: [PATCH] powerpc/pseries: Fix build break when MEMORY_HOTREMOVE=n
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1487214078-3893-1-git-send-email-mpe@ellerman.id.au>
Cc: jallen@linux.vnet.ibm.com
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 21:41:54 -0600
MIME-Version: 1.0
In-Reply-To: <1487214078-3893-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Message-Id: <aa351118-d400-be1e-5b48-136eefc9ca7d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2017 09:01 PM, Michael Ellerman wrote:
> We broke the build when CONFIG_MEMORY_HOTREMOVE=n:
> 
>   arch/powerpc/platforms/pseries/hotplug-memory.c:821:8: error: implicit
>   declaration of function 'dlpar_memory_readd_by_index'
> 
> Add a dummy to fix it.
> 
> Fixes: e70d59700fc3 ("powerpc/pseries: Introduce memory hotplug READD operation")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Looks like we both saw the same thing today, this was patch 1/4 in the
'Implement indexed-count memory hotplug'​ patchset I sent out earlier today.
Perhaps I should have sent that as a separate patch.

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 3381c20edbc0..b3b92814ce87 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -628,7 +628,10 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
>  {
>  	return -EOPNOTSUPP;
>  }
> -
> +static int dlpar_memory_readd_by_index(u32 drc_index, struct property *prop)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> 
>  static int dlpar_add_lmb(struct of_drconf_cell *lmb)
> 
