Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id E9495DE018
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 17:24:24 +1000 (EST)
Date: Thu, 14 May 2009 09:24:22 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: drivers/video/logo/logo_linux_mono.c build error
In-Reply-To: <20090513154415.fd10762c.akpm@linux-foundation.org>
Message-ID: <alpine.LRH.2.00.0905140919230.22602@vixen.sonytel.be>
References: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
	<20090428135202.9c9bbadb.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.0904280922410.31001@vixen.sonytel.be>
	<20090513154415.fd10762c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 May 2009, Andrew Morton wrote:
> On Tue, 28 Apr 2009 09:24:53 +0200 (CEST)
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > On Tue, 28 Apr 2009, Stephen Rothwell wrote:
> > > On Mon, 27 Apr 2009 14:50:31 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > powerpc allmodconfig, current mainline:
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > 
> > > > drivers/video/logo/logo_linux_mono.c:11: error: logo_linux_mono_data causes a section type conflict
> > > > 
> > > > switching it from __initconst to __initdata "fixes" it.
> > > 
> > > Interesting.  The program that generates the .c file above produces
> > > __initdata for me ...
> > 
> > I assume Andrew once built in that tree using the recent logo patches that
> >   1. Makes the logos const and switch them from __initdata to __initconst,
> >   2. Fix the missing dependency of the generated files on the generator program.
> > Hence if you revert the logo patches, you have to manually remove the generated
> > files.
> > 
> > Is my assumption correct?
> 
> Nope - mrproper removes every .c file from drivers/video/logo/ apart
> from logo.c
> 
> 
> 
> The failure is caused by your fbdev-move-logo-externs-to-header-file.patch.

Which is not in current mainline, so the above reference was incorrectly
fueling my assumption?

> Without that patch, drivers/video/logo/logo_linux_mono.c is generated as
> 
> 	static unsigned char logo_linux_mono_data[] __initdata = {
> 	
> and with that patch, drivers/video/logo/logo_linux_mono.c is generated as
> 
> 	static const unsigned char logo_linux_mono_data[] __initconst = {
> 
> and it's the switch from __initdata to __initconst which causes this
> section conflict in my setup.

But logo_linux_mono_data is referenced by 

    const struct linux_logo logo_linux_mono __initconst = { 
	    .type           = LINUX_LOGO_MONO,
	    .width          = 80,
	    .height         = 80,
	    .data           = logo_linux_mono_data
    };      

only, which is also __initconst? Where does the section type conflict come
from?

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
