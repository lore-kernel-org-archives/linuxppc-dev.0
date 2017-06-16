Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpyY62lffzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 21:18:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com,
 hbabu@us.ibm.com, linuxram@us.ibm.com
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection key
 violation.
In-Reply-To: <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
Date: Fri, 16 Jun 2017 21:18:29 +1000
Message-ID: <87zid8uqnu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 8036b38..109d0c2 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -49,6 +49,8 @@ struct pt_regs {
>  	unsigned long dar;		/* Fault registers */
>  	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
>  	unsigned long result;		/* Result of a system call */
> +	unsigned long dscr;		/* contents of the DSCR register */
> +	unsigned long amr;		/* contents of AMR register */
>  };

You can't change pt_regs, it's ABI.

> @@ -109,7 +111,8 @@ struct pt_regs {
>  #define PT_DSISR 42
>  #define PT_RESULT 43
>  #define PT_DSCR 44
> -#define PT_REGS_COUNT 44
> +#define PT_AMR 45
> +#define PT_REGS_COUNT 45

You can add PT_AMR, but it has to be synthetic like DSCR, ie. not
actually in pt_regs but available via ptrace.

But do we want to do that? How does the x86 code export the key(s) of a
process? Or doesn't it?

cheers
