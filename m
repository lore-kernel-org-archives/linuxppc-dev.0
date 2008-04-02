Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id F22E2DDFE2
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 22:53:49 +1100 (EST)
Date: Wed, 2 Apr 2008 13:53:46 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Move phys_addr_t definition into asm/types.h
In-Reply-To: <451ABD36-3763-4AF0-B24B-AF043393A72C@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0804021352580.20994@vixen.sonytel.be>
References: <Pine.LNX.4.64.0803281338360.15109@blarg.am.freescale.net>
	<18417.44855.137234.450478@cargo.ozlabs.ibm.com>
	<451ABD36-3763-4AF0-B24B-AF043393A72C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1752785050-1207137226=:20994"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
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

---584349381-1752785050-1207137226=:20994
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 1 Apr 2008, Kumar Gala wrote:
> On Mar 31, 2008, at 10:42 PM, Paul Mackerras wrote:
> >Kumar Gala writes:
> > >Moved phys_addr_t out of mmu-*.h and into asm/types.h so we can use it in
> > >places that before would have caused recursive includes.
> > >
> > >For example to use phys_addr_t in <asm/page.h> we would have included
> > ><asm/mmu.h> which would have possibly included <asm/mmu-hash64.h> which
> > >includes <asm/page.h>.  Wheeee recursive include.
> >
> >In general this looks fine.  I wonder if you should use u64 rather
> >than unsigned long long.  Since CONFIG_PHYS_64BIT=n on 64-bit machines
> >(which is itself somewhat counterintuitive) we will actually use
> >unsigned long on 64-bit machines, so it matters less than I originally
> >thought, but it would be worth explaining that in a comment and/or the
> >commit message.
> 
> We could change it to be:
> 
> /* Physical address used by some IO functions */
> #if defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
> typedef u64 phys_addr_t;
> #else
> typedef u32 phys_addr_t;
> #endif
> 
> This seems a bit more self documenting which is always nice (and I can add a
> comment in the commit message about CONFIG_PHYS_64BIT only making sense on
> ppc32).

If it's counterintuitive that CONFIG_PHYS_64BIT=n on 64-bit machines, why
not set it to =y in Kconfig?

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
---584349381-1752785050-1207137226=:20994--
