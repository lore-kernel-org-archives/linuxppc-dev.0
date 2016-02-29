Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15ED21A005D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 03:50:44 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 09:50:42 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C38B03E40048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 09:50:38 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1TGocjn46334206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 09:50:38 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1TGoboU023548
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 09:50:37 -0700
Subject: Re: [PATCH] powerpc/lpar: Don't crash on H_PROTECT errors
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1456746752-9298-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-ID: <56D476DD.9060402@linux.vnet.ibm.com>
Date: Mon, 29 Feb 2016 08:50:37 -0800
MIME-Version: 1.0
In-Reply-To: <1456746752-9298-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/29/2016 03:52 AM, Anshuman Khandual wrote:
> There are certain condition in which H_PROTECT can return error code
> other than H_NOT_FOUND and H_SUCCESS. One such being an attempt to
> update an hpte owned by adjunct partition. Return 0 in that case so
> that user space will retry the access. In adjunct case this mean we
> will not make much progress in the user space. But atleast we get a
> chance to kill the task and avoid taking down the entire box.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/lpar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 477290a..31bcdaf 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -310,7 +310,7 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
>  
>  	pr_devel("ok\n");
>  
> -	BUG_ON(lpar_rc != H_SUCCESS);
> +	WARN_RATELIMIT(lpar_rc != H_SUCCESS, "H_PROTECT returned %lu\n", lpar_rc);

In the event that we don't get H_NOT_FOUND (which is handled earlier in
the function) or H_SUCCESS this patch assumes H_RESOURCE. It fails to
handle H_PARAMETER which is also a valid return from the H_PROTECT
hypercall.

-Tyrel

>  
>  	return 0;
>  }
> 
