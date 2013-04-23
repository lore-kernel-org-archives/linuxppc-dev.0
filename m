Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 15:29:51 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Jia Hongtao <hongtao.jia@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: Move opcode definitions from kvm/emulate.c
 to asm/ppc-opcode.h
Message-ID: <20130423052951.GB20902@concordia>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 10:39:35AM +0800, Jia Hongtao wrote:
> Opcode and xopcode are useful definitions not just for KVM. Move these
> definitions to asm/ppc-opcode.h for public use.

Agreed. Though nearly everything else in ppc-opcode.h uses PPC_INST_FOO,
or at least PPC_FOO, any reason not to update these to match?

cheers

> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 8752bc8..18de83a 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -81,6 +81,51 @@
>  #define	__REGA0_R30	30
>  #define	__REGA0_R31	31
>  
> +/* opcode and xopcode for instructions */
> +#define OP_TRAP 3
> +#define OP_TRAP_64 2
> +
> +#define OP_31_XOP_TRAP      4
> +#define OP_31_XOP_LWZX      23
> +#define OP_31_XOP_LWZUX     55
> +#define OP_31_XOP_TRAP_64   68
> +#define OP_31_XOP_DCBF      86
> +#define OP_31_XOP_LBZX      87
> +#define OP_31_XOP_STWX      151
> +#define OP_31_XOP_STBX      215
> +#define OP_31_XOP_LBZUX     119
> +#define OP_31_XOP_STBUX     247
> +#define OP_31_XOP_LHZX      279
> +#define OP_31_XOP_LHZUX     311
> +#define OP_31_XOP_MFSPR     339
> +#define OP_31_XOP_LHAX      343
> +#define OP_31_XOP_STHX      407
> +#define OP_31_XOP_STHUX     439
> +#define OP_31_XOP_MTSPR     467
> +#define OP_31_XOP_DCBI      470
> +#define OP_31_XOP_LWBRX     534
> +#define OP_31_XOP_TLBSYNC   566
> +#define OP_31_XOP_STWBRX    662
> +#define OP_31_XOP_LHBRX     790
> +#define OP_31_XOP_STHBRX    918
> +
> +#define OP_LWZ  32
> +#define OP_LD   58
> +#define OP_LWZU 33
> +#define OP_LBZ  34
> +#define OP_LBZU 35
> +#define OP_STW  36
> +#define OP_STWU 37
> +#define OP_STD  62
> +#define OP_STB  38
> +#define OP_STBU 39
> +#define OP_LHZ  40
> +#define OP_LHZU 41
> +#define OP_LHA  42
> +#define OP_LHAU 43
> +#define OP_STH  44
> +#define OP_STHU 45
> +
>  /* sorted alphabetically */
>  #define PPC_INST_DCBA			0x7c0005ec
>  #define PPC_INST_DCBA_MASK		0xfc0007fe
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index 7a73b6f..426d3f5 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -30,52 +30,10 @@
>  #include <asm/byteorder.h>
>  #include <asm/kvm_ppc.h>
>  #include <asm/disassemble.h>
> +#include <asm/ppc-opcode.h>
>  #include "timing.h"
>  #include "trace.h"
>  
> -#define OP_TRAP 3
> -#define OP_TRAP_64 2
> -
> -#define OP_31_XOP_TRAP      4
> -#define OP_31_XOP_LWZX      23
> -#define OP_31_XOP_TRAP_64   68
> -#define OP_31_XOP_DCBF      86
> -#define OP_31_XOP_LBZX      87
> -#define OP_31_XOP_STWX      151
> -#define OP_31_XOP_STBX      215
> -#define OP_31_XOP_LBZUX     119
> -#define OP_31_XOP_STBUX     247
> -#define OP_31_XOP_LHZX      279
> -#define OP_31_XOP_LHZUX     311
> -#define OP_31_XOP_MFSPR     339
> -#define OP_31_XOP_LHAX      343
> -#define OP_31_XOP_STHX      407
> -#define OP_31_XOP_STHUX     439
> -#define OP_31_XOP_MTSPR     467
> -#define OP_31_XOP_DCBI      470
> -#define OP_31_XOP_LWBRX     534
> -#define OP_31_XOP_TLBSYNC   566
> -#define OP_31_XOP_STWBRX    662
> -#define OP_31_XOP_LHBRX     790
> -#define OP_31_XOP_STHBRX    918
> -
> -#define OP_LWZ  32
> -#define OP_LD   58
> -#define OP_LWZU 33
> -#define OP_LBZ  34
> -#define OP_LBZU 35
> -#define OP_STW  36
> -#define OP_STWU 37
> -#define OP_STD  62
> -#define OP_STB  38
> -#define OP_STBU 39
> -#define OP_LHZ  40
> -#define OP_LHZU 41
> -#define OP_LHA  42
> -#define OP_LHAU 43
> -#define OP_STH  44
> -#define OP_STHU 45
> -
>  void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long dec_nsec;
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
