Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 152651A0356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 20:39:24 +1100 (AEDT)
In-Reply-To: <56A25783.7040502@linux.vnet.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] Fix si->si_code for guard page access on PowerPC
Message-Id: <20160224093923.EC10314090A@ozlabs.org>
Date: Wed, 24 Feb 2016 20:39:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gustavo,

On Fri, 2016-22-01 at 16:23:31 UTC, Gustavo Romero wrote:
> Fix si->si_code for guard page access on PowerPC
> 
...
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a67c6d7..6954971 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -431,8 +431,10 @@ good_area:
>             */
>            fault = handle_mm_fault(mm, vma, address, flags);
>            if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
> -                  if (fault & VM_FAULT_SIGSEGV)
> +                  if (fault & VM_FAULT_SIGSEGV) {
> +                           code = SEGV_MAPERR;
>                              goto bad_area;
> +                  }
>                     rc = mm_fault_error(regs, address, fault);
>                     if (rc >= MM_FAULT_RETURN)
>                              goto bail;


As we discussed on IRC, I'd prefer if this case was handled in
mm_fault_error(). So please send a v2 which does that, or let us know if you
have problems.

cheers
