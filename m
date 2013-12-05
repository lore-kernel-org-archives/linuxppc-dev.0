Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 160742C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 21:54:09 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Dec 2013 16:24:01 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 51F45394005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 16:23:58 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB5ArpEc65142824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 16:23:52 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB5ArvDo026883
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 16:23:57 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: mm: make _PAGE_NUMA take effect
In-Reply-To: <1386140348-7854-2-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386140348-7854-2-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Thu, 05 Dec 2013 16:23:56 +0530
Message-ID: <87a9gfva9n.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Liu Ping Fan <kernelfans@gmail.com> writes:

> To enable the do_numa_page(), we should not fix _PAGE_NUMA in
> hash_page(), so bail out for the case of pte_numa().
>
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index fb176e9..9bf1195 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1033,7 +1033,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>
>  	/* Get PTE and page size from page tables */
>  	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
> -	if (ptep == NULL || !pte_present(*ptep)) {
> +	if (ptep == NULL || !pte_present(*ptep) || pte_numa(*ptep)) {
>  		DBG_LOW(" no PTE !\n");
>  		rc = 1;
>  		goto bail;

why ? , All the hash routines do check for _PAGE_PRESENT via access
variable.

-aneesh
