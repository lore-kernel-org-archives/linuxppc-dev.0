Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CF422C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 01:24:51 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Jul 2013 20:46:13 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D7FBEE004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 20:54:34 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6MFPSTm40829032
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 20:55:29 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6MFOXdT015028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 01:24:34 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [PATCH] Fix a typo in pSeries_lpar_hpte_insert()
In-Reply-To: <1374470630-2106-1-git-send-email-kda@linux-powerpc.org>
References: <1374470630-2106-1-git-send-email-kda@linux-powerpc.org>
Date: Mon, 22 Jul 2013 20:54:31 +0530
Message-ID: <874nbmobww.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis Kirjanov <kda@linux-powerpc.org> writes:

> Fix a typo in pSeries_lpar_hpte_insert()
>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

looks good

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

We may want to add the commit that introduced the change ?

801eb73f45371accc78ca9d6d22d647eeb722c11


> ---
>  arch/powerpc/platforms/pseries/lpar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 0da39fe..c4112ed 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -136,7 +136,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
>  	flags = 0;
>
>  	/* Make pHyp happy */
> -	if ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU))
> +	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
>  		hpte_r &= ~_PAGE_COHERENT;
>  	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
>  		flags |= H_COALESCE_CAND;
> -- 
> 1.8.0.2
