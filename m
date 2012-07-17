Return-Path: <B32616@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76B492C016D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 14:23:32 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [linuxppc-release] [PATCH v3 4/4] fsl-dma: use spin_lock_bh to
 instead of spin_lock_irqsave
Date: Tue, 17 Jul 2012 04:23:22 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C2788@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1342411780-29930-1-git-send-email-qiang.liu@freescale.com>
 <5004244D.4000106@freescale.com>
In-Reply-To: <5004244D.4000106@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>, Vinod Koul <vinod.koul@intel.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Monday, July 16, 2012 10:25 PM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Vinod
> Koul; herbert@gondor.hengli.com.au; Dan Williams; Li Yang-R58472;
> davem@davemloft.net
> Subject: Re: [linuxppc-release] [PATCH v3 4/4] fsl-dma: use spin_lock_bh
> to instead of spin_lock_irqsave
>=20
> Qiang Liu wrote:
> > Use spin_lock_bh to instead of spin_lock_irqsave for improving
> performance.
>=20
> You forgot to include the evidence that performance has improved, as well
> as an explanation why it's okay to use spin_lock_bh, and why it's faster.
>   I told you to respin the patch with that information in the patch
> description.
I attached the test result in v3 0/4, performance is improved by 2%.
For my understanding, there is not any place to access descriptor lists
in fsl-dma interrupt service handler except its tasklet, spin_lock_bh()
is born for this. Interrupts will be turned off and context will be save in
irqsave, there is needless to use irqsave in our case. You can refer to the
implement of mv_xor.c or ioap-adma.c.
If you think my explanation is ok, I can add it in the patch.
Thanks.

>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale
