Return-Path: <dan.j.williams@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DE6B92C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Sep 2012 18:41:21 +1000 (EST)
Received: by pbbro8 with SMTP id ro8so7137083pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Sep 2012 01:41:19 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1344500582-11110-1-git-send-email-qiang.liu@freescale.com>
References: <1344500582-11110-1-git-send-email-qiang.liu@freescale.com>
Date: Sun, 2 Sep 2012 01:41:18 -0700
Message-ID: <CAA9_cmeFamCX1u+z3fP_gxAqe83JFbY9Beqpqgb-PjRoJ8BrWA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] fsl-dma: use spin_lock_bh to instead of
 spin_lock_irqsave
From: Dan Williams <djbw@fb.com>
To: qiang.liu@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: arnd@arndb.de, vinod.koul@intel.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>,
 herbert@gondor.hengli.com.au, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 9, 2012 at 1:23 AM,  <qiang.liu@freescale.com> wrote:
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

It seems you are coordinating fsl-dma copy and talitos xor operations.
 It looks like fsl-dma will be called through
talitos_process_pending()->dma_run_dependencies(), which is
potentially called in hard irq context.

This all comes back to the need to fix raid offload to manage the
channels explicitly rather than the current dependency chains.

--
Dan
