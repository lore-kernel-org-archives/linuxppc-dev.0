Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65B4B2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 01:56:56 +1000 (EST)
Message-ID: <500584C7.8080501@freescale.com>
Date: Tue, 17 Jul 2012 10:29:11 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Liu Qiang-B32616 <B32616@freescale.com>
Subject: Re: [linuxppc-release] [PATCH v3 4/4] fsl-dma: use spin_lock_bh to
 instead of spin_lock_irqsave
References: <1342411780-29930-1-git-send-email-qiang.liu@freescale.com>
 <5004244D.4000106@freescale.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70C2788@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C2788@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
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

Liu Qiang-B32616 wrote:
> I attached the test result in v3 0/4, performance is improved by 2%.
> For my understanding, there is not any place to access descriptor lists
> in fsl-dma interrupt service handler except its tasklet, spin_lock_bh()
> is born for this. Interrupts will be turned off and context will be save in
> irqsave, there is needless to use irqsave in our case. You can refer to the
> implement of mv_xor.c or ioap-adma.c.
> If you think my explanation is ok, I can add it in the patch.

Yes, the explanation is ok.  Please make it part of the patch description,
so that it is saved in the git history.

-- 
Timur Tabi
Linux kernel developer at Freescale
