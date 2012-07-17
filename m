Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 38C712C014A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 14:02:07 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Phillips Kim-R1AAHA <R1AAHA@freescale.com>
Subject: RE: [PATCH v3 0/4] Raid: enable talitos xor offload for improving
 performance
Date: Tue, 17 Jul 2012 04:01:57 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C2735@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1342411636-29770-1-git-send-email-qiang.liu@freescale.com>
 <20120716200423.830d174e69fc0aafb40d2858@freescale.com>
In-Reply-To: <20120716200423.830d174e69fc0aafb40d2858@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Phillips Kim-R1AAHA
> Sent: Tuesday, July 17, 2012 9:04 AM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Li Yang-
> R58472; dan.j.williams@intel.com; herbert@gondor.hengli.com.au
> Subject: Re: [PATCH v3 0/4] Raid: enable talitos xor offload for
> improving performance
>=20
> On Mon, 16 Jul 2012 12:07:16 +0800
> Qiang Liu <qiang.liu@freescale.com> wrote:
>=20
> >  drivers/crypto/Kconfig   |    9 +
> >  drivers/crypto/talitos.c |  410
> +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/crypto/talitos.h |   53 ++++++
> >  drivers/dma/fsldma.c     |  436 +++++++++++++++++++++++++-------------
> --------
> >  drivers/dma/fsldma.h     |    1 +
> >  5 files changed, 708 insertions(+), 201 deletions(-)
>=20
> Given the pending talitos patches, this patchseries doesn't apply
> cleanly:  can you rebase onto [1], which is based on Herbert's
> cryptodev tree and contain's Horia's four patches?  They didn't get
> any negative comments, so I assume eventually they will be applied,
> and doing so will make Herbert's life easier.
>=20
> I applied the series on Herbert's cryptodev, and while fsldma
> already had this build warning:
>=20
> drivers/dma/fsldma.c: In function 'fsl_dma_tx_submit':
> drivers/dma/fsldma.c:636:2: warning: 'cookie' may be used uninitialized
> in this function [-Wuninitialized]
Kim, I will fix it in an another separate patch.

>=20
> this patchseries introduces a new one:
>=20
> drivers/dma/fsldma.c: In function 'dma_do_tasklet':
> drivers/dma/fsldma.c:1134:16: warning: unused variable 'flags' [-Wunused-
> variable]
Sorry, my bad. I will correct it in v4 5/6 (according to Li Yang's comments=
,
v3 3/4 should be split up). Thanks.

>=20
> I'll wait for a re-post, after these and Ira's comments are
> addressed, before trying to test again.
I agree, I think his comments is very important.

>=20
> Thanks,
>=20
> Kim
>=20
> [1] git://git.freescale.com/crypto/cryptodev.git
