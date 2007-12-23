Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 4F5E1DDDEA
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 20:51:20 +1100 (EST)
Date: Sun, 23 Dec 2007 10:51:19 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch v3] PS3: Fix printing of os-area magic numbers
In-Reply-To: <476DED97.8070709@am.sony.com>
Message-ID: <Pine.LNX.4.62.0712231049240.17187@chinchilla.sonytel.be>
References: <473F6A28.5000309@am.sony.com> <476DED97.8070709@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584336837-778138729-1198403479=:17187"
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

---584336837-778138729-1198403479=:17187
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 22 Dec 2007, Geoff Levand wrote:
> +static void dump_field(char *s, const u8 *f, unsigned int size)
> +{
> +#if defined(DEBUG)
> +	unsigned int i;
> +
> +	for (i = 0; i < size; i++)
> +		s[i] = isprint(f[i]) ? f[i] : '.';
> +	s[i] = 0;
> +#endif
> +}

Sorry for nitpicking again.

Usually the _length_ of a C-string is the number of characters, while the
_size_ of a C-string includes the zero-terminator.

In dump_field() it writes size+1 bytes to s.

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
---584336837-778138729-1198403479=:17187--
