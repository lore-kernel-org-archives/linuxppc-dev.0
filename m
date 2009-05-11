Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 10E85DDE32
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 16:39:48 +1000 (EST)
Date: Mon, 11 May 2009 08:39:46 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: Keep track of emulated instructions if
	debugfs is enabled
In-Reply-To: <1242009161.7767.38.camel@concordia>
Message-ID: <alpine.LRH.2.00.0905110839110.14263@vixen.sonytel.be>
References: <alpine.LRH.2.00.0905081611130.7964@vixen.sonytel.be>
	<1242009161.7767.38.camel@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 May 2009, Michael Ellerman wrote:
> On Fri, 2009-05-08 at 16:15 +0200, Geert Uytterhoeven wrote:
> > Counters for the various classes of emulated instructions are available under
> > /sys/kernel/debug/powerpc/emulated_instructions (assumed debugfs is mounted on
> > /sys/kernel/debug).  Optionally (controlled by
> > /sys/kernel/debug/powerpc/emulated_instructions/do_warn), rate-limited warnings
> > can be printed to the console when instructions are emulated.
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > ---
> > Tested on ppc64 (ps3) and ppc32 (sequoia) using mfpvr.
> > 
> > v3:
> >   - add generic unaligned
> >   - switch from sysfs + sysctl to debugfs. All virtual files now show up under
> >     /sys/kernel/debug/powerpc/emulated_instructions (assumed debugfs mounted on
> >     /sys/kernel/debug)
> >   - enable the printing of rate-limited warnings by writing a non-zero value to
> >     /sys/kernel/debug/powerpc/emulated_instructions/do_warn
> >   - switch from per-CPU to system-wide counters
> >   - always use 32-bit counters (was 64-bit on ppc64)
> >   - counters are writable, i.e. can be reset (by root)
> 
> Nice :)
> 
> My only query is whether it needs its own CONFIG option. Some folks
> might want other DEBUG_FS things but not this?

That's possible. Let's see what the other folks say...

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
