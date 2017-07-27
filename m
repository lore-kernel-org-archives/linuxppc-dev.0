Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJQYx4dL2zDrKw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 07:47:33 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RLhlQu191522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 17:47:30 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2byj7a8pk4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 17:47:30 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 18:47:28 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6RLlRnF23199966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 18:47:27 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6RLlTJx002227
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 18:47:30 -0300
Date: Thu, 27 Jul 2017 18:47:21 -0300
From: joserz@linux.vnet.ibm.com
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sjitindarsingh@gmail.com
Subject: Re: [PATCH v2] powerpc/mm: Check for _PAGE_PTE in *_devmap()
References: <20170727153553.9160-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170727153553.9160-1-oohall@gmail.com>
Message-Id: <20170727214721.GA595@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 28, 2017 at 01:35:53AM +1000, Oliver O'Halloran wrote:
> The ISA radix translation tree contains two different types of entry,
> directories and leaves. The formats of the two entries are different
> with the directory entries containing no spare bits for use by software.
> As a result we need to ensure that the *_devmap() family of functions
> check fail for everything except leaf (PTE) entries.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> "i'll just tweak the mbox before i sent it, what's the worst that can happen"
> *completely breaks KVM*
> "..."
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index d1da415..6bc6248 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -610,7 +610,9 @@ static inline pte_t pte_mkdevmap(pte_t pte)
> 
>  static inline int pte_devmap(pte_t pte)
>  {
> -	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
> +	uint64_t mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
> +
> +	return (pte_raw(pte) & mask) == mask;
>  }
> 
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> -- 
> 2.7.4
> 

Michael should thank you because I was about to send another insane
suggestion and ask him if that makes sense. :-D

Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
