Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91DDE1A02BE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 08:03:19 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D845D14007C
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2014 08:03:18 +1000 (EST)
Message-ID: <1402610584.14780.88.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add AT_HWCAP2 to indicate V.CRYPTO category
 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
Date: Fri, 13 Jun 2014 08:03:04 +1000
In-Reply-To: <OF26AC1193.59958340-ON85257CF5.00528030-86257CF5.0053A37D@us.ibm.com>
References: <1402376680.14780.12.camel@pasglop>
 <OF26AC1193.59958340-ON85257CF5.00528030-86257CF5.0053A37D@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Adhemerval Zanella <azanella@linux.vnet.ibm.com>,
 Michael J Wolf <mjwolf@us.ibm.com>, Hanns-Joachim Uhl <hannsj_uhl@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-12 at 10:13 -0500, Steve Munroe wrote:
> The precedent we have used is that features that refer to ISA Categories include _HAS_ following the PPC_FEATURE[2]. So GLIBC specifies in hwcap.h:
> 
> /* Feature definitions in AT_HWCAP2.  */
> #define PPC_FEATURE2_ARCH_2_07     0x80000000 /* ISA 2.07 */
> #define PPC_FEATURE2_HAS_HTM       0x40000000 /* Hardware Transactional
>                                                  Memory */
> #define PPC_FEATURE2_HAS_DSCR      0x20000000 /* Data Stream Control
>                                                  Register */
> #define PPC_FEATURE2_HAS_EBB       0x10000000 /* Event Base Branching */
> #define PPC_FEATURE2_HAS_ISEL      0x08000000 /* Integer Select */
> #define PPC_FEATURE2_HAS_TAR       0x04000000 /* Target Address Register */
> 
> This was carried from the original AT_HWCAP defines.

Off, they don't have the "HAS" in the kernel definitions...

> $ grep _HAS_ ./sysdeps/powerpc/bits/hwcap.h
> #define PPC_FEATURE_HAS_ALTIVEC    0x10000000 /* SIMD/Vector Unit.  */
> #define PPC_FEATURE_HAS_FPU    0x08000000 /* Floating Point Unit.  */
> #define PPC_FEATURE_HAS_MMU    0x04000000 /* Memory Management Unit.  */
> #define PPC_FEATURE_HAS_4xxMAC    0x02000000 /* 4xx Multiply Accumulator.  */
> #define PPC_FEATURE_HAS_SPE    0x00800000 /* Signal Processing ext.  */
> #define PPC_FEATURE_HAS_EFP_SINGLE  0x00400000 /* SPE Float.  */
> #define PPC_FEATURE_HAS_EFP_DOUBLE  0x00200000 /* SPE Double.  */
> #define PPC_FEATURE_HAS_DFP    0x00000400 /* Decimal FP Unit */
> #define PPC_FEATURE_HAS_VSX    0x00000080 /* P7 Vector Extension.  */
> 
> So could we agree on PPC_FEATURE2_HAS_VEC_CRYPTO or the shorter PPC_FEATURE2_HAS_VCRYPTO?

Well, I made it consistent with the other HWCAP2 bits exposed by the
kernel which seem to differ from the glibc versions :-(

In any case, I've merged it but I can do a follow up patch that adds
the _HAS_ everywhere, hopefully nobody in userspace use the kernel
definition and they use the glibc one instead.

In that case, go for VCRYPTO.

Cheers,
Ben.

> Steven J. Munroe
> Linux on Power Toolchain Architect
> IBM Corporation, Linux Technology Center
> 
> 
> Inactive hide details for Benjamin Herrenschmidt ---06/10/2014 12:05:07 AM---The Vector Crypto category instructions are supporBenjamin Herrenschmidt ---06/10/2014 12:05:07 AM---The Vector Crypto category instructions are supported by current POWER8 chips, advertise them to use
> 
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> To: linuxppc-dev@ozlabs.org
> Cc: Steve Munroe/Rochester/IBM@IBMUS, Hanns-Joachim Uhl <hannsj_uhl@de.ibm.com>, Diane Brent/Poughkeepsie/IBM@IBMUS, Jeffrey Scheel/Rochester/IBM@IBMUS, Adhemerval Zanella <azanella@linux.vnet.ibm.com>
> Date: 06/10/2014 12:05 AM
> Subject: [PATCH] powerpc: Add AT_HWCAP2 to indicate V.CRYPTO category support
> 
> 
> 
> ______________________________________________________________________
> 
> 
> 
> The Vector Crypto category instructions are supported by current POWER8
> chips, advertise them to userspace using a specific bit to properly
> differentiate with chips of the same architecture level that might not
> have them.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org> [v3.10+]
> --
> 
> diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
> index 5b76579..de2c0e4 100644
> --- a/arch/powerpc/include/uapi/asm/cputable.h
> +++ b/arch/powerpc/include/uapi/asm/cputable.h
> @@ -41,5 +41,6 @@
> #define PPC_FEATURE2_EBB 0x10000000
> #define PPC_FEATURE2_ISEL 0x08000000
> #define PPC_FEATURE2_TAR 0x04000000
> +#define PPC_FEATURE2_VEC_CRYPTO 0x02000000
> 
> #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index c1faade..11da04a 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -109,7 +109,8 @@ extern void __restore_cpu_e6500(void);
>  PPC_FEATURE_PSERIES_PERFMON_COMPAT)
> #define COMMON_USER2_POWER8 (PPC_FEATURE2_ARCH_2_07 | \
>  PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_DSCR | \
> -  PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR)
> +  PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | \
> +  PPC_FEATURE2_VEC_CRYPTO)
> #define COMMON_USER_PA6T (COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
>  PPC_FEATURE_TRUE_LE | \
>  PPC_FEATURE_HAS_ALTIVEC_COMP)
> 
> 
> 
