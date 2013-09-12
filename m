Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Vladimir Murzin <murzin.v@gmail.com>
Subject: Re: [PATCH] powerpc: net: filter: fix DIVWU instruction opcode
In-reply-to: <1378915410-2262-1-git-send-email-murzin.v@gmail.com>
References: <1378915410-2262-1-git-send-email-murzin.v@gmail.com>
Date: Thu, 12 Sep 2013 10:32:59 +1000
Message-ID: <7012.1378945979@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vladimir Murzin <murzin.v@gmail.com> wrote:

> Currently DIVWU stands for *signed* divw opcode:
> 
> 7d 2a 4b 96 	divwu   r9,r10,r9
> 7d 2a 4b d6 	divw    r9,r10,r9
> 
> Use the *unsigned* divw opcode for DIVWU.

This looks like it's in only used in the BPF JIT code.  

Matt, any chance you an ACK/NACK this?

Mikey

> 
> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> ---
>  arch/powerpc/include/asm/ppc-opcode.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index d7fe9f5..c91842c 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -218,7 +218,7 @@
>  #define PPC_INST_MULLW			0x7c0001d6
>  #define PPC_INST_MULHWU			0x7c000016
>  #define PPC_INST_MULLI			0x1c000000
> -#define PPC_INST_DIVWU			0x7c0003d6
> +#define PPC_INST_DIVWU			0x7c000396
>  #define PPC_INST_RLWINM			0x54000000
>  #define PPC_INST_RLDICR			0x78000004
>  #define PPC_INST_SLW			0x7c000030
> -- 
> 1.7.10.4
> 
