Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C154F1007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 14:55:39 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix swiotlb ops for ppc64
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <F8F675D7-B3F9-45B8-92D3-A3D1F0BF7746@kernel.crashing.org>
Date: Mon, 12 Dec 2011 21:55:54 -0600
Message-Id: <4BCA9D4A-4284-4DE8-95B9-D5DBA9254CC1@kernel.crashing.org>
References: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
 <1323314600.12793.19.camel@pasglop>
 <F8F675D7-B3F9-45B8-92D3-A3D1F0BF7746@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 7, 2011, at 11:46 PM, Kumar Gala wrote:

>=20
> On Dec 7, 2011, at 9:23 PM, Benjamin Herrenschmidt wrote:
>=20
>> On Wed, 2011-12-07 at 11:19 -0600, Kumar Gala wrote:
>>=20
>>> struct dma_map_ops swiotlb_dma_ops =3D {
>>> +#ifdef CONFIG_PPC64
>>> +	.alloc_coherent =3D swiotlb_alloc_coherent,
>>> +	.free_coherent =3D swiotlb_free_coherent,
>>> +#else
>>> 	.alloc_coherent =3D dma_direct_alloc_coherent,
>>> 	.free_coherent =3D dma_direct_free_coherent,
>>> +#endif
>>> 	.map_sg =3D swiotlb_map_sg_attrs,
>>> 	.unmap_sg =3D swiotlb_unmap_sg_attrs,
>>> 	.dma_supported =3D swiotlb_dma_supported,
>>=20
>> Do we really need the ifdef ? What happens if we use
>> swiotlb_alloc_coherent() on ppc32 ? Won't it allocate lowmem, realize
>> that it doesn't need bouncing and be happy ?
>>=20
>> Cheers,
>> Ben.
>=20
> Becky any comment?
>=20
> I know its been a while, but wondering if you had any reason to not do =
what Ben's suggesting ?

Well, as you say, it's been a while, and but I think:

1) dma_direct_alloc_coherent strips GFP_HIGHMEM out of the flags field =
when calling the actual allocator and the iotlb version does not.  I =
don't know how much this matters - I did a quick grep and I don't see =
any users that specify that, but somebody went through the trouble of =
putting it in there in the first place and without knowing why I wasn't =
willing to get rid of it.  Now, since my patch it looks like someone =
added a VM_BUG_ON into __get_free_pages() if GFP_HIGHMEM so this would =
get caught.  However, I don't know if we really want to throw a bug =
there.

2)  The iotlb code doesn't deal with the !coherent parts like 8xx.  We =
can work around that by setting up the dma_ops differently for that case =
instead.

-Becky
