Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9AF1A0032
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:53:01 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 7 Oct 2015 13:52:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CED232BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:52:56 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t973qm701900910
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 14:52:56 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t973qOQf022742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 14:52:24 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] cxl: Fix number of allocated pages in SPA
In-reply-to: <1444141189-16621-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1444141189-16621-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Wed, 07 Oct 2015 14:51:58 +1100
Message-Id: <1444189526-sup-3467@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The explanation probably still needs to be expanded more (e.g. this
could cause a crash for an AFU that supports more than about a thousand
processes) - see my other email in reply to v1 for more, but I'm happy
for this to go in as is (but ultimately that's mpe's call).

It should also be CCd to stable, this bug was introduced before the
driver was originally upstreamed, we just never hit it because all our
AFUs are limited to less processes by their interrupt requirements.

Cc: stable <stable@vger.kernel.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Christophe Lombard's message of 2015-10-07 01:19:49 +1100:
> This moves the initialisation of the num_procs to before the SPA
> allocation.
> The field 'num_procs' of the structure cxl_afu is not updated to the
> right value (maximum number of processes that can be supported by
> the AFU) when the pages are allocated (i.e. when  cxl_alloc_spa() is called).
> The number of allocates pages depends on the max number of processes.
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
