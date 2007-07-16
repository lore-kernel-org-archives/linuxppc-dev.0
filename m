Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 5F80EDDFB8
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 19:18:39 +1000 (EST)
Date: Mon, 16 Jul 2007 11:18:36 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [patch] use __attribute__ in asm-powerpc
In-Reply-To: <200707142336.10343.vapier@gentoo.org>
Message-ID: <Pine.LNX.4.62.0707161117150.1072@pademelon.sonytel.be>
References: <200707142336.10343.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-735000793-1184577516=:1072"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
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

---584337861-735000793-1184577516=:1072
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 14 Jul 2007, Mike Frysinger wrote:
> Pretty much everyone uses "__attribute__" or "attribute", no one
> uses "__attribute".  This patch tweaks the three places in asm-powerpc where
> this comes up.  While only asm-powerpc/types.h is interesting (for userspace),
> I did asm-powerpc/processor.h as well for consistency.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> diff --git a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
> index d947b16..2ce6ea6 100644
> --- a/include/asm-powerpc/processor.h
> +++ b/include/asm-powerpc/processor.h
> @@ -153,9 +153,9 @@ struct thread_struct {
>  	unsigned long	dabr;		/* Data address breakpoint register */
>  #ifdef CONFIG_ALTIVEC
>  	/* Complete AltiVec register set */
> -	vector128	vr[32] __attribute((aligned(16)));
> +	vector128	vr[32] __attribute__((aligned(16)));

If the code is not exported to userspace (and thus not subject to different
compilers), I think the preferred form is plain `attribute'.

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
---584337861-735000793-1184577516=:1072--
