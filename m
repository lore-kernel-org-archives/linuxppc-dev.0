Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gCJs0LzszF22V
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 18:27:08 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w488JI4P028067
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 May 2018 04:27:06 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hu6kwvwkk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 04:27:04 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 May 2018 09:27:03 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  02/17] powerpc/nohash: remove _PAGE_BUSY
In-Reply-To: <7332568467307f9fc79eeef47507909ddc423c4b.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <7332568467307f9fc79eeef47507909ddc423c4b.1525435203.git.christophe.leroy@c-s.fr>
Date: Tue, 08 May 2018 13:56:59 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9hqsgbw.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> _PAGE_BUSY is always 0, remove it
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/nohash/64/pgtable.h | 10 +++-------
>  arch/powerpc/include/asm/nohash/pte-book3e.h |  5 -----
>  2 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index 4f6f5a27bfb5..c3559d7a94fb 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -186,14 +186,12 @@ static inline unsigned long pte_update(struct mm_struct *mm,
>  
>  	__asm__ __volatile__(
>  	"1:	ldarx	%0,0,%3		# pte_update\n\
> -	andi.	%1,%0,%6\n\
> -	bne-	1b \n\
>  	andc	%1,%0,%4 \n\
> -	or	%1,%1,%7\n\
> +	or	%1,%1,%6\n\
>  	stdcx.	%1,0,%3 \n\
>  	bne-	1b"
>  	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
> -	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
> +	: "r" (ptep), "r" (clr), "m" (*ptep), "r" (set)
>  	: "cc" );
>  #else
>  	unsigned long old = pte_val(*ptep);
> @@ -290,13 +288,11 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
>  
>  	__asm__ __volatile__(
>  	"1:	ldarx	%0,0,%4\n\
> -		andi.	%1,%0,%6\n\
> -		bne-	1b \n\
>  		or	%0,%3,%0\n\
>  		stdcx.	%0,0,%4\n\
>  		bne-	1b"
>  	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
> -	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
> +	:"r" (bits), "r" (ptep), "m" (*ptep)
>  	:"cc");
>  #else
>  	unsigned long old = pte_val(*ptep);
> diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
> index 9ff51b4c0cac..12730b81cd98 100644
> --- a/arch/powerpc/include/asm/nohash/pte-book3e.h
> +++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
> @@ -57,13 +57,8 @@
>  #define _PAGE_USER		(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
>  #define _PAGE_PRIVILEGED	(_PAGE_BAP_SR)
>  
> -#define _PAGE_BUSY	0
> -
>  #define _PAGE_SPECIAL	_PAGE_SW0
>  
> -/* Flags to be preserved on PTE modifications */
> -#define _PAGE_HPTEFLAGS	_PAGE_BUSY
> -
>  /* Base page size */
>  #ifdef CONFIG_PPC_64K_PAGES
>  #define _PAGE_PSIZE	_PAGE_PSIZE_64K
> -- 
> 2.13.3
