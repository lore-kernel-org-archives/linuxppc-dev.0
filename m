Return-Path: <sr@denx.de>
Date: Mon, 29 Jan 2007 14:26:57 +0100 (MET)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit
	addresses
References: <200701190906.09112.sr@denx.de> <200701290942.10515.sr@denx.de>
	<45BDEC5A.2020103@ru.mvista.com>
In-Reply-To: <45BDEC5A.2020103@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Message-Id: <200701291426.45405.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sergei,

On Monday 29 January 2007 13:45, Sergei Shtylyov wrote:
> > diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
> > index 354a940..2f9a311 100644
> > --- a/arch/ppc/mm/pgtable.c
> > +++ b/arch/ppc/mm/pgtable.c
> > @@ -156,9 +156,19 @@ ioremap64(unsigned long long addr, unsigned long
> > size) void __iomem *
> >  ioremap(phys_addr_t addr, unsigned long size)
> >  {
> > -	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);
> > -
> > -	return ioremap64(addr64, size);
> > +	/*
> > +	 * On systems that supply a real 64bit address
> > +	 * (with CONFIG_RESOURCES_64BIT enabled), don't use the
> > +	 * fixup function.
> > +	 * This allows us to use the fixup function when no ERPN
> > +	 * is specified and use the 64 bit address when the ERPN
> > +	 * is suppied.
> > +	 */
> > +	if ((unsigned long long)addr & 0xffffffff00000000ULL)
> > +		return ioremap64(addr, size);
>
>     I'm sorry but is this actually needed? From looking at the
> arch/ppc/syslib/ibm44x_common.c and include/asm-ppc/ibm44x.h I got an
> impression that fixup_bigphys_addr() returns addresses >= 4GB intact anyway

Hmmm. It seems that you are correct here (again). I was in a hurry since I did 
this stuff right before going on vacation. So please forget about this patch 
once and for all.

Sorry about the noise.

Best regards,
Stefan
