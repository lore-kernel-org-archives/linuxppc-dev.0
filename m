Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHs6D6KnKzDvYt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:39:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [powerpc v5 2/3] Detect instruction fetch denied and report
In-Reply-To: <1479125778-18496-3-git-send-email-bsingharora@gmail.com>
References: <1479125778-18496-1-git-send-email-bsingharora@gmail.com>
 <1479125778-18496-3-git-send-email-bsingharora@gmail.com>
Date: Tue, 15 Nov 2016 13:39:16 +1100
Message-ID: <87eg2dzctn.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> ISA 3 allows for prevention of instruction fetch and execution
> of user mode pages. If such an error occurs, SRR1 bit 35
> reports the error. We catch and report the error in do_page_fault()
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/fault.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index d0b137d..1e7ff7b 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -404,6 +404,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>  			goto bad_area;
> +
> +		if (regs->msr & SRR1_ISI_N_OR_G)
> +			goto bad_area;

Can you move that check above the more complicated check. It shouldn't
change anything in practice, but makes it easier to follow the code
because the easy cases can be discarded.

cheers
