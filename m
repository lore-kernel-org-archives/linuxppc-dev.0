Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id C6A3ADDF08
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 17:33:32 +1000 (EST)
Date: Tue, 28 Aug 2007 09:33:31 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Move bootwrapper's strchr() and strncmp() from .h to string.S
In-Reply-To: <20070828045257.GE6811@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0708280932140.14813@pademelon.sonytel.be>
References: <20070828045257.GE6811@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-738612903-1188286336=:14813"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-738612903-1188286336=:14813
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0708280932191.14813@pademelon.sonytel.be>

On Tue, 28 Aug 2007, David Gibson wrote:
> Currently the bootwrapper has implementations of strchr() and
> strncmp(), but they're inlines in flatdevtree_env.h, rather than in
> string.S with all the rest of the string functions.  This patch moves
                                                                  ^^^^^
Nice move ;-)

... replaces them by assembler versions?

> them to string.S.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> 
> Paul, please apply to the for-2.6.24 branch.
> 
> Index: working-2.6/arch/powerpc/boot/string.S
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/string.S	2006-12-08 10:42:48.000000000 +1100
> +++ working-2.6/arch/powerpc/boot/string.S	2007-08-28 14:48:52.000000000 +1000
> @@ -49,6 +49,17 @@ strcat:
>  	bne	1b
>  	blr
>  
> +	.globl	strchr
> +strchr:
> +	addi	r3,r3,-1
> +1:	lbzu	r0,1(r3)
> +	cmpw	0,r0,r4
> +	beqlr
> +	cmpwi	0,r0,0
> +	bne	1b
> +	li	r3,0
> +	blr
> +
>  	.globl	strcmp
>  strcmp:
>  	addi	r5,r3,-1
> @@ -61,6 +72,19 @@ strcmp:
>  	beq	1b
>  	blr
>  
> +	.globl	strncmp
> +strncmp:
> +	mtctr	r5
> +	addi	r5,r3,-1
> +	addi	r4,r4,-1
> +1:	lbzu	r3,1(r5)
> +	cmpwi	1,r3,0
> +	lbzu	r0,1(r4)
> +	subf.	r3,r0,r3
> +	beqlr	1
> +	bdnzt	eq,1b
> +	blr
> +
>  	.globl	strlen
>  strlen:
>  	addi	r4,r3,-1
> Index: working-2.6/arch/powerpc/boot/flatdevtree_env.h
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/flatdevtree_env.h	2007-08-15 16:56:30.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/flatdevtree_env.h	2007-08-28 14:38:29.000000000 +1000
> @@ -24,24 +24,4 @@
>  #define be64_to_cpu(x)		(x)
>  #define cpu_to_be64(x)		(x)
>  
> -static inline int strncmp(const char *cs, const char *ct, size_t count)
> -{
> -	signed char __res = 0;
> -
> -	while (count) {
> -		if ((__res = *cs - *ct++) != 0 || !*cs++)
> -			break;
> -		count--;
> -	}
> -	return __res;
> -}
> -
> -static inline char *strchr(const char *s, int c)
> -{
> -	for (; *s != (char)c; ++s)
> -		if (*s == '\0')
> -			return NULL;
> -	return (char *)s;
> -}
> -
>  #endif /* _PPC_BOOT_FLATDEVTREE_ENV_H_ */

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-738612903-1188286336=:14813--
