Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 34A351007DB
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 16:46:46 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix swiotlb ops for ppc64
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1323314600.12793.19.camel@pasglop>
Date: Wed, 7 Dec 2011 23:46:54 -0600
Message-Id: <F8F675D7-B3F9-45B8-92D3-A3D1F0BF7746@kernel.crashing.org>
References: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
 <1323314600.12793.19.camel@pasglop>
To: Becky Bruce <beckyb@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 7, 2011, at 9:23 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2011-12-07 at 11:19 -0600, Kumar Gala wrote:
>=20
>> struct dma_map_ops swiotlb_dma_ops =3D {
>> +#ifdef CONFIG_PPC64
>> +	.alloc_coherent =3D swiotlb_alloc_coherent,
>> +	.free_coherent =3D swiotlb_free_coherent,
>> +#else
>> 	.alloc_coherent =3D dma_direct_alloc_coherent,
>> 	.free_coherent =3D dma_direct_free_coherent,
>> +#endif
>> 	.map_sg =3D swiotlb_map_sg_attrs,
>> 	.unmap_sg =3D swiotlb_unmap_sg_attrs,
>> 	.dma_supported =3D swiotlb_dma_supported,
>=20
> Do we really need the ifdef ? What happens if we use
> swiotlb_alloc_coherent() on ppc32 ? Won't it allocate lowmem, realize
> that it doesn't need bouncing and be happy ?
>=20
> Cheers,
> Ben.

Becky any comment?

I know its been a while, but wondering if you had any reason to not do =
what Ben's suggesting ?

- k=
