Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 392CEDDF4E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 02:19:22 +1100 (EST)
Date: Tue, 3 Feb 2009 16:19:15 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/44x: Fix address decoding setup of PCI 2.x cells
In-Reply-To: <20090203151050.GA10541@yoda.jdub.homelinux.org>
Message-ID: <alpine.LRH.2.00.0902031616130.21407@vixen.sonytel.be>
References: <20090202002429.ADA74DDF43@ozlabs.org>
	<20090203151050.GA10541@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Feb 2009, Josh Boyer wrote:
> On Mon, Feb 02, 2009 at 11:24:18AM +1100, Benjamin Herrenschmidt wrote:
> >The PCI 2.x cells used on some 44x SoCs only let us configure the decode
> >for the low 32-bit of the incoming PLB addresses. The top 4 bits (this
> >is a 36-bit bus) are hard wired to different values depending on the
> >specific SoC in use. Our code used to work "by accident" until I added
> >support for the ISA memory holes and while at it added more validity
> >checking of the addresses.
> >
> >This patch should bring it back to working condition. It still relies
> >on the device-tree being correct but that's somewhat a pre-requisite
> >for anything to work anyway.
> >
> >Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >---
> >
> >This is untested. Geert, can you give it a go on Sequoia and let me
> >know if it fixes your problem ?
> 
> Since Geert tested it somewhat successfully, perhaps we should get
> this one into 2.6.29.  I have no other fixes outstanding, so feel
> free to pull it in yourself.

Could it be my USB failures were due to the PPC440 USB host needing the various
CONFIG*USB*BIG_ENDIAN* options, which may conflict with USB hosts on PCI
plug-in cards?

The E1000 did work fine.

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
