Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D3B30DDDF2
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 20:33:36 +1100 (EST)
Date: Sun, 18 Nov 2007 10:33:29 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] PS3: Fix printing of os-area magic numbers
In-Reply-To: <473F6A28.5000309@am.sony.com>
Message-ID: <Pine.LNX.4.62.0711181031230.20350@pademelon.sonytel.be>
References: <473F6A28.5000309@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1727756048-1195378409=:20350"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
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

---584337861-1727756048-1195378409=:20350
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 17 Nov 2007, Geoff Levand wrote:
> Fix a bug in the printing of the PS3 os-area magic numbers which assumed that
> magic numbers were zero terminated strings.  The magic numbers are represented
> in memory as integers.  If the os-area sections are not initialized correctly
> they could contained random data that would be printed to the display.
> 
> CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> 
> Paul,
> 
> This fixes a very minor bug in linus' current tree.  Please consider
> for 2.6.24.
> 
> -Geoff
> 
>  arch/powerpc/platforms/ps3/os-area.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> --- a/arch/powerpc/platforms/ps3/os-area.c
> +++ b/arch/powerpc/platforms/ps3/os-area.c
> @@ -269,8 +269,13 @@ static void __init os_area_get_property(
>  static void _dump_header(const struct os_area_header *h, const char *func,
>  	int line)
>  {
> +	u8 str[sizeof(h->magic_num) + 1];
> +
> +	memcpy(str, h->magic_num, sizeof(h->magic_num));
> +	str[sizeof(h->magic_num)] = 0;
> +
>  	pr_debug("%s:%d: h.magic_num:       '%s'\n", func, line,
> -		h->magic_num);
> +		str);

This only fixes the problem of a missing zero-termination (which could be
handled using `%*s').

I'm also worried about unprintable characters.

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
---584337861-1727756048-1195378409=:20350--
