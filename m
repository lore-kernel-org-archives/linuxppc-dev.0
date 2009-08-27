Return-Path: <mneuling@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 96C69B7B7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 14:36:13 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E33BDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 14:36:13 +1000 (EST)
From: Michael Neuling <mneuling@au1.ibm.com>
To: mjw@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc: Adjust base and index registers in Altivec
	macros
In-reply-to: <1250810505.14522.3.camel@mx3> 
References: <1250810505.14522.3.camel@mx3>
Date: Thu, 27 Aug 2009 14:36:12 +1000
Message-ID: <29410.1251347772@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On POWER6 systems RA needs to be the base and RB the index.  
> If they are reversed you take a misdirect hit.  
> 
> Signed-off-by: Mike Wolf <mjwolf@us.ibm.com>

Looks good.... thanks Mike!

Acked-by: Michael Neuling <mikey@neuling.org>


> 
> ----
> --- altivec.orig/arch/powerpc/include/asm/ppc_asm.h	2009-08-17 15:39:52.000
000000 -0500
> +++ altivec/arch/powerpc/include/asm/ppc_asm.h	2009-08-20 18:08:30.000
000000 -0500
> @@ -98,13 +98,13 @@
>  #define REST_16FPRS(n, base)	REST_8FPRS(n, base); REST_8FPRS(n+8, base)
>  #define REST_32FPRS(n, base)	REST_16FPRS(n, base); REST_16FPRS(n+16, base)
>  
> -#define SAVE_VR(n,b,base)	li b,THREAD_VR0+(16*(n));  stvx n,b,base
> +#define SAVE_VR(n,b,base)	li b,THREAD_VR0+(16*(n));  stvx n,base,b
>  #define SAVE_2VRS(n,b,base)	SAVE_VR(n,b,base); SAVE_VR(n+1,b,base)
>  #define SAVE_4VRS(n,b,base)	SAVE_2VRS(n,b,base); SAVE_2VRS(n+2,b,base)
>  #define SAVE_8VRS(n,b,base)	SAVE_4VRS(n,b,base); SAVE_4VRS(n+4,b,base)
>  #define SAVE_16VRS(n,b,base)	SAVE_8VRS(n,b,base); SAVE_8VRS(n+8,b,base)
>  #define SAVE_32VRS(n,b,base)	SAVE_16VRS(n,b,base); SAVE_16VRS(n+16,b,base)
> -#define REST_VR(n,b,base)	li b,THREAD_VR0+(16*(n)); lvx n,b,base
> +#define REST_VR(n,b,base)	li b,THREAD_VR0+(16*(n)); lvx n,base,b
>  #define REST_2VRS(n,b,base)	REST_VR(n,b,base); REST_VR(n+1,b,base)
>  #define REST_4VRS(n,b,base)	REST_2VRS(n,b,base); REST_2VRS(n+2,b,base)
>  #define REST_8VRS(n,b,base)	REST_4VRS(n,b,base); REST_4VRS(n+4,b,base)
> @@ -112,26 +112,26 @@
>  #define REST_32VRS(n,b,base)	REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)
>  
>  /* Save the lower 32 VSRs in the thread VSR region */
> -#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,b,base)
> +#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,base,b)
>  #define SAVE_2VSRS(n,b,base)	SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base)
>  #define SAVE_4VSRS(n,b,base)	SAVE_2VSRS(n,b,base); SAVE_2VSRS(n+2,b,base)
>  #define SAVE_8VSRS(n,b,base)	SAVE_4VSRS(n,b,base); SAVE_4VSRS(n+4,b,base)
>  #define SAVE_16VSRS(n,b,base)	SAVE_8VSRS(n,b,base); SAVE_8VSRS(n+8,b,
base)
>  #define SAVE_32VSRS(n,b,base)	SAVE_16VSRS(n,b,base); SAVE_16VSRS(n+16
,b,base)
> -#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,b,base)
> +#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,base,b)
>  #define REST_2VSRS(n,b,base)	REST_VSR(n,b,base); REST_VSR(n+1,b,base)
>  #define REST_4VSRS(n,b,base)	REST_2VSRS(n,b,base); REST_2VSRS(n+2,b,base)
>  #define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,base)
>  #define REST_16VSRS(n,b,base)	REST_8VSRS(n,b,base); REST_8VSRS(n+8,b,
base)
>  #define REST_32VSRS(n,b,base)	REST_16VSRS(n,b,base); REST_16VSRS(n+16
,b,base)
>  /* Save the upper 32 VSRs (32-63) in the thread VSX region (0-31) */
> -#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,b,base)
> +#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,base,b)
>  #define SAVE_2VSRSU(n,b,base)	SAVE_VSRU(n,b,base); SAVE_VSRU(n+1,b,ba
se)
>  #define SAVE_4VSRSU(n,b,base)	SAVE_2VSRSU(n,b,base); SAVE_2VSRSU(n+2,
b,base)
>  #define SAVE_8VSRSU(n,b,base)	SAVE_4VSRSU(n,b,base); SAVE_4VSRSU(n+4,
b,base)
>  #define SAVE_16VSRSU(n,b,base)	SAVE_8VSRSU(n,b,base); SAVE_8VSRSU(n+8,
b,base)
>  #define SAVE_32VSRSU(n,b,base)	SAVE_16VSRSU(n,b,base); SAVE_16VSRSU(n+
16,b,base)
> -#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,b,base)
> +#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,base,b)
>  #define REST_2VSRSU(n,b,base)	REST_VSRU(n,b,base); REST_VSRU(n+1,b,ba
se)
>  #define REST_4VSRSU(n,b,base)	REST_2VSRSU(n,b,base); REST_2VSRSU(n+2,
b,base)
>  #define REST_8VSRSU(n,b,base)	REST_4VSRSU(n,b,base); REST_4VSRSU(n+4,
b,base)
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
