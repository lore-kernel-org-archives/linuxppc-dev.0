Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 18233DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 03:53:58 +1100 (EST)
Date: Thu, 26 Feb 2009 17:53:56 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
In-Reply-To: <200902261715.28440.arnd@arndb.de>
Message-ID: <alpine.LRH.2.00.0902261752310.29190@vixen.sonytel.be>
References: <20090224000002.GA578@ovro.caltech.edu>
	<200902261715.28440.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Jan-Bernd Themann <THEMANN@de.ibm.com>, netdev@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Feb 2009, Arnd Bergmann wrote:
> On Tuesday 24 February 2009, Ira Snyder wrote:
> > +/* Virtio-over-PCI descriptors: 12 bytes. These can chain together via "next" */
> > +struct vop_desc {
> > +	/* Address (host physical) */
> > +	__le32 addr;
               ^^^^
Only 32-bit? Is this future-proof?

> > +	/* Length (bytes) */
> > +	__le32 len;
> > +	/* Flags */
> > +	__le16 flags;
> > +	/* Chaining for descriptors */
> > +	__le16 next;
> > +} __attribute__((packed));
> 
> I would drop the "packed" attribute in the structure definitions.
> It would imply that only byte accesses are allowed on these
> data structures, because the attribute invalidates any assumptions
> about alignment. None of your structures require padding, so
> the attribute does not have any positive effect either.
> 
> > +/* MPC8349EMDS specific get_immrbase() */
> > +#include <sysdev/fsl_soc.h>
> 
> Do you really need get_immrbase? I would expect that you can find
> all the registers you need in the device tree, or exported from
> other low-level drivers per subsystem.
> 
> immrbase is a concept from the time before our device trees.
> 
> > +/*
> > + * These are internal use only versions of the structures that
> > + * are exported over PCI by this driver
> > + *
> > + * They are used internally to keep track of the PowerPC queues so that
> > + * we don't have to keep flipping endianness all the time
> > + */
> > +struct vop_loc_desc {
> > +	u32 addr;
        ^^^
Same here.

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
