Return-Path: <pengxihan@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id A588DB6EF0
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 13:58:02 +1000 (EST)
Received: by iwn36 with SMTP id 36so6047031iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 20:58:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
Date: Wed, 14 Jul 2010 11:58:00 +0800
Message-ID: <AANLkTinfOy_oJkX99Jqz2uJPLSN-goVqAl7hHv5u2FZN@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
From: hank peng <pengxihan@gmail.com>
To: Vishnu Suresh <Vishnu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: herbert@gondor.apana.org.au, B04825@freescale.com,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org,
	dan.j.williams@intel.com, Maneesh Gupta <Maneesh.Gupta@freescale.com>,
	R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi:
I used your patch and test it on MPC8548 board. Today, I found a
problem when doing raid5 recovering.

talitos e0030000.crypto: master data transfer error
talitos e0030000.crypto: xor operation: talitos error -22
------------[ cut here ]------------
Kernel BUG at c02dcb6c [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
MPC85xx CDS
Modules linked in: iscsi_trgt
NIP: c02dcb6c LR: c02dcb6c CTR: c023e7a8
REGS: e8b8d820 TRAP: 0700   Not tainted  (2.6.31.6)
MSR: 00029000 <EE,ME,CE>  CR: 22008022  XER: 20000000
TASK =3D ef8cb2e0[1897] 'md2_raid5' THREAD: e8b8c000
GPR00: c02dcb6c e8b8d8d0 ef8cb2e0 00000040 00007c99 ffffffff c023bccc 00007=
c5f
GPR08: c04a5c60 c049b5fc 00007c99 00004000 80008022 00000000 3fff5700 c3374=
754
GPR16: c337474c 00000000 00000000 ffffffea 00000001 00000000 000186a0 00000=
000
GPR24: ffffffea ffffffea ef81f850 0000000c 00029000 ffffffea ef81f850 efb1d=
580
NIP [c02dcb6c] talitos_release_xor+0xfc/0x104
LR [c02dcb6c] talitos_release_xor+0xfc/0x104
Call Trace:
[e8b8d8d0] [c02dcb6c] talitos_release_xor+0xfc/0x104 (unreliable)
[e8b8d8f0] [c02db928] flush_channel+0x11c/0x178
[e8b8d920] [c02dd344] talitos_interrupt+0x320/0x9e8
[e8b8d970] [c0060b3c] handle_IRQ_event+0x5c/0x140
[e8b8d990] [c006280c] handle_fasteoi_irq+0x68/0x118
[e8b8d9a0] [c0004f08] do_IRQ+0x94/0xb0
[e8b8d9c0] [c000fe00] ret_from_except+0x0/0x18
[e8b8da80] [c02b47a0] release_stripe+0x24/0x3c
[e8b8da90] [c02ba4ec] raid5_end_read_request+0x160/0x3f8
[e8b8dae0] [c00ba36c] bio_endio+0x48/0x6c
[e8b8daf0] [c01f80e0] req_bio_endio+0xa4/0x128
[e8b8db10] [c01f81f0] blk_update_request+0x8c/0x43c
[e8b8db40] [c01f85c0] blk_update_bidi_request+0x20/0x88
[e8b8db60] [c01f92c4] blk_end_bidi_request+0x1c/0x58
[e8b8db80] [c01f9314] blk_end_request+0x14/0x24
[e8b8db90] [c025ece0] scsi_io_completion+0x8c/0x4ac
[e8b8dbd0] [c0257fd0] scsi_finish_command+0xd0/0xf4
[e8b8dbf0] [c025f1c8] scsi_softirq_done+0xc8/0x150
[e8b8dc10] [c01fe114] blk_done_softirq+0x80/0xa0
[e8b8dc30] [c003a0d8] __do_softirq+0xa8/0x128
[e8b8dc70] [c0004e70] do_softirq+0x54/0x58
[e8b8dc80] [c0039f4c] irq_exit+0x94/0x98
[e8b8dc90] [c0004f0c] do_IRQ+0x98/0xb0
[e8b8dcb0] [c000fe00] ret_from_except+0x0/0x18
[e8b8dd70] [c00679c8] mempool_alloc_slab+0x1c/0x2c
[e8b8ddb0] [c02b6814] ops_run_io+0x1ac/0x2b8
[e8b8ddf0] [c02b93e4] handle_stripe5+0xa80/0x15c0
[e8b8de70] [c02bb408] handle_stripe+0x34/0x12d4
[e8b8df10] [c02bc8ec] raid5d+0x244/0x458
[e8b8df70] [c02c9624] md_thread+0x5c/0x124
[e8b8dfc0] [c004ab24] kthread+0x78/0x7c
[e8b8dff0] [c000f52c] kernel_thread+0x4c/0x68
Instruction dump:
bb61000c 38210020 7c0803a6 4bffefac 4bf63bc9 80be0008 7c641b78 3c60c042
7fa6eb78 38631ccc 4cc63182 4bd58b9d <0fe00000> 48000000 9421ffd0 7c0802a6
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 1 seconds..
------------[ cut here ]------------
Badness at c0223124 [verbose debug info unavailable]
NIP: c0223124 LR: c0223308 CTR: 00000000
REGS: e8b8d580 TRAP: 0700   Tainted: G      D     (2.6.31.6)
MSR: 00021000 <ME,CE>  CR: 82008088  XER: 20000000
TASK =3D ef8cb2e0[1897] 'md2_raid5' THREAD: e8b8c000
GPR00: 00000001 e8b8d630 ef8cb2e0 e84f1d60 00000000 e84f1d60 e84f1d7c c04a1=
364
GPR08: c04a5c60 e8b8c000 0000873b e8b8d650 82008088 00000000 3fff5700 c3374=
754
GPR16: c337474c 00000000 00000000 ffffffea 00000001 00000000 000186a0 00000=
000
GPR24: ffffffea ffffffea 00000000 ffffffff ffffffff 00000000 00001106 e84f1=
d60
NIP [c0223124] pci_get_dev_by_id+0x34/0x98
LR [c0223308] pci_get_subsys+0x64/0xa4
Call Trace:
[e8b8d630] [c021e378] no_pci_devices+0x34/0x50 (unreliable)
[e8b8d650] [c0223308] pci_get_subsys+0x64/0xa4
[e8b8d670] [c0017be0] mpc85xx_cds_restart+0x24/0x90
[e8b8d690] [c000e7d0] machine_restart+0x34/0x4c
[e8b8d6a0] [c00447e0] emergency_restart+0x14/0x24
[e8b8d6b0] [c003473c] panic+0x118/0x158
[e8b8d700] [c000cf24] die+0x160/0x16c
[e8b8d720] [c000d1b0] _exception+0x12c/0x154
[e8b8d810] [c000fdb4] ret_from_except_full+0x0/0x4c
[e8b8d8d0] [c02dcb6c] talitos_release_xor+0xfc/0x104
[e8b8d8f0] [c02db928] flush_channel+0x11c/0x178
[e8b8d920] [c02dd344] talitos_interrupt+0x320/0x9e8
[e8b8d970] [c0060b3c] handle_IRQ_event+0x5c/0x140
[e8b8d990] [c006280c] handle_fasteoi_irq+0x68/0x118
[e8b8d9a0] [c0004f08] do_IRQ+0x94/0xb0
[e8b8d9c0] [c000fe00] ret_from_except+0x0/0x18
[e8b8da80] [c02b47a0] release_stripe+0x24/0x3c
[e8b8da90] [c02ba4ec] raid5_end_read_request+0x160/0x3f8
[e8b8dae0] [c00ba36c] bio_endio+0x48/0x6c
[e8b8daf0] [c01f80e0] req_bio_endio+0xa4/0x128
[e8b8db10] [c01f81f0] blk_update_request+0x8c/0x43c
[e8b8db40] [c01f85c0] blk_update_bidi_request+0x20/0x88
[e8b8db60] [c01f92c4] blk_end_bidi_request+0x1c/0x58
[e8b8db80] [c01f9314] blk_end_request+0x14/0x24
[e8b8db90] [c025ece0] scsi_io_completion+0x8c/0x4ac
[e8b8dbd0] [c0257fd0] scsi_finish_command+0xd0/0xf4
[e8b8dbf0] [c025f1c8] scsi_softirq_done+0xc8/0x150
[e8b8dc10] [c01fe114] blk_done_softirq+0x80/0xa0
[e8b8dc30] [c003a0d8] __do_softirq+0xa8/0x128
[e8b8dc70] [c0004e70] do_softirq+0x54/0x58
[e8b8dc80] [c0039f4c] irq_exit+0x94/0x98
[e8b8dc90] [c0004f0c] do_IRQ+0x98/0xb0
[e8b8dcb0] [c000fe00] ret_from_except+0x0/0x18
[e8b8dd70] [c00679c8] mempool_alloc_slab+0x1c/0x2c
[e8b8ddb0] [c02b6814] ops_run_io+0x1ac/0x2b8
[e8b8ddf0] [c02b93e4] handle_stripe5+0xa80/0x15c0
[e8b8de70] [c02bb408] handle_stripe+0x34/0x12d4
[e8b8df10] [c02bc8ec] raid5d+0x244/0x458
[e8b8df70] [c02c9624] md_thread+0x5c/0x124
[e8b8dfc0] [c004ab24] kthread+0x78/0x7c
[e8b8dff0] [c000f52c] kernel_thread+0x4c/0x68
Instruction dump:
7c0802a6 7d800026 7c651b78 bf810010 54290024 90010024 7c9d2378 9181000c
8009000c 5400016e 7c0000d0 54000ffe <0f000000> 3b800000 2e040000 3cc0c022


This oops is invoked by the following code:

static void talitos_release_xor(struct device *dev, struct talitos_desc *hw=
desc,
                               void *context, int error)
{
       struct talitos_xor_desc *desc =3D context;
       struct talitos_xor_chan *xor_chan;
       dma_async_tx_callback callback;
       void *callback_param;

       if (unlikely(error)) {
               dev_err(dev, "xor operation: talitos error %d\n", error);
               BUG();
<-----------------------------------------------------------------
here
       }

I wonder here why a tailitos error occured, BUG is invoked? I think we
can do something to error recovery other than invoking BUG.

2009/12/16 Vishnu Suresh <Vishnu@freescale.com>:
> Expose Talitos's XOR functionality to be used for
> RAID Parity calculation via the Async_tx layer.
>
> Known Issue:
> When used with fsldma, random crashes are observed
> on some platforms. Hence, inter-operability with fsldma
> is currently disabled
>
> Thanks to Surender Kumar and Lee Nipper for their help in
> realising this driver
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
> Signed-off-by: Maneesh Gupta <Maneesh.Gupta@freescale.com>
> Signed-off-by: Vishnu Suresh <Vishnu@freescale.com>
> ---
> Changes with respect to v1 as per comments received
> o. Rebased to linux-next as of 20091216
> o. The selection is based exclusive of fsldma
> o. Intoduced a new Kernel Configuration variable
> =C2=A0 *. This enables selecting the Cryptographic functionality
> =C2=A0 =C2=A0 =C2=A0of Talitos along with fsldma.
> =C2=A0 *. Disables the XOR parity calculation offload, if fsldma enabled
> =C2=A0 =C2=A0 =C2=A0either as kernel in-built or as a module
> =C2=A0 *. Once the inter-operability with fsldma is resolved, this option
> =C2=A0 =C2=A0 =C2=A0can be removed
>
> =C2=A0drivers/crypto/Kconfig =C2=A0 | =C2=A0 =C2=A09 +
> =C2=A0drivers/crypto/talitos.c | =C2=A0402 ++++++++++++++++++++++++++++++=
+++++++++++++++-
> =C2=A0drivers/crypto/talitos.h | =C2=A0 =C2=A02 +
> =C2=A03 files changed, 412 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index b08403d..f8a6376 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -203,6 +203,15 @@ config CRYPTO_DEV_TALITOS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, cho=
ose M here: the module
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called talitos.
>
> +config CRYPTO_DEV_TALITOS_RAIDXOR
> + =C2=A0 =C2=A0 =C2=A0 bool "Talitos RAID5 XOR Calculation Offload"
> + =C2=A0 =C2=A0 =C2=A0 select DMA_ENGINE
> + =C2=A0 =C2=A0 =C2=A0 depends on CRYPTO_DEV_TALITOS
> + =C2=A0 =C2=A0 =C2=A0 depends on FSL_DMA=3Dn
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say 'Y' here to use the Freescale Security =
Engine (SEC) to
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload RAID XOR parity Calculation
> +
> =C2=A0config CRYPTO_DEV_IXP4XX
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Driver for IXP4xx crypto hardware ac=
celeration"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_IXP4XX
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index c47ffe8..e63b25a 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -1,7 +1,7 @@
> =C2=A0/*
> =C2=A0* talitos - Freescale Integrated Security Engine (SEC) device drive=
r
> =C2=A0*
> - * Copyright (c) 2008 Freescale Semiconductor, Inc.
> + * Copyright (c) 2008-2009 Freescale Semiconductor, Inc.
> =C2=A0*
> =C2=A0* Scatterlist Crypto API glue code copied from files with the follo=
wing:
> =C2=A0* Copyright (c) 2006-2007 Herbert Xu <herbert@gondor.apana.org.au>
> @@ -37,6 +37,8 @@
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/spinlock.h>
> =C2=A0#include <linux/rtnetlink.h>
> +#include <linux/dmaengine.h>
> +#include <linux/raid/xor.h>
>
> =C2=A0#include <crypto/algapi.h>
> =C2=A0#include <crypto/aes.h>
> @@ -140,6 +142,10 @@ struct talitos_private {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* hwrng device */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hwrng rng;
> +#ifdef CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR
> + =C2=A0 =C2=A0 =C2=A0 /* XOR Device */
> + =C2=A0 =C2=A0 =C2=A0 struct dma_device dma_dev_common;
> +#endif /* CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR */
> =C2=A0};
>
> =C2=A0/* .features flag */
> @@ -684,6 +690,375 @@ static void talitos_unregister_rng(struct device *d=
ev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hwrng_unregister(&priv->rng);
> =C2=A0}
>
> +#ifdef CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR
> +/*
> + * async_tx interface for XOR-capable SECs
> + *
> + * Dipen Dudhat <Dipen.Dudhat@freescale.com>
> + * Maneesh Gupta <Maneesh.Gupta@freescale.com>
> + * Vishnu Suresh <Vishnu@freescale.com>
> + */
> +
> +/**
> + * talitos_xor_chan - context management for the async_tx channel
> + * @completed_cookie: the last completed cookie
> + * @desc_lock: lock for tx queue
> + * @total_desc: number of descriptors allocated
> + * @submit_q: queue of submitted descriptors
> + * @pending_q: queue of pending descriptors
> + * @in_progress_q: queue of descriptors in progress
> + * @free_desc: queue of unused descriptors
> + * @dev: talitos device implementing this channel
> + * @common: the corresponding xor channel in async_tx
> + */
> +struct talitos_xor_chan {
> + =C2=A0 =C2=A0 =C2=A0 dma_cookie_t completed_cookie;
> + =C2=A0 =C2=A0 =C2=A0 spinlock_t desc_lock;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int total_desc;
> + =C2=A0 =C2=A0 =C2=A0 struct list_head submit_q;
> + =C2=A0 =C2=A0 =C2=A0 struct list_head pending_q;
> + =C2=A0 =C2=A0 =C2=A0 struct list_head in_progress_q;
> + =C2=A0 =C2=A0 =C2=A0 struct list_head free_desc;
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev;
> + =C2=A0 =C2=A0 =C2=A0 struct dma_chan common;
> +};
> +
> +/**
> + * talitos_xor_desc - software xor descriptor
> + * @async_tx: the referring async_tx descriptor
> + * @node:
> + * @hwdesc: h/w descriptor
> + */
> +struct talitos_xor_desc {
> + =C2=A0 =C2=A0 =C2=A0 struct dma_async_tx_descriptor async_tx;
> + =C2=A0 =C2=A0 =C2=A0 struct list_head tx_list;
> + =C2=A0 =C2=A0 =C2=A0 struct list_head node;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_desc hwdesc;
> +};
> +
> +static enum dma_status talitos_is_tx_complete(struct dma_chan *chan,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dma_cookie_t cookie,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dma_cookie_t *done,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dma_cookie_t *used)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 dma_cookie_t last_used;
> + =C2=A0 =C2=A0 =C2=A0 dma_cookie_t last_complete;
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(chan, struct talitos_xor=
_chan, common);
> +
> + =C2=A0 =C2=A0 =C2=A0 last_used =3D chan->cookie;
> + =C2=A0 =C2=A0 =C2=A0 last_complete =3D xor_chan->completed_cookie;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (done)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *done =3D last_complet=
e;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (used)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *used =3D last_used;
> +
> + =C2=A0 =C2=A0 =C2=A0 return dma_async_is_complete(cookie, last_complete=
, last_used);
> +}
> +
> +static void talitos_release_xor(struct device *dev, struct talitos_desc =
*hwdesc,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *context, int error)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc =3D context;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 dma_async_tx_callback callback;
> + =C2=A0 =C2=A0 =C2=A0 void *callback_param;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(error)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "xor oper=
ation: talitos error %d\n", error);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(desc->async_tx.chan, str=
uct talitos_xor_chan,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 common);
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_bh(&xor_chan->desc_lock);
> + =C2=A0 =C2=A0 =C2=A0 if (xor_chan->completed_cookie < desc->async_tx.co=
okie)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan->completed_co=
okie =3D desc->async_tx.cookie;
> +
> + =C2=A0 =C2=A0 =C2=A0 callback =3D desc->async_tx.callback;
> + =C2=A0 =C2=A0 =C2=A0 callback_param =3D desc->async_tx.callback_param;
> + =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node);
> + =C2=A0 =C2=A0 =C2=A0 list_add_tail(&desc->node, &xor_chan->free_desc);
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&xor_chan->desc_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (callback)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callback(callback_para=
m);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* run dependent operations */
> + =C2=A0 =C2=A0 =C2=A0 dma_run_dependencies(&desc->async_tx);
> +}
> +
> +static void talitos_process_pending(struct talitos_xor_chan *xor_chan)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc, *_desc;
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_bh(&xor_chan->desc_lock);
> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_safe(desc, _desc, &xor_chan->p=
ending_q, node) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (talitos_submit(xor=
_chan->dev, &desc->hwdesc,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0talitos_release_xor, desc) =
!=3D -EINPROGRESS)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add_tail(&desc->n=
ode, &xor_chan->in_progress_q);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&xor_chan->desc_lock);
> +}
> +
> +/**
> + * talitos_issue_pending - move the descriptors in submit
> + * queue to pending queue and submit them for processing
> + * @chan: DMA channel
> + */
> +static void talitos_issue_pending(struct dma_chan *chan)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(chan, struct talitos_xor=
_chan, common);
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_bh(&xor_chan->desc_lock);
> + =C2=A0 =C2=A0 =C2=A0 list_splice_tail_init(&xor_chan->submit_q,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&xor_chan->pending_q);
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&xor_chan->desc_lock);
> + =C2=A0 =C2=A0 =C2=A0 talitos_process_pending(xor_chan);
> +}
> +
> +static dma_cookie_t talitos_async_tx_submit(struct dma_async_tx_descript=
or *tx)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 dma_cookie_t cookie;
> +
> + =C2=A0 =C2=A0 =C2=A0 desc =3D container_of(tx, struct talitos_xor_desc,=
 async_tx);
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(tx->chan, struct talitos=
_xor_chan, common);
> +
> + =C2=A0 =C2=A0 =C2=A0 cookie =3D xor_chan->common.cookie + 1;
> + =C2=A0 =C2=A0 =C2=A0 if (cookie < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cookie =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 desc->async_tx.cookie =3D cookie;
> + =C2=A0 =C2=A0 =C2=A0 xor_chan->common.cookie =3D desc->async_tx.cookie;
> +
> + =C2=A0 =C2=A0 =C2=A0 list_splice_tail_init(&desc->tx_list,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&xor_chan->submit_q);
> +
> + =C2=A0 =C2=A0 =C2=A0 return cookie;
> +}
> +
> +static struct talitos_xor_desc *talitos_xor_alloc_descriptor(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan, gfp_t=
 flags)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc;
> +
> + =C2=A0 =C2=A0 =C2=A0 desc =3D kmalloc(sizeof(*desc), flags);
> + =C2=A0 =C2=A0 =C2=A0 if (desc) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan->total_desc++=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(desc, 0, sizeof=
(*desc));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_async_tx_descripto=
r_init(&desc->async_tx, &xor_chan->common);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->async_tx.tx_subm=
it =3D talitos_async_tx_submit;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&desc->=
node);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&desc->=
tx_list);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return desc;
> +}
> +
> +static void talitos_free_chan_resources(struct dma_chan *chan)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc, *_desc;
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(chan, struct talitos_xor=
_chan, common);
> +
> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_safe(desc, _desc, &xor_chan->s=
ubmit_q, node) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan->total_desc--=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(desc);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_safe(desc, _desc, &xor_chan->p=
ending_q, node) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan->total_desc--=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(desc);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_safe(desc, _desc, &xor_chan->i=
n_progress_q, node) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan->total_desc--=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(desc);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_safe(desc, _desc, &xor_chan->f=
ree_desc, node) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan->total_desc--=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(desc);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 BUG_ON(unlikely(xor_chan->total_desc)); /* Some de=
scriptor not freed? */
> +}
> +
> +static int talitos_alloc_chan_resources(struct dma_chan *chan)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc;
> + =C2=A0 =C2=A0 =C2=A0 LIST_HEAD(tmp_list);
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(chan, struct talitos_xor=
_chan, common);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!list_empty(&xor_chan->free_desc))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return xor_chan->total=
_desc;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* 256 initial descriptors */
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < 256; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc =3D talitos_xor_a=
lloc_descriptor(xor_chan, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!desc) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(xor_chan->common.device->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Only %d initial descriptors\n", i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add_tail(&desc->n=
ode, &tmp_list);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!i)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* At least one desc is allocated */
> + =C2=A0 =C2=A0 =C2=A0 list_splice_init(&tmp_list, &xor_chan->free_desc);
> +
> + =C2=A0 =C2=A0 =C2=A0 return xor_chan->total_desc;
> +}
> +
> +static struct dma_async_tx_descriptor * talitos_prep_dma_xor(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 unsigned int src_cnt, size_t len, unsigned long flags)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *new;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_desc *desc;
> + =C2=A0 =C2=A0 =C2=A0 int i, j;
> +
> + =C2=A0 =C2=A0 =C2=A0 BUG_ON(unlikely(len > TALITOS_MAX_DATA_LEN));
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(chan, struct talitos_xor=
_chan, common);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!list_empty(&xor_chan->free_desc)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new =3D container_of(x=
or_chan->free_desc.next,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct talitos_xor_desc, no=
de);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&new->node);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new =3D talitos_xor_al=
loc_descriptor(xor_chan, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!new) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(xor_chan->comm=
on.device->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "No free memory for XOR DMA descriptor\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 desc =3D &new->hwdesc;
> + =C2=A0 =C2=A0 =C2=A0 /* Set destination: Last pointer pair */
> + =C2=A0 =C2=A0 =C2=A0 to_talitos_ptr(&desc->ptr[6], dest);
> + =C2=A0 =C2=A0 =C2=A0 desc->ptr[6].len =3D cpu_to_be16(len);
> + =C2=A0 =C2=A0 =C2=A0 desc->ptr[6].j_extent =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Set Sources: End loading from second-last point=
er pair */
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 5, j =3D 0; (j < src_cnt) && (i > 0); i=
--, j++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to_talitos_ptr(&desc->=
ptr[i], src[j]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].len =3D c=
pu_to_be16(len);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].j_extent =
=3D 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* documentation states first 0 ptr/len combo=
 marks end of sources
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* yet device produces scatter boundary error=
 unless all subsequent
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* sources are zeroed out
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 for (; i >=3D 0; i--) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to_talitos_ptr(&desc->=
ptr[i], 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].len =3D 0=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].j_extent =
=3D 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 desc->hdr =3D DESC_HDR_SEL0_AESU | DESC_HDR_MODE0_=
AESU_XOR
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | DESC_H=
DR_TYPE_RAID_XOR;
> +
> + =C2=A0 =C2=A0 =C2=A0 list_add_tail(&new->node, &new->tx_list);
> +
> + =C2=A0 =C2=A0 =C2=A0 new->async_tx.flags =3D flags;
> + =C2=A0 =C2=A0 =C2=A0 new->async_tx.cookie =3D -EBUSY;
> +
> + =C2=A0 =C2=A0 =C2=A0 return &new->async_tx;
> +}
> +
> +static void talitos_unregister_async_xor(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_private *priv =3D dev_get_drvdata(d=
ev);
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 struct dma_chan *chan;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (priv->dma_dev_common.chancnt)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_async_device_unreg=
ister(&priv->dma_dev_common);
> +
> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(chan, &priv->dma_dev_common.ch=
annels, device_node) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container=
_of(chan, struct talitos_xor_chan, common);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&chan->device=
_node);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priv->dma_dev_common.c=
hancnt--;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(xor_chan);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +/**
> + * talitos_register_dma_async - Initialize the Freescale XOR ADMA device
> + * It is registered as a DMA device with the capability to perform
> + * XOR operation with the Async_tx layer.
> + * The various queues and channel resources are also allocated.
> + */
> +static int talitos_register_async_tx(struct device *dev, int max_xor_src=
s)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_private *priv =3D dev_get_drvdata(d=
ev);
> + =C2=A0 =C2=A0 =C2=A0 struct dma_device *dma_dev =3D &priv->dma_dev_comm=
on;
> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D kzalloc(sizeof(struct talitos_xor_cha=
n), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!xor_chan) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "unable t=
o allocate xor channel\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->dev =3D dev;
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->device_alloc_chan_resources =3D talitos_a=
lloc_chan_resources;
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->device_free_chan_resources =3D talitos_fr=
ee_chan_resources;
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->device_prep_dma_xor =3D talitos_prep_dma_=
xor;
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->max_xor =3D max_xor_srcs;
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->device_is_tx_complete =3D talitos_is_tx_c=
omplete;
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->device_issue_pending =3D talitos_issue_pe=
nding;
> + =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&dma_dev->channels);
> + =C2=A0 =C2=A0 =C2=A0 dma_cap_set(DMA_XOR, dma_dev->cap_mask);
> +
> + =C2=A0 =C2=A0 =C2=A0 xor_chan->dev =3D dev;
> + =C2=A0 =C2=A0 =C2=A0 xor_chan->common.device =3D dma_dev;
> + =C2=A0 =C2=A0 =C2=A0 xor_chan->total_desc =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&xor_chan->submit_q);
> + =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&xor_chan->pending_q);
> + =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&xor_chan->in_progress_q);
> + =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&xor_chan->free_desc);
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&xor_chan->desc_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 list_add_tail(&xor_chan->common.device_node, &dma_=
dev->channels);
> + =C2=A0 =C2=A0 =C2=A0 dma_dev->chancnt++;
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D dma_async_device_register(dma_dev);
> + =C2=A0 =C2=A0 =C2=A0 if (err) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Unable t=
o register XOR with Async_tx\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +
> +err_out:
> + =C2=A0 =C2=A0 =C2=A0 talitos_unregister_async_xor(dev);
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +#endif /* CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR */
> =C2=A0/*
> =C2=A0* crypto alg
> =C2=A0*/
> @@ -1768,6 +2143,10 @@ static int talitos_remove(struct of_device *ofdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tasklet_kill(&priv->done_task);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(priv->reg);
> +#ifdef CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR
> + =C2=A0 =C2=A0 =C2=A0 if (priv->dma_dev_common.chancnt)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 talitos_unregister_asy=
nc_xor(dev);
> +#endif /* CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_set_drvdata(dev, NULL);
>
> @@ -1926,6 +2305,27 @@ static int talitos_probe(struct of_device *ofdev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(dev, "hwrng\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> +#ifdef CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* register with async_tx xor, if capable
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* SEC 2.x support up to 3 RAID sources,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* SEC 3.x support up to 6
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (hw_supports(dev, DESC_HDR_SEL0_AESU | DESC_HDR=
_TYPE_RAID_XOR)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int max_xor_srcs =3D 3=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (of_device_is_compa=
tible(np, "fsl,sec3.0"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 max_xor_srcs =3D 6;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D talitos_regist=
er_async_tx(dev, max_xor_srcs);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(dev, "failed to register async_tx xor: %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto err_out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(dev, "max_xor=
_srcs %d\n", max_xor_srcs);
> + =C2=A0 =C2=A0 =C2=A0 }
> +#endif /* CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR */
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* register crypto algorithms the device suppo=
rts */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < ARRAY_SIZE(driver_algs); i++=
) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hw_supports(de=
v, driver_algs[i].desc_hdr_template)) {
> diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
> index ff5a145..b6197bc 100644
> --- a/drivers/crypto/talitos.h
> +++ b/drivers/crypto/talitos.h
> @@ -155,6 +155,7 @@
> =C2=A0/* primary execution unit mode (MODE0) and derivatives */
> =C2=A0#define =C2=A0 =C2=A0 =C2=A0 =C2=A0DESC_HDR_MODE0_ENCRYPT =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_to_be32(0x00100000)
> =C2=A0#define =C2=A0 =C2=A0 =C2=A0 =C2=A0DESC_HDR_MODE0_AESU_CBC =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 cpu_to_be32(0x00200000)
> +#define =C2=A0 =C2=A0 =C2=A0 =C2=A0DESC_HDR_MODE0_AESU_XOR =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_to_be32(0x0c600000)
> =C2=A0#define =C2=A0 =C2=A0 =C2=A0 =C2=A0DESC_HDR_MODE0_DEU_CBC =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_to_be32(0x00400000)
> =C2=A0#define =C2=A0 =C2=A0 =C2=A0 =C2=A0DESC_HDR_MODE0_DEU_3DES =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 cpu_to_be32(0x00200000)
> =C2=A0#define =C2=A0 =C2=A0 =C2=A0 =C2=A0DESC_HDR_MODE0_MDEU_INIT =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cpu_to_be32(0x01000000)
> @@ -202,6 +203,7 @@
> =C2=A0#define DESC_HDR_TYPE_IPSEC_ESP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_to_be32(1 << 3)
> =C2=A0#define DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU =C2=A0cpu_to_be32(2 <=
< 3)
> =C2=A0#define DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU =C2=A0 =C2=A0 =C2=A0 cpu_t=
o_be32(4 << 3)
> +#define DESC_HDR_TYPE_RAID_XOR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cpu_to_be32(21 << 3)
>
> =C2=A0/* link table extent field bits */
> =C2=A0#define DESC_PTR_LNKTBL_JUMP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x80
> --
> 1.6.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>



--=20
The simplest is not all best but the best is surely the simplest!
