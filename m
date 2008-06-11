Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2113BDDEC6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 12:43:26 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: rework 4xx PTE access and TLB miss
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <7B3D2AD1-DBC4-41DB-91EE-D070CA4B47AD@freescale.com>
References: <1213145431.25745.42.camel@pasglop>
	<7B3D2AD1-DBC4-41DB-91EE-D070CA4B47AD@freescale.com>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 12:43:09 +1000
Message-Id: <1213152189.25745.55.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
> > -#define	_PAGE_RW	0x00000002		/* S: Write permission */
> > +#define _PAGE_RW	0x00000002		/* S: Write permission */
> > #define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
> > +#define _PAGE_HWEXEC	0x00000004		/* H: Execute permission */
> 
> I'm sure this is ok, but why can we overlay _PAGE_HWEXEC and _PAGE_FILE?

_PAGE_FILE is only meaningful for non present PTEs.

> > #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
> > -#define _PAGE_HWWRITE	0x00000010		/* H: Dirty & RW */
> > -#define _PAGE_HWEXEC	0x00000020		/* H: Execute permission */
> > -#define	_PAGE_USER	0x00000040		/* S: User page */
> > -#define	_PAGE_ENDIAN	0x00000080		/* H: E bit */
> > -#define	_PAGE_GUARDED	0x00000100		/* H: G bit */
> > -#define	_PAGE_DIRTY	0x00000200		/* S: Page dirty */
> > -#define	_PAGE_NO_CACHE	0x00000400		/* H: I bit */
> > -#define	_PAGE_WRITETHRU	0x00000800		/* H: W bit */
> > +#define _PAGE_DIRTY	0x00000010		/* S: Page dirty */
> 
> why the gap?

There are tricks to simplify the TLB miss handlers here. WIMGE are in
the natural position of the final tlbwe, _PAGE_PRESENT is in SR
position, _PAGE_RW in SW and _PAGE_HWEXEC in SX. I then conditionally
copy them down to the "U" bits when _PAGE_USER is set. This trick
isn't as useful on FSL though as your MAS layout mixes up the
protection bits in a less useful way.

As to why _PAGE_USER is appended to WIMGE rather than _PAGE_DIRTY,
well, it was one or the other, either way there would be a gap,
which we can later use for _PAGE_EXEC. I'm also thinking about
finding a bit for _PAGE_SPECIAL for fast_gup.

Cheers,
Ben.
