Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 62737DDEFC
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 19:43:24 +1000 (EST)
Date: Tue, 5 Aug 2008 11:43:22 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PS3 early lock-up
In-Reply-To: <1217900430.24157.142.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0808051142160.18419@vixen.sonytel.be>
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
	<1217886287.24157.87.camel@pasglop> <1217886777.24157.91.camel@pasglop>
	<48979F6F.1050507@am.sony.com> <1217900430.24157.142.camel@pasglop>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-367339035-1217929402=:18419"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
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

---584349381-367339035-1217929402=:18419
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 Aug 2008, Benjamin Herrenschmidt wrote:
> > > Can you find out where that stupid value comes from ?
> > 
> > I didn't have time to look at in detail, but it fails from the
> > ioremap call in ps3_map_htab (arch/powerpc/platfroms/ps3/htab.c):
> > 
> >  htab = (__force struct hash_pte *)ioremap_flags(htab_addr, htab_size,
> >      pgprot_val(PAGE_READONLY_X));
> > 
> > IIRC, lv1 doesn't allow a read/write mapping of the htab, and that is
> > why I used pgprot_val(PAGE_READONLY_X) here.
> 
> Why are you mapping it in the first place btw ? Do you actually use that
> mapping ?

arch/powerpc/platfroms/ps3/htab.c:ps3_hpte_updatepp() uses `htab[slot].v'.

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
Fortis 293-0376800-10 GEBA-BE-BB
---584349381-367339035-1217929402=:18419--
