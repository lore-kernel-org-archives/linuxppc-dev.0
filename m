Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBBF1B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 01:35:14 +1100 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Liu Gang <Gang.Liu@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/srio: Fix the relocation errors when building
 with 64bit
Date: Tue, 6 Mar 2012 14:35:02 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D10102FC@corpmail1.na.ads.idt.com>
References: <1331002692-9061-1-git-send-email-Gang.Liu@freescale.com>
In-Reply-To: <1331002692-9061-1-git-send-email-Gang.Liu@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "r58472@freescale.com" <r58472@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "r61911@freescale.com" <r61911@freescale.com>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, March 05, 2012 9:58 PM, Liu Gang wrote:
> Subject: [PATCH] powerpc/srio: Fix the relocation errors when building
> with 64bit
>=20
> For the file "arch/powerpc/sysdev/fsl_rio.c", there will be some
> relocation errors while using the corenet64_smp_defconfig:
>=20
> WARNING: modpost: Found 6 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/powerpc/sysdev/built-in.o:(__ex_table+0x0):
> 	relocation truncated to fit: R_PPC64_ADDR16 against `.text'+3208
> arch/powerpc/sysdev/built-in.o:(__ex_table+0x2):
> 	relocation truncated to fit: R_PPC64_ADDR16 against `.fixup'
> arch/powerpc/sysdev/built-in.o:(__ex_table+0x4):
> 	relocation truncated to fit: R_PPC64_ADDR16 against `.text'+3230
> arch/powerpc/sysdev/built-in.o:(__ex_table+0x6):
> 	relocation truncated to fit: R_PPC64_ADDR16 against `.fixup'+c
> arch/powerpc/sysdev/built-in.o:(__ex_table+0x8):
> 	relocation truncated to fit: R_PPC64_ADDR16 against `.text'+3250
> arch/powerpc/sysdev/built-in.o:(__ex_table+0xa):
> 	relocation truncated to fit: R_PPC64_ADDR16 against `.fixup'+18
>=20
> Rewrote the corresponding code with the support of 64bit building.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rio.c
> b/arch/powerpc/sysdev/fsl_rio.c index a4c4f4a..5b6f556 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -66,8 +66,8 @@
>  		"	li %0,%3\n"			\
>  		"	b 2b\n"				\
>  		".section __ex_table,\"a\"\n"		\
> -		"	.align 2\n"			\
> -		"	.long 1b,3b\n"			\
> +			PPC_LONG_ALIGN "\n"		\
> +			PPC_LONG "1b,3b\n"		\
>  		".text"					\
>  		: "=3Dr" (err), "=3Dr" (x)			\
>  		: "b" (addr), "i" (-EFAULT), "0" (err))
> --
> 1.7.0.4
>=20

Looks good to me. Ack-ed.
