Return-Path: <linuxppc-dev+bounces-16904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D874AE909A5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 13:58:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFh6w3wjHz2yS4;
	Wed, 18 Feb 2026 00:58:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771336680;
	cv=none; b=QBAo19KeA5MhfHrtOg1QivOMSFYrUla002kYmsP1wt0TYe7XqGPtvrgbzJW5fVqloH+Ooeoy7xLRM/EVyLudujLl3z+i1RcrOjXz+AOO1MTXEOuZQKp6cvvXLS5xaQa4ndj17k0WQvDlI6QeB/b0zvJnmU8Vp9A80ktWno7n3kSbCw2xDz4gjDKbFO+X0VC38WvrPK/cnvICLN5g87SJUUxAtFWFnj4z5JMOe2+ugu8zpg/4omWC6SH6zSYfe8FNJ3pJWLHBfDGluAXvNTXaltqsqBtSVCF37a1zpprYebH+5cKUrb02YcG2QZpK6bNZAgPv3ksethdCI1M31PaEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771336680; c=relaxed/relaxed;
	bh=Pwz8t6PMdZ7Eyt0zG9XbbpQPro+70AXMQDf5xeeq3xY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPQ8yfOS6lnuREEThgZq32khWbTZ3D1TNC6rPJAaXCh3sHozAL+oKq6CXqX//tGDW4XPcv7McM1Liw4iNZa6eeNVyV7BBxsHXxyQWxHAS6qIhr6iDKivoGaxQZSQlmLkD7jldPhdvcB56vjPiWjPSPs3INwCQ/VIS6I+Q0Hpl5/KF7aR4H4tYq2TO+DulqrR5cKYgEz+8VxmCYo5l+XR74ZQBJN54CThMMTVM8BPs/G/7NmhsgwpnMzmFJne+5NzPVNPZmNeVD/9ZyH+0qnHoNCHRrmzOxDSNkdRB0wOo/qYTWfu8rIItuxvYx81uz0lSx9u3A7OnIkymMJ38hYp1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=WFMPECoi; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=WFMPECoi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFh6v0SHKz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 00:57:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Pwz8t6PMdZ7Eyt0zG9XbbpQPro+70AXMQDf5xeeq3xY=; t=1771336679;
	x=1771941479; b=WFMPECoi84FprDGvfd49A+CdGozyl9uoKVTRFPxG0OyHeiZ08RLhhYqF9QaFn
	xbdMFbrbiFGcif6HGGQd+Ua8XBo9ds/G7nE96XTGdbMAea2k87OHdMiB/nl9gCwzRo9+1V8OkejIc
	J4Tlsr1h5nunxDH5FPDT/E9dFqwpeVIjukVcqwUCgGBW1kN8vDwyR4I+xtuvlbCDwNqEzG+qxQzhc
	aKR7R/iYR9msTh4Ui9VYFnWpeRdELNygjBeT4bK1gQv3rGeWNkzm1Q0cMgnBrC9sh3TiaD+qrWpiv
	bQdlZrjt/MSVhbc8FUmEh3fVqmOOiSUVCXW+qcQV6T9eNglOvw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vsLa1-00000003Yoo-11bO; Tue, 17 Feb 2026 14:57:33 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vsLa0-00000002m9f-3s0R; Tue, 17 Feb 2026 14:57:33 +0100
Message-ID: <8317613a286ab637ac29740433ff51286ebbbaca.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v5 11/14] sparc: Use physical address DMA mapping
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky	
 <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Russell King	
 <linux@armlinux.org.uk>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini	 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>,  Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer	 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
 Madhavan Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin	 <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Geoff Levand <geoff@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson	
 <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar	
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux
	 <sparclinux@vger.kernel.org>
Date: Tue, 17 Feb 2026 14:57:31 +0100
In-Reply-To: <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>
References: <20251015-remove-map-page-v5-0-3bbfe3a25cdf@kernel.org>
		<20251015-remove-map-page-v5-11-3bbfe3a25cdf@kernel.org>
		<CGME20260217123216eucas1p2d74189a3cdf08e9301bebf1840491364@eucas1p2.samsung.com>
		<e294484787a5032c531dcd40071b22362bddcad4.camel@physik.fu-berlin.de>
	 <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.197.95.41
X-ZEDAT-Hint: PO

Hi Marek,

On Tue, 2026-02-17 at 13:55 +0100, Marek Szyprowski wrote:
> On 17.02.2026 13:27, John Paul Adrian Glaubitz wrote:
> > On Wed, 2025-10-15 at 12:12 +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >=20
> > > Convert sparc architecture DMA code to use .map_phys callback.
> > >=20
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >   arch/sparc/kernel/iommu.c     | 30 +++++++++++++++++-----------
> > >   arch/sparc/kernel/pci_sun4v.c | 31 ++++++++++++++++++-----------
> > >   arch/sparc/mm/io-unit.c       | 38 ++++++++++++++++++--------------=
---
> > >   arch/sparc/mm/iommu.c         | 46 ++++++++++++++++++++++----------=
-----------
> > >   4 files changed, 82 insertions(+), 63 deletions(-)
> > >=20
> > > diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> > > index da0363692528..46ef88bc9c26 100644
> > > --- a/arch/sparc/kernel/iommu.c
> > > +++ b/arch/sparc/kernel/iommu.c
> > > @@ -260,26 +260,35 @@ static void dma_4u_free_coherent(struct device =
*dev, size_t size,
> > >   		free_pages((unsigned long)cpu, order);
> > >   }
> > >  =20
> > > -static dma_addr_t dma_4u_map_page(struct device *dev, struct page *p=
age,
> > > -				  unsigned long offset, size_t sz,
> > > -				  enum dma_data_direction direction,
> > > +static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t ph=
ys,
> > > +				  size_t sz, enum dma_data_direction direction,
> > >   				  unsigned long attrs)
> > >   {
> > >   	struct iommu *iommu;
> > >   	struct strbuf *strbuf;
> > >   	iopte_t *base;
> > >   	unsigned long flags, npages, oaddr;
> > > -	unsigned long i, base_paddr, ctx;
> > > +	unsigned long i, ctx;
> > >   	u32 bus_addr, ret;
> > >   	unsigned long iopte_protection;
> > >  =20
> > > +	if (unlikely(attrs & DMA_ATTR_MMIO))
> > > +		/*
> > > +		 * This check is included because older versions of the code
> > > +		 * lacked MMIO path support, and my ability to test this path
> > > +		 * is limited. However, from a software technical standpoint,
> > > +		 * there is no restriction, as the following code operates
> > > +		 * solely on physical addresses.
> > > +		 */
> > > +		goto bad_no_ctx;
> > > +
> > >   	iommu =3D dev->archdata.iommu;
> > >   	strbuf =3D dev->archdata.stc;
> > >  =20
> > >   	if (unlikely(direction =3D=3D DMA_NONE))
> > >   		goto bad_no_ctx;
> > >  =20
> > > -	oaddr =3D (unsigned long)(page_address(page) + offset);
> > > +	oaddr =3D (unsigned long)(phys_to_virt(phys));
> > >   	npages =3D IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
> > >   	npages >>=3D IO_PAGE_SHIFT;
> > >  =20
> > > @@ -296,7 +305,6 @@ static dma_addr_t dma_4u_map_page(struct device *=
dev, struct page *page,
> > >   	bus_addr =3D (iommu->tbl.table_map_base +
> > >   		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
> > >   	ret =3D bus_addr | (oaddr & ~IO_PAGE_MASK);
> > > -	base_paddr =3D __pa(oaddr & IO_PAGE_MASK);
> > >   	if (strbuf->strbuf_enabled)
> > >   		iopte_protection =3D IOPTE_STREAMING(ctx);
> > >   	else
> > > @@ -304,8 +312,8 @@ static dma_addr_t dma_4u_map_page(struct device *=
dev, struct page *page,
> > >   	if (direction !=3D DMA_TO_DEVICE)
> > >   		iopte_protection |=3D IOPTE_WRITE;
> > >  =20
> > > -	for (i =3D 0; i < npages; i++, base++, base_paddr +=3D IO_PAGE_SIZE=
)
> > > -		iopte_val(*base) =3D iopte_protection | base_paddr;
> > > +	for (i =3D 0; i < npages; i++, base++, phys +=3D IO_PAGE_SIZE)
> > > +		iopte_val(*base) =3D iopte_protection | phys;
>=20
> 'base_paddr' was aligned to start of a page before this patch, while=20
> 'phys'=C2=A0includes the offset within a page.
>=20
>=20
> Could You check if the following change fixes the issue?
>=20
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 46ef88bc9c26..edb0ffb21e2f 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -312,6 +312,7 @@ static dma_addr_t dma_4u_map_phys(struct device=20
> *dev, phys_addr_t phys,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (direction !=3D DMA_TO_DEV=
ICE)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 iopte_protection |=3D IOPTE_WRITE;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phys -=3D offset_in_page(phys);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < npages; i++=
, base++, phys +=3D IO_PAGE_SIZE)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 iopte_val(*base) =3D iopte_protection | phys;

Thanks, I have forwarded your patch and asked the user to answer here if po=
ssible [1].

Adrian

> [1] https://github.com/sparclinux/issues/issues/75#issuecomment-391479186=
2

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

