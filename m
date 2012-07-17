Return-Path: <pku.leo@gmail.com>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AADA72C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 13:36:44 +1000 (EST)
Received: by ghbg24 with SMTP id g24so5550913ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 20:36:41 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1342411709-29895-1-git-send-email-qiang.liu@freescale.com>
References: <1342411709-29895-1-git-send-email-qiang.liu@freescale.com>
Date: Tue, 17 Jul 2012 11:36:41 +0800
Message-ID: <CADRPPNS-cOwCTVYnjq==W-f1-AAWctyOFg_6bkSDZPtM8Jf+Lw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] fsl-dma: change release process of dma descriptor
 for supporting async_tx
From: Li Yang <leoli@freescale.com>
To: Qiang Liu <qiang.liu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Vinod Koul <vinod.koul@intel.com>,
 herbert@gondor.hengli.com.au, linux-crypto@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2012 at 12:08 PM, Qiang Liu <qiang.liu@freescale.com> wrote:
> Fix the potential risk when enable config NET_DMA and ASYNC_TX.
> Async_tx is lack of support in current release process of dma descriptor,
> all descriptors will be released whatever is acked or no-acked by async_tx,
> so there is a potential race condition when dma engine is uesd by others
> clients (e.g. when enable NET_DMA to offload TCP).
>
> In our case, a race condition which is raised when use both of talitos
> and dmaengine to offload xor is because napi scheduler will sync all
> pending requests in dma channels, it affects the process of raid operations
> due to ack_tx is not checked in fsl dma. The no-acked descriptor is freed
> which is submitted just now, as a dependent tx, this freed descriptor trigger
> BUG_ON(async_tx_test_ack(depend_tx)) in async_tx_submit().
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Ira W. Snyder <iws@ovro.caltech.edu>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>

Also separate the function ordering change and real code change into
different patches when you work on the next patch set.

- Leo
