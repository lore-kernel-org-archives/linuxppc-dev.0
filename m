Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB4F5B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:13:27 +1100 (EST)
Subject: Re: [PATCH] powerpc/srio: Fix the relocation errors when building
 with 64bit
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331002692-9061-1-git-send-email-Gang.Liu@freescale.com>
Date: Fri, 16 Mar 2012 10:12:51 -0500
Message-Id: <5B36FC4C-E8D4-459C-8040-B7F4A3B88A77@kernel.crashing.org>
References: <1331002692-9061-1-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: r58472@freescale.com, paul.gortmaker@windriver.com,
 linux-kernel@vger.kernel.org, r61911@freescale.com, Alexandre.Bounine@idt.com,
 scottwood@freescale.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2012, at 8:58 PM, Liu Gang wrote:

> For the file "arch/powerpc/sysdev/fsl_rio.c", there will be some relocation
> errors while using the corenet64_smp_defconfig:
> 
> WARNING: modpost: Found 6 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>  GEN     .version
>  CHK     include/generated/compile.h
>  UPD     include/generated/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
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
> 
> Rewrote the corresponding code with the support of 64bit building.
> 
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_rio.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied

- k
