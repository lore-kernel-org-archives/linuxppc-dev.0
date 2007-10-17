Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 76A08DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 18:55:10 +1000 (EST)
Date: Wed, 17 Oct 2007 10:55:08 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] Fix vmemmap warning in init_64..c
In-Reply-To: <20071017043024.GE9814@bakeyournoodle.com>
Message-ID: <Pine.LNX.4.62.0710171054110.29856@pademelon.sonytel.be>
References: <20071017043024.GE9814@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-523692557-1192611308=:29856"
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
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

---584337861-523692557-1192611308=:29856
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 17 Oct 2007, Tony Breeds wrote:
> Use the right printk format to silence the following warning.
> 
>   CC      arch/powerpc/mm/init_64.o
> arch/powerpc/mm/init_64.c: In function 'vmemmap_populate':
> arch/powerpc/mm/init_64.c:243: warning: format '%p' expects type 'void *', but argument 4 has type 'long unsigned int'
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
> 
> Also a whitespace fix while I'm there.
> 
>  arch/powerpc/mm/init_64.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 702d884..6720b1c 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -240,7 +240,7 @@ int __meminit vmemmap_populate(struct page *start_page,
>  			return -ENOMEM;
>  
>  		printk(KERN_WARNING "vmemmap %08lx allocated at %p, "
                                              ^^
> -					"physical %p.\n", start, p, __pa(p));
> +		                    "physical %08lx.\n", start, p, __pa(p));
                                               ^^
Anyone with memory outside 32-bit (`%08lx') space?

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
---584337861-523692557-1192611308=:29856--
