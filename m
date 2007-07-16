Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 279C3DE14F
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:59:17 +1000 (EST)
Date: Mon, 16 Jul 2007 14:59:14 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
In-Reply-To: <20070716121649.GI5195@kernel.dk>
Message-ID: <Pine.LNX.4.62.0707161459010.1072@pademelon.sonytel.be>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
	<200707131619.54898.arnd@arndb.de>
	<Pine.LNX.4.62.0707131707290.18802@pademelon.sonytel.be>
	<1184340528.3402.32.camel@localhost.localdomain>
	<Pine.LNX.4.62.0707132212520.23000@chinchilla.sonytel.be>
	<Pine.LNX.4.62.0707161338230.1072@pademelon.sonytel.be>
	<20070716121649.GI5195@kernel.dk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1083484419-1184590754=:1072"
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Alessandro Rubini <rubini@vision.unipv.it>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1083484419-1184590754=:1072
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 16 Jul 2007, Jens Axboe wrote:
> On Mon, Jul 16 2007, Geert Uytterhoeven wrote:
> > On Fri, 13 Jul 2007, Geert Uytterhoeven wrote:
> > > Ah, that explains it. flush_dcache_page() is used in some drivers.
> > > I'll update my patches. Thanks for the comments!
> > 
> > Does this look OK?
> >   - Replaced KM_USER0 by KM_IRQ0 (all routines are either called from an
> >     interrupt handler, from .request_fn (ps3disk), or from .queuecommand
> >     (ps3rom))
> 
> That looks good.
> 
> >   - Add a call to flush_kernel_dcache_page() in routines that write to buffers
> 
> Hmm, I would have thought a flush_dcache_page() would be more
> appropriate, the backing could be page cache pages.

OK, I'll change it to flush_dcache_page().

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
---584337861-1083484419-1184590754=:1072--
