Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6C9B1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 11:24:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 6 Oct 2015 10:24:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DC0B2357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 11:24:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t960OA0Q42598414
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 11:24:19 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t960Noms031994
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 11:23:50 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cxl: Fix number of allocated pages in SPA
In-reply-to: <1443794485-30565-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1443794485-30565-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Tue, 06 Oct 2015 11:23:20 +1100
Message-Id: <1444090988-sup-9677@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Christophe Lombard's message of 2015-10-03 00:01:25 +1000:
> This moves the initialisation of the num_procs to before the SPA
> allocation.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/native.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index b37f2e8..d2e75c8 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -457,6 +457,7 @@ static int activate_afu_directed(struct cxl_afu *afu)
>  
>      dev_info(&afu->dev, "Activating AFU directed mode\n");
>  
> +    afu->num_procs = afu->max_procs_virtualised;
>      if (afu->spa == NULL) {
>          if (cxl_alloc_spa(afu))
>              return -ENOMEM;
> @@ -468,7 +469,6 @@ static int activate_afu_directed(struct cxl_afu *afu)
>      cxl_p1n_write(afu, CXL_PSL_ID_An, CXL_PSL_ID_An_F | CXL_PSL_ID_An_L);
>  
>      afu->current_mode = CXL_MODE_DIRECTED;
> -    afu->num_procs = afu->max_procs_virtualised;
>  
>      if ((rc = cxl_chardev_m_afu_add(afu)))
>          return rc;
