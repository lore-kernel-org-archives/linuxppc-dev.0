Return-Path: <anton@ozlabs.org>
Date: Sun, 14 Mar 2010 09:49:07 +1100
From: Anton Blanchard <anton@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Make sure lwarx hint isn't set on ppc32
Message-ID: <20100313224907.GA22414@kryten>
References: <1268285947-6114-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1268285947-6114-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> e500v1/v2 based chips will treat any reserved field being set in an
> opcode as illegal.  Thus always setting the hint in the opcode is
> a bad idea.
> 
> Anton should be kept away from the powerpc opcode map.

Nasty bug! I promise never to touch the opcode map again :)

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/ppc-opcode.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index aea7147..d553bbe 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -25,7 +25,7 @@
>  #define PPC_INST_LDARX			0x7c0000a8
>  #define PPC_INST_LSWI			0x7c0004aa
>  #define PPC_INST_LSWX			0x7c00042a
> -#define PPC_INST_LWARX			0x7c000029
> +#define PPC_INST_LWARX			0x7c000028
>  #define PPC_INST_LWSYNC			0x7c2004ac
>  #define PPC_INST_LXVD2X			0x7c000698
>  #define PPC_INST_MCRXR			0x7c000400
> @@ -62,8 +62,8 @@
>  #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
>  #define __PPC_WC(w)	(((w) & 0x3) << 21)
>  /*
> - * Only use the larx hint bit on 64bit CPUs. Once we verify it doesn't have
> - * any side effects on all 32bit processors, we can do this all the time.
> + * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
> + * larx with EH set as an illegal instruction.
>   */
>  #ifdef CONFIG_PPC64
>  #define __PPC_EH(eh)	(((eh) & 0x1) << 0)
> -- 
> 1.6.0.6
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
