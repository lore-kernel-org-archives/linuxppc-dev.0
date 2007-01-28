Return-Path: <ml@stefan-roese.de>
Date: Sun, 28 Jan 2007 22:00:19 +0100 (MET)
From: Stefan Roese <ml@stefan-roese.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit
	addresses
References: <200701190906.09112.sr@denx.de>
	<1169207845.28708.2.camel@crusty.rchland.ibm.com>
In-Reply-To: <1169207845.28708.2.camel@crusty.rchland.ibm.com>
MIME-Version: 1.0
Message-Id: <200701282200.03239.ml@stefan-roese.de>
Content-Type: text/plain;  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,

On Friday 19 January 2007 12:57, Josh Boyer wrote:
> On Fri, 2007-01-19 at 09:05 +0100, Stefan Roese wrote:
> > [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit addresses
> >
> > On systems that supply a real 64bit address (with
> > CONFIG_RESOURCES_64BIT enabled), don't use the fixup function. This
> > allows us to use the fixup function when no ERPN is specified and use
> > the 64 bit address when the ERPN is supplied.
>
> Good idea.
>
> >  void __iomem *
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
> > +	if ((unsigned long long)addr && 0xffffffff00000000ULL)
> > +		return ioremap64(addr, size);
>
> Erm... don't you want:
>
> addr & 0xffffffff00000000ULL
>
> What you have now is a logical and that will likely result in it always
> being true...

Of course. Thanks for spotting it. I'll resend the patch tomorrow.

Best regards,
Stefan
