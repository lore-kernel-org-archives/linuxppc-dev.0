Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWBV405drzDqtM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 17:20:12 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id us13so5274955pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 00:20:11 -0700 (PDT)
Subject: Re: [Patch v2 1/2] powerpc: Send SIGBUS on unaligned copy and paste
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
References: <20160616233340.GA14449@distroguy.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <13e8530c-80d6-5475-f4f2-3a46e4a75a76@gmail.com>
Date: Fri, 17 Jun 2016 17:20:05 +1000
MIME-Version: 1.0
In-Reply-To: <20160616233340.GA14449@distroguy.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/06/16 09:33, Chris Smart wrote:
> Calling ISA 3.0 instructions copy, copy_first, paste and paste_last
> generates an alignment fault when copying or pasting unaligned
> data (128 byte). We catch this and send SIGBUS to the userspace
> process that caused it.
> 
> We do not emulate these because paste may contain additional metadata
> when pasting to a co-processor and paste_last is the synchronisation
> point for preceding copy/paste sequences.
> 
> Thanks to Michael Neuling <mikey@neuling.org> for his help.
> 
> Signed-off-by: Chris Smart <chris@distroguy.com>
> ---
> 
> Changes since v1:
> - define and use instruction for mask test
> 
> arch/powerpc/include/asm/ppc-opcode.h |  4 ++++
> arch/powerpc/kernel/align.c           | 14 ++++++++++++++
> 2 files changed, 18 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 1d035c1cc889..7921d3e5704d 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -131,6 +131,8 @@
> /* sorted alphabetically */
> #define PPC_INST_BHRBE            0x7c00025c
> #define PPC_INST_CLRBHRB        0x7c00035c
> +#define PPC_INST_COPY            0x7c00060c
> +#define PPC_INST_COPY_FIRST        0x7c20060c
> #define PPC_INST_CP_ABORT        0x7c00068c
> #define PPC_INST_DCBA            0x7c0005ec
> #define PPC_INST_DCBA_MASK        0xfc0007fe
> @@ -159,6 +161,8 @@
> #define PPC_INST_MSGSNDP        0x7c00011c
> #define PPC_INST_MTTMR            0x7c0003dc
> #define PPC_INST_NOP            0x60000000
> +#define PPC_INST_PASTE            0x7c00070c
> +#define PPC_INST_PASTE_LAST        0x7c20070d
> #define PPC_INST_POPCNTB        0x7c0000f4
> #define PPC_INST_POPCNTB_MASK        0xfc0007fe
> #define PPC_INST_POPCNTD        0x7c0003f4
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index 8e7cb8e2b21a..6e0a1f8495f2 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -875,6 +875,20 @@ int fix_alignment(struct pt_regs *regs)
>         return emulate_vsx(addr, reg, areg, regs, flags, nb, elsize);
>     }
> #endif
> +
> +    /*
> +     * ISA 3.0 (such as P9) copy, copy_first, paste and paste_last alignment
> +     * check.
> +     *
> +     * Send a SIGBUS to the process that caused the fault.
> +     *
> +     * We do not emulate these because paste may contain additional metadata
> +     * when pasting to a co-processor. Furthermore, paste_last is the
> +     * synchronisation point for preceding copy/paste sequences.
> +     */
> +    if ((instruction & 0xfc0006fe) == PPC_INST_COPY)
> +        return -EIO;

Should this all be under cpu_has_feature(CPU_FTR_ARCH_300)?

Balbir Singh.
