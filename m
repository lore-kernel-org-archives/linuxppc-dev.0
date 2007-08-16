Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D8760DDEC6
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 17:19:13 +1000 (EST)
Date: Thu, 16 Aug 2007 09:19:11 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
In-Reply-To: <1187236548.8375.13.camel@concordia.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.62.0708160917330.6037@pademelon.sonytel.be>
References: <11872134502476-git-send-email-timur@freescale.com>
	<1187236548.8375.13.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-311844886-1187248751=:6037"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Timur Tabi <timur@freescale.com>
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

---584337861-311844886-1187248751=:6037
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Aug 2007, Michael Ellerman wrote:
> Can you extract the masking logic, rather than repeating it 7 times:
> 
> #define maskbits(a, v, m)	((a) & ~(m) | (v))
> 
> And if you're going to the trouble of making a macro, why not make it a
> bit more useful and have it check that the value and the mask match, ie:
> 
> (v & ~m == 0)
> 
> Final random thought, you could make the size/endian an argument:
> 
> #define setmaskedbits(a, v, m, s)  out_##s((a), (in_##s(a) & ~(m) | (v))

For readability, you can change the parameter names `v' and `m' to e.g. `set'
and `clear' (or `clr'), so people don't have to look through the actual
definitions to know which one comes first?

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
---584337861-311844886-1187248751=:6037--
