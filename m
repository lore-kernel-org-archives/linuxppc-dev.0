Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 19D94DE596
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 18:39:11 +1000 (EST)
Date: Fri, 22 Aug 2008 10:39:10 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: disable modules and get "multiple definition" errors?
In-Reply-To: <48AE1644.8050102@hypersurf.com>
Message-ID: <Pine.LNX.4.64.0808221038400.17105@vixen.sonytel.be>
References: <48AE1644.8050102@hypersurf.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-891049496-1219394350=:17105"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-891049496-1219394350=:17105
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 21 Aug 2008, Kevin Diggs wrote:
> 	I am trying to do some compile testing of my cpufreq driver. If
> I disable modules I am getting multiple definition errors of inline
> functions:
> 
> inline volatile unsigned int get_PLL(void)
> {
> unsigned int ret;
> 
>         __asm__ __volatile__ ("mfspr %0,%1":
>                 "=r"(ret):
>                 "i"(SPRN_HID1)
>         );
> 
>         return ret;
> }
> 
> arch/powerpc/kernel/cpu/pll_if.o(.text+0x1c): In function `get_PLL':
> : multiple definition of `get_PLL'
> arch/powerpc/kernel/cpu/cpufreq/built-in.o(.text+0x0): first defined here
> 
> What am I doing wrong?

You forgot to make the inline functions static?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-891049496-1219394350=:17105--
