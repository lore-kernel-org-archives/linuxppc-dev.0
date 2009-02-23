Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 9CAA7DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 21:37:34 +1100 (EST)
Date: Mon, 23 Feb 2009 11:37:29 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: PCI reading without endian conversion
In-Reply-To: <20090220235054.GA27349@ovro.caltech.edu>
Message-ID: <alpine.LRH.2.00.0902231135281.22762@vixen.sonytel.be>
References: <b5e2fc790902201057of113946yea9ccc7405e31926@mail.gmail.com>
	<20090220191108.GA21163@ovro.caltech.edu>
	<b5e2fc790902201205t4bd03373w7e7624fce60f5eb0@mail.gmail.com>
	<20090220210744.GB21163@ovro.caltech.edu>
	<b5e2fc790902201356v7e01b17al3ecd7e06ac59af3d@mail.gmail.com>
	<20090220235054.GA27349@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Feb 2009, Ira Snyder wrote:
> On Fri, Feb 20, 2009 at 03:56:39PM -0600, Matt Sealey wrote:
> > Am I correct in saying that cpu_to_le32 and le32_to_cpu are the
> > functions/macros I need to use to do byte swapping to make everything
> > go little endian (and back again when I read them back in the kernel)?
> > 
> > Or is there some cleverer way already implemented in the kernel?
> 
> I would say that the __raw_readl() reads in cpu order. If you wanted to
> convert that to le32, you'd use cpu_to_le32().

Well...

__raw_readl() does read in cpu order. But since you're reading from the PCI
bus, which is little endian, you actually read a little endian value. So you
should use le32_to_cpu() to convert it to a native value.

(yes, at the lowest level, cpu_to_le32() and le32_to_cpu() do the same thing
 on PPC: byte swapping 32-bit data).

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
