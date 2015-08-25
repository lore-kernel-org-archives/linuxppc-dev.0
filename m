Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0122.outbound.protection.outlook.com [207.46.100.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DC401A0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 13:03:22 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Laura Abbott <labbott@redhat.com>, Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xiaobo Xie
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Leo <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
Date: Tue, 25 Aug 2015 03:03:09 +0000
Message-ID: <SN1PR0301MB1550C9087AFB9FEB6CD1B0899B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
 <55DBA98D.1070202@redhat.com>
In-Reply-To: <55DBA98D.1070202@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Laura Abbott [mailto:labbott@redhat.com]
> Sent: Tuesday, August 25, 2015 7:32 AM
> To: Zhao Qiang-B45475; Wood Scott-B07421
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> Yang-Leo-R58472; paulus@samba.org
> Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage
> muram
>=20
> On 08/24/2015 02:31 AM, Zhao Qiang wrote:
>=20
>=20
> > +out:
> > +	of_node_put(np);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * qe_muram_alloc - allocate the requested size worth of multi-user
> > +ram
> > + * @size: number of bytes to allocate
> > + * @align: requested alignment, in bytes
> > + *
> > + * This function returns an offset into the muram area.
> > + * Use qe_dpram_addr() to get the virtual address of the area.
> > + * Use qe_muram_free() to free the allocation.
> > + */
> > +unsigned long qe_muram_alloc(unsigned long size, unsigned long align)
> > +{
> > +	unsigned long start;
> > +	unsigned long flags;
> > +	struct muram_block *entry;
> > +
> > +	spin_lock_irqsave(&qe_muram_lock, flags);
> > +	muram_pool_data.align =3D align;
> > +	start =3D gen_pool_alloc(muram_pool, size);
>=20
> The advantage of creating gen_pool_alloc_data was so that you could pass
> in the align automatically without having to modify the structure.
> Is there a reason you aren't using that?
>=20
> > +	memset(qe_muram_addr(start), 0, size);
>=20
> There doesn't seem to be a check for allocation failure from the
> gen_alloc.

gen_pool_alloc will return 0 if there is error, but if the address returned=
 is=20
just 0x0, it can't distinguish it is address or error.

>=20
> > +	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> > +	if (!entry)
> > +		goto out;
> > +	entry->start =3D start;
> > +	entry->size =3D size;
> > +	list_add(&entry->head, &muram_block_list);
>=20
> What's the point of keeping the block list anyway? It's used only in this
> file and it only seems to duplicate what gen_alloc is doing internally.
> Is there some lookup functionality you still need? Could you use a
> gen_alloc API to do so?

I need to record the size when allocation, so when free the block, I can ge=
t=20
The right size for the block, and pass the right size to=20
gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size).

>=20
>=20
> Thanks,
> Laura
Thanks=20
Zhao
