Return-Path: <B32616@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 176412C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 19:45:13 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Dan Williams <djbw@fb.com>
Subject: RE: [PATCH v7 1/8] Talitos: Support for async_tx XOR offload
Date: Wed, 12 Sep 2012 09:45:05 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB710E9A7@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1344500448-10927-1-git-send-email-qiang.liu@freescale.com>
 <CAA9_cmdqmuhAcaqfkjvKSpsTL350BAJcY8pn6U=SJ9Nok1-XuA@mail.gmail.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70FFB67@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAA9_cmfT1R2+r9_8g0giMJz+wvrNce6T6GPDpvUTtcA-UyAZNQ@mail.gmail.com>
In-Reply-To: <CAA9_cmfT1R2+r9_8g0giMJz+wvrNce6T6GPDpvUTtcA-UyAZNQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Dave Jiang <dave.jiang@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Phillips Kim-R1AAHA <R1AAHA@freescale.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> Will this engine be coordinating with another to handle memory copies?
> >>  The dma mapping code for async_tx/raid is broken when dma mapping
> >> requests overlap or cross dma device boundaries [1].
> >>
> >> [1]: http://marc.info/?l=3Dlinux-arm-kernel&m=3D129407269402930&w=3D2
> > Yes, it needs fsl-dma to handle memcpy copies.
> > I read your link, the unmap address is stored in talitos hwdesc, the
> address will be unmapped when async_tx ack this descriptor, I know fsl-
> dma won't wait this ack flag in current kernel, so I fix it in fsl-dma
> patch 5/8. Do you mean that?
>=20
> Unfortunately no.  I'm open to other suggestions. but as far as I can
> see it requires deeper changes to rip out the dma mapping that happens
> in async_tx and the automatic unmapping done by drivers.  It should
> all be pushed to the client (md).
>=20
> Currently async_tx hides hardware details from md such that it doesn't
> even care if the operation is offloaded to hardware at all, but that
> takes things too far.  In the worst case an copy->xor chain handled by
> multiple channels results in :
>=20
> 1/ dma_map(copy_chan...)
> 2/ dma_map(xor_chan...)
> 3/ <exec copy>
> 4/ dma_unmap(copy_chan...)
> 5/ <exec xor> <---initiated by the copy_chan
> 6/ dma_unmap(xor_chan...)
>=20
> Step 2 violates the dma api since the buffers belong to the xor_chan
> until unmap.  Step 5 also causes the random completion context of the
> copy channel to bleed into submission context of the xor channel which
> is problematic.  So the order needs to be:
>=20
> 1/ dma_map(copy_chan...)
> 2/ <exec copy>
> 3/ dma_unmap(copy_chan...)
> 4/ dma_map(xor_chan...)
> 5/ <exec xor> <--initiated by md in a static context
> 6/ dma_unmap(xor_chan...)
>=20
> Also, if xor_chan and copy_chan lie with the same dma mapping domain
> (iommu or parent device) then we can map the stripe once and skip the
> extra maintenance for the duration of the chain of operations.  This
> dumps a lot of hardware details on md, but I think it is the only way
> to get consistent semantics when arbitrary offload devices are
> involved.
Thanks for your answer and links, I did some investigate these days,

first, powerpc processor should be hardware assured cache coherency, it sho=
uld
be ok for hardware when in step 5 (but I will avoid map same address on dif=
ferent
device).

second, I have a workaround to make dma_map/unmap by order when using 2 dif=
ferent
device to offload, I will submit next descriptor until current descriptor c=
omplete,
        if (submit->flags & ASYNC_TX_ACK)
                async_tx_ack(tx);
        if (depend_tx)
                async_tx_ack(depend_tx);

+       /* do more check to support 2 devices offload? */
+       if (dma_wait_for_async_tx(tx) =3D=3D DMA_ERROR)
+               panic("%s: DMA_ERROR waiting for tx\n", __func__);
}
EXPORT_SYMBOL_GPL(async_tx_submit);

Also use your example,=20
1/ dma_map(copy_chan...)
2/ tx->submit(tx); async_tx_ack(tx);
3/ dma_unmap(copy_chan...)
4/ dma_map(xor_chan...)
5/ <exec xor> <-- initialized by tx->submit(tx);
6/ dma_unmap(xor_chan...)

Under this way, actually dma_run_dependency() is useless, so this can make =
sure copy
and xor with same page processed by order, and only one descriptor per chan=
nel is
served. dma_unmap in driver is controlled by client (tx->flags)

How's you thinking or any suggestions? I test it on our powerpc, I don't kn=
ow whether
it does work on other architecture.

Thanks.

>=20
> --
> Dan
