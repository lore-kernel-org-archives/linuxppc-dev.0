Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BA0B1A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jul 2014 05:59:29 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 15:59:25 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EB3C338C8027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 15:59:22 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6AJxM1Q3342674
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 19:59:22 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6AJxMwj001293
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 15:59:22 -0400
Message-ID: <53BEF099.5020705@linux.vnet.ibm.com>
Date: Thu, 10 Jul 2014 14:59:21 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/pseries: dynamically added OF nodes need to
 call of_node_init
References: <1405018257-35616-1-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1405018257-35616-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: grant.likely@linaro.org, mdroth@linux.vnet.ibm.com, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2014 01:50 PM, Tyrel Datwyler wrote:
> Commit 75b57ecf9 refactored device tree nodes to use kobjects such that they
> can be exposed via /sysfs. A secondary commit 0829f6d1f furthered this rework
> by moving the kobect initialization logic out of of_node_add into its own
> of_node_init function. The inital commit removed the existing kref_init calls
> in the pseries dlpar code with the assumption kobject initialization would
> occur in of_node_add. The second commit had the side effect of triggering a
> BUG_ON during DLPAR, migration and suspend/resume operations as a result of
> dynamically added nodes being uninitialized.
> 
> This patch fixes this by adding of_node_init calls in place of the previously
> removed kref_init calls.
> 
> Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> V2:
>  - included stable kernel list on Cc per comment by mpe
> 
>  arch/powerpc/platforms/pseries/dlpar.c    | 1 +
>  arch/powerpc/platforms/pseries/reconfig.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 022b38e..2d0b4d6 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -86,6 +86,7 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
>  	}
>  
>  	of_node_set_flag(dn, OF_DYNAMIC);
> +	of_node_init(dn);
>  
>  	return dn;
>  }
> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
> index 0435bb6..1c0a60d 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -69,6 +69,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
>  
>  	np->properties = proplist;
>  	of_node_set_flag(np, OF_DYNAMIC);
> +	of_node_init(np);
>  
>  	np->parent = derive_parent(path);
>  	if (IS_ERR(np->parent)) {
> 
