Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F3241A012A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 19:18:10 +1000 (EST)
Message-ID: <1410772688.3931.0.camel@concordia>
Subject: Re: [PATCH] powerpc/iommu/ddw: Fix endianness
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 15 Sep 2014 19:18:08 +1000
In-Reply-To: <5416A64E.1060005@ozlabs.ru>
References: <1410261723-21810-1-git-send-email-aik@ozlabs.ru>
 <5416A64E.1060005@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexander Graf <agraf@suse.de>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-15 at 18:41 +1000, Alexey Kardashevskiy wrote:
> On 09/09/2014 09:22 PM, Alexey Kardashevskiy wrote:
> > rtas_call() accepts and returns values in CPU endianness.

Sounds right.

> > of_read_number() accepts big-endian values but create.addr_hi/lo returned
> > by rtas_call() are in CPU endiannes.

Also sounds right.

> > The dynamic_dma_window_prop struct defines all members as BE so let's
> > make it true.

It does. But why does it do that? It seems to be allocated and setup in
enable_ddw() and then the only place I see it used is in
tce_setrange_multi_pSeriesLP()/tce_clearrange_multi_pSeriesLP(), which both
unpack it again. What am I missing?

> > struct dynamic_dma_window_prop {
> >         __be32  liobn;          /* tce table number */
> >         __be64  dma_base;       /* address hi,lo */
> >         __be32  tce_shift;      /* ilog2(tce_page_size) */
> >         __be32  window_shift;   /* ilog2(tce_window_size) */
> > };

We do read them from the device tree in find_existing_ddw_windows(), but if
that's the only place then the conversion to cpu endian should happen there.

> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 7c1d77c..700020a 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -750,7 +750,7 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
> >  		pr_debug("%s successfully cleared tces in window.\n",
> >  			 np->full_name);
> >  
> > -	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
> > +	ret = rtas_call(be32_to_cpu(ddw_avail[2]), 1, 1, NULL, liobn);

The conversion should happen once where ever ddw_avail comes out of the device
tree, rather than everywhere it's used.

cheers
