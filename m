Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id B5A34DDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 19:13:44 +1100 (EST)
Date: Thu, 27 Mar 2008 09:13:39 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 3/6] PS3: Bootwrapper improvements
In-Reply-To: <47EAEC76.7000006@am.sony.com>
Message-ID: <Pine.LNX.4.64.0803270910290.17938@vixen.sonytel.be>
References: <20080327001821.827672589@am.sony.com>
	<47EAEC76.7000006@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-233771849-1206605619=:17938"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
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

---584349381-233771849-1206605619=:17938
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Mar 2008, Geoff Levand wrote:
> --- a/arch/powerpc/boot/ps3.c
> +++ b/arch/powerpc/boot/ps3.c
>  }
>  
> -void platform_init(void)
> +void platform_init(unsigned long null_check)
                      ^^^^^^^^^^^^^^^^^^^^^^^^
>  {
>  	const u32 heapsize = 0x1000000 - (u32)_end; /* 16MiB */
>  	void *chosen;
> @@ -151,6 +152,10 @@ void platform_init(void)
>  
>  	printf(" flat tree at 0x%lx\n\r", ft_addr);
>  
> +	if (*(unsigned long *)0 != null_check)
> +		printf("null check failed: %lx != %lx\n\r", *(unsigned long *)0,
> +			(unsigned long)null_check);
                        ^^^^^^^^^^^^^^^
This cast is not needed, as null_check has the correct type.

BTW, what about writing it like

	unsigned long val;

	val = *(unsigned long *)0;
	if (val != null_check)
		printf("null check failed: %lx != %lx\n\r", val, null_check);

to kill a duplicate cast and avoid splitting the printf() line?

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
---584349381-233771849-1206605619=:17938--
