Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74D2D1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:23:51 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 21:23:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A3DDC2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:23:46 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAOBNVRx34734232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:23:39 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAOBNDTv016116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:23:14 +1100
Message-ID: <5654488F.8080302@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 16:52:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 04/31] powerpc/mm: make a separate copy for book3s
 (part 2)
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> Keep it seperate to make rebasing easier

This is confusing considering the fact that we are in between
some renaming/moving of header files, changing the references
they had before and so on. Could you please elaborate a bit
about what kind of changes this patch has and their purpose.

Also if the movement involves multiple parts (like this one),
it will be better to have detailed descriptions about each
step in the commit message of the first patch itself to see
how its being organized in the subsequent patches.

> 
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h | 4 ++--
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 6 +++---
>  arch/powerpc/include/asm/pgtable-ppc32.h     | 2 --
>  arch/powerpc/include/asm/pgtable-ppc64.h     | 4 ----
>  4 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 1a58a05be99c..a7738dfbe7e5 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -1,5 +1,5 @@
> -#ifndef _ASM_POWERPC_PGTABLE_PPC32_H
> -#define _ASM_POWERPC_PGTABLE_PPC32_H
> +#ifndef _ASM_POWERPC_BOOK3S_32_PGTABLE_H
> +#define _ASM_POWERPC_BOOK3S_32_PGTABLE_H

I guess this is missing here.

-#endif /* _ASM_POWERPC_PGTABLE_PPC32_H */
+#endif /* _ASM_POWERPC_BOOK3S_32_PGTABLE_H */
