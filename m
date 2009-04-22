Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Wed, 22 Apr 2009 09:43:31 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [BUILD FAILURE 09/12] Next April 21 : PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
In-Reply-To: <1240358910.6571.6.camel@localhost>
Message-ID: <alpine.LRH.2.00.0904220942430.6852@vixen.sonytel.be>
References: <1240340029.9110.142.camel@subratamodak.linux.ibm.com>
	<1240358910.6571.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Greg KH <greg@kroah.com>, "David A. Schleef" <ds@schleef.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Apr 2009, Michael Ellerman wrote:
> On Wed, 2009-04-22 at 00:23 +0530, Subrata Modak wrote:
> > Reported this error on 14th April:
> > http://lkml.org/lkml/2009/4/14/488,
> > 
> > CC [M]  drivers/staging/comedi/drivers.o 
> > drivers/staging/comedi/drivers.c: In function ‘comedi_buf_alloc’:
> > drivers/staging/comedi/drivers.c:496: error: ‘PAGE_KERNEL_NOCACHE’
> > undeclared (first use in this function)
> > drivers/staging/comedi/drivers.c:496: error: (Each undeclared identifier
> > is reported only once
> > drivers/staging/comedi/drivers.c:496: error: for each function it
> > appears in.)
> > make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
> > make[2]: *** [drivers/staging/comedi] Error 2
> > make[1]: *** [drivers/staging] Error 2
> > make: *** [drivers] Error 2
> 
> Subrata, unless someone says otherwise, please do not send randconfig
> failures for drivers in staging - those drivers have bigger problems
> than randconfig failures.

Indeed, in particular this one http://lkml.org/lkml/2009/3/9/349.

> To avoid them, do this:
> 
> # make randconfig
> # sed -i -e 's/^\(CONFIG_STAGING\)=y/# \1 is not set/' .config
                                       ^^^^^^^^^^^^^^^
Recently I discovered that `n' actually works, too!

> # make oldconfig

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
