Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62DD4DDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 19:21:23 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4F9LFpj005374
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 02:21:16 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4F9LCT6009985
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 04:21:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
Date: Tue, 15 May 2007 17:22:56 +0800
Message-ID: <989B956029373F45A0B8AF0297081890B76040@zch01exm26.fsl.freescale.net>
In-Reply-To: <a781481a0705141717v2669805aoa590bfd54da7856b@mail.gmail.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Satyam Sharma" <satyam.sharma@gmail.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus <torvalds@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Satyam Sharma [mailto:satyam.sharma@gmail.com]
> Sent: Tuesday, May 15, 2007 8:18 AM
> To: Kumar Gala
> Cc: Sam Ravnborg; Li Yang-r58472; Linus; Andrew Morton; Linux Kernel;
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning
whitelist for
> powerpc
>=20
> Hi,
>=20
> On 5/14/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On May 14, 2007, at 6:06 AM, Sam Ravnborg wrote:
> >
> > > On Mon, May 14, 2007 at 06:53:32PM +0800, Li Yang wrote:
> > >> This patch fixes the following "Section mismatch" warnings when
> > >> build powerpc platforms.
> > >>
> > >> -------------
> > >> WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference
to
> > >> .init.text:early_get_page from .text between
> > >> 'pte_alloc_one_kernel' (at
> > >> offset 0xc68) and 'pte_alloc_one'
> > >> WARNING: mm/built-in.o - Section mismatch: reference to
> > >> .init.text:set_up_list3s from .text between
> > >> 'kmem_cache_create' (at offset
> > >> 0x20300) and 'cache_reap'
> > >> -------------
> >
> > This warnings should be handled by __init_refok instead.
>=20
> Actually, once __init_refok comes in, would we need any other
> whitelisting mechanism at all? I think the exception patterns in
> secref_whitelist() and those two other whitelisting functions
> (init_section_ref_ok and exit_section_ref_ok) could all be
> subsumed and made redundant if / when __init_refok is used
> in the actual sources.

I don't think so.  __init_refok can be used to mark special functions
which are legitimate to reference .init.text/.init.data but cannot be
used to mark special sections.

- Leo
