Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92EC12C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 14:15:52 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 13:15:52 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EED993578040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 14:15:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r982wmwV61931534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 13:58:48 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r983FhOw017535
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 14:15:43 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH -V2 1/2] powerpc: Use HPTE constants when updating hpte
 bits
In-Reply-To: <1380810140-11015-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1380810140-11015-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 08 Oct 2013 08:45:38 +0530
Message-ID: <87eh7wo3l1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> Even though we have same value for linux PTE bits and hash PTE pits
> use the hash pte bits wen updating hash pte

...
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 02d6e21..78f2c59 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -146,8 +146,9 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
>  	flags = 0;
>
>  	/* Make pHyp happy */
> -	if ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU))
> -		hpte_r &= ~_PAGE_COHERENT;
> +	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
> +		hpte_r &= ~HPTE_R_M;
> +

-	if ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU))
+	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))

the if loop part of the change is already done in upstream. Since V2
was generated after moving V1 patch to a different tree (kvm tree),
ended up with that additional change. Let me know if you want me
respin the patch

>  	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
>  		flags |= H_COALESCE_CAND;
>

-aneesh
