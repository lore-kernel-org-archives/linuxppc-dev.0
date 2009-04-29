Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 304F7DDF48
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 22:43:51 +1000 (EST)
Date: Wed, 29 Apr 2009 14:43:49 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Keep track of emulated instructions
In-Reply-To: <alpine.LRH.2.00.0904061430090.11076@vixen.sonytel.be>
Message-ID: <alpine.LRH.2.00.0904291440580.10036@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
	<3DA386C6-F26A-4929-8609-FE468DF01572@kernel.crashing.org>
	<alpine.LRH.2.00.0904061430090.11076@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Apr 2009, Geert Uytterhoeven wrote:
> On Fri, 3 Apr 2009, Kumar Gala wrote:
> > On Apr 3, 2009, at 7:08 AM, Geert Uytterhoeven wrote:
> > >Finally (after ca. 1.5 years), he're an updated version of my patch to keep
> > >track of emulated instructions.  In the light of Kumar's `Emulate enough of
> > >SPE
> > >instructions to make gcc happy' patch, he probably also wants to keep track
> > >of
> > >the actual runtime overhead.
> > >
> > >Changes since last version:
> > > - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can provide
> > >   counters in sysfs on ppc32, too,
> > > - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
> > > - Add warnings for altivec,
> > > - Add warnings for recently introduced emulation of vsx and isel
> > >   instructions.
> > 
> > pretty cool.  Do we think counters should be sysfs or debugfs?
> 
> What do you prefer?
> 
> On MIPS, unaligned exception handling control is in debugfs.

And probably debugfs is better, so it's disabled on production systems.
But I would drop the per-CPU counters, and keep global counters only, for
simplicity.

> > Also it would be nice to be able to zero out the counters.
> 
> By writing to the individual counters, or by writing to a global `clear' file?

With debugfs, it's quite easy to make them writable, so you can easily clear
them by writing zeroes to the virtual files.

If people agree, I'll find a time hole and start updating the code...

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
