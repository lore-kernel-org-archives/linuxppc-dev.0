Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77E06DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 19:35:02 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4F9Yu4q027241
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 02:34:56 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4F9YsGq013128
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 04:34:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
Date: Tue, 15 May 2007 17:36:40 +0800
Message-ID: <989B956029373F45A0B8AF0297081890B76041@zch01exm26.fsl.freescale.net>
In-Reply-To: <3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, "Sam Ravnborg" <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus <torvalds@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, May 14, 2007 9:57 PM
> To: Sam Ravnborg
> Cc: Li Yang-r58472; Linus; Andrew Morton; Linux Kernel;
linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning
whitelist for
> powerpc
>=20
>=20
> On May 14, 2007, at 6:06 AM, Sam Ravnborg wrote:
>=20
> > On Mon, May 14, 2007 at 06:53:32PM +0800, Li Yang wrote:
> >> This patch fixes the following "Section mismatch" warnings when
> >> build powerpc platforms.
> >>
> >> -------------
> >> WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference
to
> >> .init.text:early_get_page from .text between
> >> 'pte_alloc_one_kernel' (at
> >> offset 0xc68) and 'pte_alloc_one'
> >> WARNING: mm/built-in.o - Section mismatch: reference to
> >> .init.text:set_up_list3s from .text between
> >> 'kmem_cache_create' (at offset
> >> 0x20300) and 'cache_reap'
> >> -------------
>=20
> This warnings should be handled by __init_refok instead.

Yes.  When __init_refok gets in, we can change all Pattern 9 members in
the whitelist to use __init_refok.

- Leo
