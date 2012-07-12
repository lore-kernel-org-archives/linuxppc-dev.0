Return-Path: <B32616@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2A792C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 19:07:20 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [linuxppc-release] [PATCH v2 4/4] fsl-dma: use spin_lock_bh to
 instead of spin_lock_irqsave
Date: Thu, 12 Jul 2012 09:07:08 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C0987@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1341997326-18495-1-git-send-email-qiang.liu@freescale.com>
 <4FFD952D.8040201@freescale.com>
In-Reply-To: <4FFD952D.8040201@freescale.com>
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
> Sent: Wednesday, July 11, 2012 11:01 PM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Vinod
> Koul; herbert@gondor.hengli.com.au; Dan Williams; Li Yang-R58472;
> davem@davemloft.net
> Subject: Re: [linuxppc-release] [PATCH v2 4/4] fsl-dma: use spin_lock_bh
> to instead of spin_lock_irqsave
>=20
> Qiang Liu wrote:
> > Use spin_lock_bh to instead of spin_lock_irqsave for improving
> performance.
>=20
> Please provide some evidence that performance has improved, as well as an
> explanation why it's okay to use spin_lock_bh, and why it's faster.
I compared my test result before and after this patch, write performance ca=
n
improved by 15%. I will send the latest patches sooner because of Ira's con=
cern.
I will give a complete description about the improvement of spin_lock_bh().

About your question, spin_lock_bh is used in the case of bottom/half as its
name, there is no need to protect a running/pending list with spin_lock_irq=
save.

Thanks.

> --
> Timur Tabi
> Linux kernel developer at Freescale
