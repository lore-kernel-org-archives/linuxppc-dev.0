Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0121.outbound.protection.outlook.com [207.46.100.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6A6C1A039D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:34:33 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Laura Abbott <labbott@redhat.com>, Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xiaobo Xie
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Leo <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
Date: Tue, 25 Aug 2015 07:19:17 +0000
Message-ID: <SN1PR0301MB1550CE6B922CE64AA4F862759B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
 <55DBA98D.1070202@redhat.com>
 <SN1PR0301MB1550C9087AFB9FEB6CD1B0899B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <55DBEBBE.30702@redhat.com>
In-Reply-To: <55DBEBBE.30702@redhat.com>
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

On 08/25/2015 12:15 PM, Laura Abbott wrote
> -----Original Message-----
> From: Laura Abbott [mailto:labbott@redhat.com]
> Sent: Tuesday, August 25, 2015 12:15 PM
> To: Zhao Qiang-B45475; Wood Scott-B07421
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> Yang-Leo-R58472; paulus@samba.org
> Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage
> muram
>=20
> On 08/24/2015 08:03 PM, Zhao Qiang wrote:
> >
> >> -----Original Message-----
> >> From: Laura Abbott [mailto:labbott@redhat.com]
> >> Sent: Tuesday, August 25, 2015 7:32 AM
> >> To: Zhao Qiang-B45475; Wood Scott-B07421
> >> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> >> lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org;
> >> Li Yang-Leo-R58472; paulus@samba.org
> >> Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to
> >> manage muram
> >>
> >> On 08/24/2015 02:31 AM, Zhao Qiang wrote:
> >>
> >>
> >>> +out:
> >>> +	of_node_put(np);
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +/**
> >>> + * qe_muram_alloc - allocate the requested size worth of multi-user
> >>> +ram
> >>> + * @size: number of bytes to allocate
> >>> + * @align: requested alignment, in bytes
> >>> + *
> >>> + * This function returns an offset into the muram area.
> >>> + * Use qe_dpram_addr() to get the virtual address of the area.
> >>> + * Use qe_muram_free() to free the allocation.
> >>> + */
> >>> +unsigned long qe_muram_alloc(unsigned long size, unsigned long
> >>> +align) {
> >>> +	unsigned long start;
> >>> +	unsigned long flags;
> >>> +	struct muram_block *entry;
> >>> +
> >>> +	spin_lock_irqsave(&qe_muram_lock, flags);
> >>> +	muram_pool_data.align =3D align;
> >>> +	start =3D gen_pool_alloc(muram_pool, size);
> >>
> >> The advantage of creating gen_pool_alloc_data was so that you could
> >> pass in the align automatically without having to modify the structure=
.
> >> Is there a reason you aren't using that?
> >>
> >>> +	memset(qe_muram_addr(start), 0, size);
> >>
> >> There doesn't seem to be a check for allocation failure from the
> >> gen_alloc.
> >
> > gen_pool_alloc will return 0 if there is error, but if the address
> > returned is just 0x0, it can't distinguish it is address or error.
> >
>=20
> Yes, that's a bad limitation of gen_pool. Maybe one day that will get
> fixed.
> In a previous out of tree driver, I worked around this by offsetting the
> gen_pool_add by a constant so any return value was non-zero and out of
> memory was zero and then subtracting the constant off of the return value=
.
> Not sure if that's better or worse than just fixing gen_alloc.
>=20

The workaround works for non alignment allocation, but for alignment alloca=
tion,
It need to align bytes to addr 0, offsetting the gen_pool_add maybe make wr=
ong alignment
.

>=20
> Thanks,
> Laura
