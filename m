Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Remove SAVE_VSRU and REST_VSRU macros
In-reply-to: <20130731161925.4fc8f5f2@kryten>
References: <20130731161925.4fc8f5f2@kryten>
Date: Wed, 31 Jul 2013 16:34:51 +1000
Message-ID: <8420.1375252491@ale.ozlabs.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote:

> 
> We always use VMX loads and stores to manage the high 32
> VSRs. Remove these unused macros.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Michael Neuling <mikey@neuling.org>


> ---
> 
> Index: b/arch/powerpc/include/asm/ppc_asm.h
> ===================================================================
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -219,19 +219,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
>  #define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,base)
>  #define REST_16VSRS(n,b,base)	REST_8VSRS(n,b,base); REST_8VSRS(n+8,b,base)
>  #define REST_32VSRS(n,b,base)	REST_16VSRS(n,b,base); REST_16VSRS(n+16,b,base)
> -/* Save the upper 32 VSRs (32-63) in the thread VSX region (0-31) */
> -#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,R##base,R##b)
> -#define SAVE_2VSRSU(n,b,base)	SAVE_VSRU(n,b,base); SAVE_VSRU(n+1,b,base)
> -#define SAVE_4VSRSU(n,b,base)	SAVE_2VSRSU(n,b,base); SAVE_2VSRSU(n+2,b,base)
> -#define SAVE_8VSRSU(n,b,base)	SAVE_4VSRSU(n,b,base); SAVE_4VSRSU(n+4,b,base)
> -#define SAVE_16VSRSU(n,b,base)	SAVE_8VSRSU(n,b,base); SAVE_8VSRSU(n+8,b,base)
> -#define SAVE_32VSRSU(n,b,base)	SAVE_16VSRSU(n,b,base); SAVE_16VSRSU(n+16,b,base)
> -#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,R##base,R##b)
> -#define REST_2VSRSU(n,b,base)	REST_VSRU(n,b,base); REST_VSRU(n+1,b,base)
> -#define REST_4VSRSU(n,b,base)	REST_2VSRSU(n,b,base); REST_2VSRSU(n+2,b,base)
> -#define REST_8VSRSU(n,b,base)	REST_4VSRSU(n,b,base); REST_4VSRSU(n+4,b,base)
> -#define REST_16VSRSU(n,b,base)	REST_8VSRSU(n,b,base); REST_8VSRSU(n+8,b,base)
> -#define REST_32VSRSU(n,b,base)	REST_16VSRSU(n,b,base); REST_16VSRSU(n+16,b,base)
>  
>  /*
>   * b = base register for addressing, o = base offset from register of 1st EVR
> 
