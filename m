Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71D3E1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 00:39:41 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9315F14009B
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 00:39:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Apr 2015 20:09:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 657C3E0044
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 20:12:13 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3LEdXvA54132882
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 20:09:34 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3LEdXsR013442
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 20:09:33 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc,
 mm: Fix build failure due to CONFIG_PPC_TRANSACTIONAL_MEM
In-Reply-To: <1429614284-16528-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1429614284-16528-1-git-send-email-khandual@linux.vnet.ibm.com>
Date: Tue, 21 Apr 2015 20:09:32 +0530
Message-ID: <87mw21ilzv.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> The function flush_hash_page fails to compile when the transaction memory
> config option is turned off because there is a label at end of compound
> statement. This patch moves the code block into a function tm_abort_tlbi
> and calls it after the label thus fixing the build problem.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> arch/powerpc/mm/hash_utils_64.c: In function =E2=80=98flush_hash_hugepage=
=E2=80=99:
> arch/powerpc/mm/hash_utils_64.c:1381:1: error: label at end of compound s=
tatement
>  tm_abort:
>  ^
> make[1]: *** [arch/powerpc/mm/hash_utils_64.o] Error 1
> make: *** [arch/powerpc/mm] Error 2
>
>  arch/powerpc/mm/hash_utils_64.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index 2c2022d..b30b2b5 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1326,6 +1326,25 @@ void flush_hash_page(unsigned long vpn, real_pte_t=
 pte, int psize, int ssize,
>  }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static void tm_abort_tlbi(int local)
> +{
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	/* Transactions are not aborted by tlbiel, only tlbie.
> +	 * Without, syncing a page back to a block device w/ PIO could pick up
> +	 * transactional data (bad!) so we force an abort here.  Before the
> +	 * sync the page will be made read-only, which will flush_hash_page.
> +	 * BIG ISSUE here: if the kernel uses a page from userspace without
> +	 * unmapping it first, it may see the speculated version.
> +	 */
> +	if (local && cpu_has_feature(CPU_FTR_TM) &&
> +	    current->thread.regs &&
> +	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
> +		tm_enable();
> +		tm_abort(TM_CAUSE_TLBI);
> +	}
> +#endif
> +}
> +
>  void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
>  			 pmd_t *pmdp, unsigned int psize, int ssize,
>  			 unsigned long flags)
> @@ -1379,21 +1398,7 @@ void flush_hash_hugepage(unsigned long vsid, unsig=
ned long addr,
>  				       MMU_PAGE_16M, ssize, local);
>  	}
>  tm_abort:
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	/* Transactions are not aborted by tlbiel, only tlbie.
> -	 * Without, syncing a page back to a block device w/ PIO could pick up
> -	 * transactional data (bad!) so we force an abort here.  Before the
> -	 * sync the page will be made read-only, which will flush_hash_page.
> -	 * BIG ISSUE here: if the kernel uses a page from userspace without
> -	 * unmapping it first, it may see the speculated version.
> -	 */
> -	if (local && cpu_has_feature(CPU_FTR_TM) &&
> -	    current->thread.regs &&
> -	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
> -		tm_enable();
> -		tm_abort(TM_CAUSE_TLBI);
> -	}
> -#endif
> +	tm_abort_tlbi(local);
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> --=20

Why not just do ?. I will send a seperate patch=20


commit 52b6dcc8fe34b9d05b8a0f14d45fcdc3bef6c84f
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Tue Apr 21 19:51:10 2015 +0530

    powerpc/mm: Fix build error with CONFIG_PPC_TRANSACTIONAL_MEM disabled
=20=20=20=20
    This fix the below build error
=20=20=20=20
    arch/powerpc/mm/hash_utils_64.c: In function =E2=80=98flush_hash_hugepa=
ge=E2=80=99:
    arch/powerpc/mm/hash_utils_64.c:1381:1: error: label at end of compound=
 statement
     tm_abort:
     ^
    make[1]: *** [arch/powerpc/mm/hash_utils_64.o] Error 1
=20=20=20=20
    Reported-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_6=
4.c
index 2c2022d16059..ac5c4373cd8b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1394,6 +1394,7 @@ tm_abort:
 		tm_abort(TM_CAUSE_TLBI);
 	}
 #endif
+	return;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
=20
