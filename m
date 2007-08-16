Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 2E7EEDDECC
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 17:22:07 +1000 (EST)
Date: Thu, 16 Aug 2007 09:22:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Subject: Re: [PATCH] [POWERPC] Invalid semicolon after if statement
In-Reply-To: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
Message-ID: <Pine.LNX.4.62.0708160920010.6037@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1810050672-1187248925=:6037"
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

---584337861-1810050672-1187248925=:6037
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Aug 2007, [ISO-8859-1] Ilpo J鋜vinen wrote:
> A similar fix to netfilter from Eric Dumazet inspired me to
> look around a bit by using some grep/sed stuff as looking for
> this kind of bugs seemed easy to automate. This is one of them
> I found where it looks like this semicolon is not valid.
> 
> Signed-off-by: Ilpo J鋜vinen <ilpo.jarvinen@helsinki.fi>
> ---
> 
> ...Since I'm not familiar with these parts of the kernel, you might know 
> better than I do if this is stuff is valid...
> 
>  arch/powerpc/mm/hash_utils_64.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index f178957..a47151e 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -795,7 +795,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>  
>  #ifdef CONFIG_PPC_MM_SLICES
>  	/* We only prefault standard pages for now */
> -	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize));
> +	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize))
>  		return;
>  #endif

Interestingly the test has `unlikely'. So the bug showed up in the `likely'
case...

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village 路 Da Vincilaan 7-D1 路 B-1935 Zaventem 路 Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 路 B-1840 Londerzeel 路 Belgium	
VAT BE 0413.825.160 路 RPR Brussels	
Fortis Bank Zaventem 路 Swift GEBABEBB08A 路 IBAN BE39001382358619
---584337861-1810050672-1187248925=:6037--
