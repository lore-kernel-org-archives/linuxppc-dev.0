Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 689642C00A4
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Aug 2013 22:21:18 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 29 Aug 2013 22:12:40 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AB07B2CE804D
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Aug 2013 22:21:07 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7TCKtkb44564712
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Aug 2013 22:20:56 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7TCL6b7000500
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Aug 2013 22:21:06 +1000
Message-ID: <521F3CA8.5040707@linux.vnet.ibm.com>
Date: Thu, 29 Aug 2013 17:50:56 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH V2] powerpc: Convert out of line __arch_hweight to inline
References: <1375874338-30709-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1375874338-30709-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben

On Wednesday 07 August 2013 04:48 PM, Madhavan Srinivasan wrote:
> Patch attempts to improve the performace of __arch_hweight functions by
> making them inline instead of current out of line implementation.
> 
> Testcase is to disable/enable SMT on a large (192 thread) POWER7 lpar.
> Program used for SMT disable/enable is "ppc64_cpu" with "--smt=[off/on]"
> option. Here are the perf output. In this case, __arch_hweight64 is
> called by __bitmap_weight.
> 
> Without patch (ppc64_cpu --smt=off):
> 
>  17.60%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
> ....
>   4.85%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
> ....
>   1.36%  ppc64_cpu  [kernel.kallsyms]               [k] .__disable_runtime
>   1.29%  ppc64_cpu  [kernel.kallsyms]               [k] .__arch_hweight64
> 
> 
> With patch (ppc64_cpu --smt=off):
> 
>  17.29%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
> ....
>   3.71%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
>   3.26%  ppc64_cpu  [kernel.kallsyms]               [k] .build_overlap_sched_groups
> ....
> 
> Without patch (ppc64_cpu --smt=on):
> 
>   8.35%  ppc64_cpu  [kernel.kallsyms]               [k] .strlen
>   7.00%  ppc64_cpu  [kernel.kallsyms]               [k] .memset
>   6.78%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
>   4.23%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
> ....
>   1.58%  ppc64_cpu  [kernel.kallsyms]               [k] .refresh_zone_stat_thresholds
>   1.57%  ppc64_cpu  [kernel.kallsyms]               [k] .__arch_hweight64
>   1.54%  ppc64_cpu  [kernel.kallsyms]               [k] .__enable_runtime
> ....
> 
> With patch (ppc64_cpu --smt=on):
> 
>   9.44%  ppc64_cpu  [kernel.kallsyms]               [k] .strlen
>   6.43%  ppc64_cpu  [kernel.kallsyms]               [k] .memset
>   5.48%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
>   4.59%  ppc64_cpu  [kernel.kallsyms]               [k] .insert_entry
>   4.29%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
> ....
> 
> Patch changes v2:
> 
> 1. Removed the arch/powerpc/lib/hweight_64.S file.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>


Any question or suggestion for this patch.


> ---
>  arch/powerpc/include/asm/bitops.h     |  130 ++++++++++++++++++++++++++++++++-
>  arch/powerpc/include/asm/ppc-opcode.h |    6 ++
>  arch/powerpc/lib/Makefile             |    2 +-
>  arch/powerpc/lib/hweight_64.S         |  110 ----------------------------
>  4 files changed, 133 insertions(+), 115 deletions(-)
>  delete mode 100644 arch/powerpc/lib/hweight_64.S
> 
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index 910194e..136fe6a 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -43,8 +43,10 @@
>  #endif
> 
>  #include <linux/compiler.h>
> +#include <linux/types.h>
>  #include <asm/asm-compat.h>
>  #include <asm/synch.h>
> +#include <asm/cputable.h>
> 
>  /*
>   * clear_bit doesn't imply a memory barrier
> @@ -263,10 +265,130 @@ static __inline__ int fls64(__u64 x)
>  #endif /* __powerpc64__ */
> 
>  #ifdef CONFIG_PPC64
> -unsigned int __arch_hweight8(unsigned int w);
> -unsigned int __arch_hweight16(unsigned int w);
> -unsigned int __arch_hweight32(unsigned int w);
> -unsigned long __arch_hweight64(__u64 w);
> +
> +static inline unsigned int __arch_hweight8(unsigned int w)
> +{
> +	unsigned int register iop asm("r3") = w;
> +	unsigned int register tmp asm("r4");
> +	__asm__ __volatile__ (
> +	stringify_in_c(BEGIN_FTR_SECTION)
> +	"bl .__sw_hweight8;"
> +	"nop;"
> +	stringify_in_c(FTR_SECTION_ELSE)
> +	PPC_POPCNTB_M(%1,%2) ";"
> +	"clrldi %0,%1,64-8;"
> +	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
> +	: "=r" (iop), "=r" (tmp)
> +	: "r" (iop), "i" (CPU_FTR_POPCNTB)
> +	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
> +	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
> +
> +	return iop;
> +}
> +
> +static inline unsigned int __arch_hweight16(unsigned int w)
> +{
> +	unsigned int register iop asm("r3") = w;
> +	unsigned int register tmp asm("r4");
> +	__asm__ __volatile__ (
> +	stringify_in_c(BEGIN_FTR_SECTION)
> +	"bl .__sw_hweight16;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	stringify_in_c(FTR_SECTION_ELSE)
> +		stringify_in_c(BEGIN_FTR_SECTION_NESTED(50))
> +		PPC_POPCNTB_M(%0,%2) ";"
> +		"srdi %1,%0,8;"
> +		"add %0,%1,%0;"
> +		"clrldi %0,%0,64-8;"
> +		stringify_in_c(FTR_SECTION_ELSE_NESTED(50))
> +		"clrlwi %0,%2,16;"
> +		PPC_POPCNTW_M(%1,%0) ";"
> +		"clrldi %0,%1,64-8;"
> +		stringify_in_c(ALT_FTR_SECTION_END_NESTED_IFCLR(%4,50))
> +	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
> +	: "=r" (iop), "=r" (tmp)
> +	: "r" (iop), "i" (CPU_FTR_POPCNTB), "i" (CPU_FTR_POPCNTD)
> +	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
> +	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
> +
> +	return iop;
> +}
> +
> +static inline unsigned int __arch_hweight32(unsigned int w)
> +{
> +	unsigned int register iop asm("r3") = w;
> +	unsigned int register tmp asm("r4");
> +	__asm__ __volatile__ (
> +	stringify_in_c(BEGIN_FTR_SECTION)
> +	"bl .__sw_hweight32;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	stringify_in_c(FTR_SECTION_ELSE)
> +		stringify_in_c(BEGIN_FTR_SECTION_NESTED(51))
> +		PPC_POPCNTB_M(%0,%2) ";"
> +		"srdi %1,%0,16;"
> +		"add %0,%1,%0;"
> +		"srdi %1,%0,8;"
> +		"add %0,%1,%0;"
> +		"clrldi %0,%0,64-8;"
> +		stringify_in_c(FTR_SECTION_ELSE_NESTED(51))
> +		PPC_POPCNTW_M(%1,%2) ";"
> +		"clrldi %0,%1,64-8;"
> +		stringify_in_c(ALT_FTR_SECTION_END_NESTED_IFCLR(%4,51))
> +	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
> +	: "=r" (iop), "=r" (tmp)
> +	: "r" (iop), "i" (CPU_FTR_POPCNTB), "i" (CPU_FTR_POPCNTD)
> +	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
> +	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
> +
> +	return iop;
> +}
> +
> +static inline __u64 __arch_hweight64(__u64 w)
> +{
> +	__u64 register iop asm("r3") = w;
> +	__u64 register tmp asm("r4");
> +	__asm__ __volatile__ (
> +	stringify_in_c(BEGIN_FTR_SECTION)
> +	"bl .__sw_hweight64;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	"nop;"
> +	stringify_in_c(FTR_SECTION_ELSE)
> +		stringify_in_c(BEGIN_FTR_SECTION_NESTED(52))
> +		PPC_POPCNTB_M(%0,%2) ";"
> +		"srdi %1,%0,32;"
> +		"add %0,%1,%0;"
> +		"srdi %1,%0,16;"
> +		"add %0,%1,%0;"
> +		"srdi %1,%0,8;"
> +		"add %0,%1,%0;"
> +		"clrldi %0,%0,64-8;"
> +		stringify_in_c(FTR_SECTION_ELSE_NESTED(52))
> +		PPC_POPCNTD_M(%1,%2) ";"
> +		"clrldi %0,%1,64-8;"
> +		stringify_in_c(ALT_FTR_SECTION_END_NESTED_IFCLR(%4,52))
> +	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
> +	: "=r" (iop), "=r" (tmp)
> +	: "r" (iop), "i" (CPU_FTR_POPCNTB), "i" (CPU_FTR_POPCNTD)
> +	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
> +	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
> +
> +	return iop;
> +}
> +
>  #include <asm-generic/bitops/const_hweight.h>
>  #else
>  #include <asm-generic/bitops/hweight.h>
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index eccfc16..fc8767a 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -245,6 +245,12 @@
>  					__PPC_RA(a) | __PPC_RS(s))
>  #define PPC_POPCNTW(a, s)	stringify_in_c(.long PPC_INST_POPCNTW | \
>  					__PPC_RA(a) | __PPC_RS(s))
> +#define PPC_POPCNTB_M(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
> +					___PPC_RA(a) | ___PPC_RS(s))
> +#define PPC_POPCNTD_M(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
> +					___PPC_RA(a) | ___PPC_RS(s))
> +#define PPC_POPCNTW_M(a, s)	stringify_in_c(.long PPC_INST_POPCNTW | \
> +					___PPC_RA(a) | ___PPC_RS(s))
>  #define PPC_RFCI		stringify_in_c(.long PPC_INST_RFCI)
>  #define PPC_RFDI		stringify_in_c(.long PPC_INST_RFDI)
>  #define PPC_RFMCI		stringify_in_c(.long PPC_INST_RFMCI)
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 4504332..66f553d 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
> 
>  obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
>  			   memcpy_64.o usercopy_64.o mem_64.o string.o \
> -			   checksum_wrappers_64.o hweight_64.o \
> +			   checksum_wrappers_64.o \
>  			   copyuser_power7.o string_64.o copypage_power7.o \
>  			   memcpy_power7.o
>  obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
> diff --git a/arch/powerpc/lib/hweight_64.S b/arch/powerpc/lib/hweight_64.S
> deleted file mode 100644
> index 9b96ff2..0000000
> --- a/arch/powerpc/lib/hweight_64.S
> +++ /dev/null
> @@ -1,110 +0,0 @@
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> - *
> - * Copyright (C) IBM Corporation, 2010
> - *
> - * Author: Anton Blanchard <anton@au.ibm.com>
> - */
> -#include <asm/processor.h>
> -#include <asm/ppc_asm.h>
> -
> -/* Note: This code relies on -mminimal-toc */
> -
> -_GLOBAL(__arch_hweight8)
> -BEGIN_FTR_SECTION
> -	b .__sw_hweight8
> -	nop
> -	nop
> -FTR_SECTION_ELSE
> -	PPC_POPCNTB(R3,R3)
> -	clrldi	r3,r3,64-8
> -	blr
> -ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
> -
> -_GLOBAL(__arch_hweight16)
> -BEGIN_FTR_SECTION
> -	b .__sw_hweight16
> -	nop
> -	nop
> -	nop
> -	nop
> -FTR_SECTION_ELSE
> -  BEGIN_FTR_SECTION_NESTED(50)
> -	PPC_POPCNTB(R3,R3)
> -	srdi	r4,r3,8
> -	add	r3,r4,r3
> -	clrldi	r3,r3,64-8
> -	blr
> -  FTR_SECTION_ELSE_NESTED(50)
> -	clrlwi  r3,r3,16
> -	PPC_POPCNTW(R3,R3)
> -	clrldi	r3,r3,64-8
> -	blr
> -  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 50)
> -ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
> -
> -_GLOBAL(__arch_hweight32)
> -BEGIN_FTR_SECTION
> -	b .__sw_hweight32
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -FTR_SECTION_ELSE
> -  BEGIN_FTR_SECTION_NESTED(51)
> -	PPC_POPCNTB(R3,R3)
> -	srdi	r4,r3,16
> -	add	r3,r4,r3
> -	srdi	r4,r3,8
> -	add	r3,r4,r3
> -	clrldi	r3,r3,64-8
> -	blr
> -  FTR_SECTION_ELSE_NESTED(51)
> -	PPC_POPCNTW(R3,R3)
> -	clrldi	r3,r3,64-8
> -	blr
> -  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 51)
> -ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
> -
> -_GLOBAL(__arch_hweight64)
> -BEGIN_FTR_SECTION
> -	b .__sw_hweight64
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -FTR_SECTION_ELSE
> -  BEGIN_FTR_SECTION_NESTED(52)
> -	PPC_POPCNTB(R3,R3)
> -	srdi	r4,r3,32
> -	add	r3,r4,r3
> -	srdi	r4,r3,16
> -	add	r3,r4,r3
> -	srdi	r4,r3,8
> -	add	r3,r4,r3
> -	clrldi	r3,r3,64-8
> -	blr
> -  FTR_SECTION_ELSE_NESTED(52)
> -	PPC_POPCNTD(R3,R3)
> -	clrldi	r3,r3,64-8
> -	blr
> -  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 52)
> -ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
> 
