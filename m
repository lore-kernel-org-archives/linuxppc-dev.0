Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32AA52C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 12:45:53 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v6 6/8] fsl-dma: use spin_lock_bh to instead of
 spin_lock_irqsave
Date: Tue, 7 Aug 2012 02:45:45 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70E1020@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1344249361-10263-1-git-send-email-qiang.liu@freescale.com>
 <201208061157.17667.arnd@arndb.de>
In-Reply-To: <201208061157.17667.arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Phillips Kim-R1AAHA <R1AAHA@freescale.com>,
 "dan.j.williams@gmail.com" <dan.j.williams@gmail.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Monday, August 06, 2012 7:57 PM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> dan.j.williams@intel.com; linux-kernel@vger.kernel.org;
> dan.j.williams@gmail.com; vinod.koul@intel.com; Phillips Kim-R1AAHA;
> herbert@gondor.hengli.com.au; davem@davemloft.net;
> gregkh@linuxfoundation.org; Li Yang-R58472; Tabi Timur-B04825
> Subject: Re: [PATCH v6 6/8] fsl-dma: use spin_lock_bh to instead of
> spin_lock_irqsave
>=20
> On Monday 06 August 2012, qiang.liu@freescale.com wrote:
> >
> > From: Qiang Liu <qiang.liu@freescale.com>
> >
> > The use of spin_lock_irqsave() is a stronger locking mechanism than is
> > required throughout the driver. The minimum locking required should be
> > used instead. Interrupts will be turned off and context will be saved,
> > there is needless to use irqsave.
> >
> > Change all instances of spin_lock_irqsave() to spin_lock_bh().
> > All manipulation of protected fields is done using tasklet context or
> > weaker, which makes spin_lock_bh() the correct choice.
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dan Williams <dan.j.williams@gmail.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Li Yang <leoli@freescale.com>
> > Cc: Timur Tabi <timur@freescale.com>
> > Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> > Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> You could actually change the use of spin_lock_bh inside of the tasklet
> function (dma_do_tasklet) do just spin_lock(), because softirqs are
> already disabled there, but your version is also ok.
Yes, you are right, it will disable softirq.
Thank you very much.
