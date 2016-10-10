Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sskj56ktHzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 13:34:17 +1100 (AEDT)
Date: Mon, 10 Oct 2016 13:34:15 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: PPC: sparse: prototypes for functions called
 from assembler
Message-ID: <20161010023415.GA18173@fergus.ozlabs.ibm.com>
References: <1476059480-18145-1-git-send-email-dja@axtens.net>
 <1476059480-18145-2-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476059480-18145-2-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2016 at 11:31:20AM +1100, Daniel Axtens wrote:
> A bunch of KVM functions are only called from assembler.
> Give them prototypes in asm-prototypes.h
> This reduces sparse warnings.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/include/asm/asm-prototypes.h | 44 +++++++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c       |  1 +
>  arch/powerpc/kvm/book3s_hv_builtin.c      |  1 +
>  arch/powerpc/kvm/book3s_hv_ras.c          |  1 +
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  1 +
>  arch/powerpc/kvm/book3s_hv_rm_xics.c      |  1 +
>  6 files changed, 49 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
> index d1492736d852..6c853bcd11fa 100644
> --- a/arch/powerpc/include/asm/asm-prototypes.h
> +++ b/arch/powerpc/include/asm/asm-prototypes.h
> @@ -14,6 +14,9 @@
>  
>  #include <linux/threads.h>
>  #include <linux/kprobes.h>
> +#ifdef CONFIG_KVM
> +#include <linux/kvm_host.h>
> +#endif
>  
>  #include <uapi/asm/ucontext.h>
>  
> @@ -109,4 +112,45 @@ void early_setup_secondary(void);
>  /* time */
>  void accumulate_stolen_time(void);
>  
> +/* kvm */
> +#ifdef CONFIG_KVM

Why do we need this ifdef?  Does the compilation break without it when
CONFIG_KVM = n?

Paul.
