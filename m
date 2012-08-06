Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id BD2852C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 21:57:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: qiang.liu@freescale.com
Subject: Re: [PATCH v6 6/8] fsl-dma: use spin_lock_bh to instead of
 spin_lock_irqsave
Date: Mon, 6 Aug 2012 11:57:17 +0000
References: <1344249361-10263-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1344249361-10263-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201208061157.17667.arnd@arndb.de>
Cc: vinod.koul@intel.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>,
 dan.j.williams@gmail.com, herbert@gondor.hengli.com.au,
 linux-crypto@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 06 August 2012, qiang.liu@freescale.com wrote:
> 
> From: Qiang Liu <qiang.liu@freescale.com>
> 
> The use of spin_lock_irqsave() is a stronger locking mechanism than is
> required throughout the driver. The minimum locking required should be
> used instead. Interrupts will be turned off and context will be saved,
> there is needless to use irqsave.
> 
> Change all instances of spin_lock_irqsave() to spin_lock_bh().
> All manipulation of protected fields is done using tasklet context or
> weaker, which makes spin_lock_bh() the correct choice.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dan Williams <dan.j.williams@gmail.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Timur Tabi <timur@freescale.com>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>

Acked-by: Arnd Bergmann <arnd@arndb.de>

You could actually change the use of spin_lock_bh inside of the tasklet
function (dma_do_tasklet) do just spin_lock(), because softirqs are
already disabled there, but your version is also ok.
