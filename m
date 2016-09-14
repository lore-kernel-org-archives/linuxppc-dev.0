Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYpw05WwPzDrqB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 14:48:32 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id pp5so175925pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 21:48:32 -0700 (PDT)
Message-ID: <1473828502.2554.7.camel@gmail.com>
Subject: Re: [PATCH v14 01/15] selftests/powerpc: Add more SPR numbers, TM &
 VMX instructions to 'reg.h'
From: Cyril Bur <cyrilbur@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Chris Smart <chris@distroguy.com>, Suraj Jitindar Singh
 <sjitindarsingh@gmail.com>, Michael Neuling <mikey@neuling.org>, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Wed, 14 Sep 2016 14:48:22 +1000
In-Reply-To: <1473665605-11890-2-git-send-email-wei.guo.simon@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473665605-11890-2-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-12 at 15:33 +0800, wei.guo.simon@gmail.com wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch adds SPR number for TAR, PPR, DSCR special
> purpose registers. It also adds TM, VSX, VMX related
> instructions which will then be used by patches later
> in the series.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  tools/testing/selftests/powerpc/reg.h | 42
> ++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/reg.h
> b/tools/testing/selftests/powerpc/reg.h
> index fddf368..fee7be9 100644
> --- a/tools/testing/selftests/powerpc/reg.h
> +++ b/tools/testing/selftests/powerpc/reg.h
> @@ -18,6 +18,19 @@
>  
>  #define mb()		asm volatile("sync" : : : "memory");
>  
> +/* Vector Instructions */
> +#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) <<
> 16) |  \
> +				 ((rb) << 11) | (((xs) >> 5)))
> +#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs),
> (ra), (rb)))
> +#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs),
> (ra), (rb)))

Theres an instructions.h file in tools/testing/selftests/powerpc/ would
these be better suited there?

> +
> +/* TM instructions */
> +#define TBEGIN		".long 0x7C00051D;"
> +#define TABORT		".long 0x7C00071D;"
> +#define TEND		".long 0x7C00055D;"
> +#define TSUSPEND	".long 0x7C0005DD;"
> +#define TRESUME		".long 0x7C2005DD;"
> +

These are only useful on old compilers that don't know about TM. For
selftests I would discourage creating these and using the actual
instructions, they are fairly well known today by most compilers.

>  #define SPRN_MMCR2     769
>  #define SPRN_MMCRA     770
>  #define SPRN_MMCR0     779
> @@ -51,10 +64,33 @@
>  #define SPRN_SDAR      781
>  #define SPRN_SIER      768
>  
> -#define SPRN_TEXASR     0x82
> +#define SPRN_TEXASR     0x82    /* Transaction Exception and Status
> Register */
>  #define SPRN_TFIAR      0x81    /* Transaction Failure Inst
> Addr    */
>  #define SPRN_TFHAR      0x80    /* Transaction Failure Handler Addr
> */
> -#define TEXASR_FS       0x08000000
> -#define SPRN_TAR        0x32f
> +#define SPRN_TAR        0x32f	/* Target Address Register */
> +
> +#define SPRN_DSCR_PRIV 0x11	/* Privilege State DSCR */
> +#define SPRN_DSCR      0x03	/* Data Stream Control Register
> */
> +#define SPRN_PPR       896	/* Program Priority Register */
> +
> +/* TEXASR register bits */
> +#define TEXASR_FC	0xFE00000000000000
> +#define TEXASR_FP	0x0100000000000000
> +#define TEXASR_DA	0x0080000000000000
> +#define TEXASR_NO	0x0040000000000000
> +#define TEXASR_FO	0x0020000000000000
> +#define TEXASR_SIC	0x0010000000000000
> +#define TEXASR_NTC	0x0008000000000000
> +#define TEXASR_TC	0x0004000000000000
> +#define TEXASR_TIC	0x0002000000000000
> +#define TEXASR_IC	0x0001000000000000
> +#define TEXASR_IFC	0x0000800000000000
> +#define TEXASR_ABT	0x0000000100000000
> +#define TEXASR_SPD	0x0000000080000000
> +#define TEXASR_HV	0x0000000020000000
> +#define TEXASR_PR	0x0000000010000000
> +#define TEXASR_FS	0x0000000008000000
> +#define TEXASR_TE	0x0000000004000000
> +#define TEXASR_ROT	0x0000000002000000
>  
>  #endif /* _SELFTESTS_POWERPC_REG_H */
