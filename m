Return-Path: <R1AAHA@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E58DF2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 11:06:31 +1000 (EST)
Date: Mon, 16 Jul 2012 20:04:23 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Qiang Liu <qiang.liu@freescale.com>
Subject: Re: [PATCH v3 0/4] Raid: enable talitos xor offload for improving
 performance
Message-ID: <20120716200423.830d174e69fc0aafb40d2858@freescale.com>
In-Reply-To: <1342411636-29770-1-git-send-email-qiang.liu@freescale.com>
References: <1342411636-29770-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: herbert@gondor.hengli.com.au, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 16 Jul 2012 12:07:16 +0800
Qiang Liu <qiang.liu@freescale.com> wrote:

>  drivers/crypto/Kconfig   |    9 +
>  drivers/crypto/talitos.c |  410 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/crypto/talitos.h |   53 ++++++
>  drivers/dma/fsldma.c     |  436 +++++++++++++++++++++++++---------------------
>  drivers/dma/fsldma.h     |    1 +
>  5 files changed, 708 insertions(+), 201 deletions(-)

Given the pending talitos patches, this patchseries doesn't apply
cleanly:  can you rebase onto [1], which is based on Herbert's
cryptodev tree and contain's Horia's four patches?  They didn't get
any negative comments, so I assume eventually they will be applied,
and doing so will make Herbert's life easier.

I applied the series on Herbert's cryptodev, and while fsldma
already had this build warning:

drivers/dma/fsldma.c: In function 'fsl_dma_tx_submit':
drivers/dma/fsldma.c:636:2: warning: 'cookie' may be used uninitialized in this function [-Wuninitialized]

this patchseries introduces a new one:

drivers/dma/fsldma.c: In function 'dma_do_tasklet':
drivers/dma/fsldma.c:1134:16: warning: unused variable 'flags' [-Wunused-variable]

I'll wait for a re-post, after these and Ira's comments are
addressed, before trying to test again.

Thanks,

Kim

[1] git://git.freescale.com/crypto/cryptodev.git
