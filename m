Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9887DDF78
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 06:07:27 +1100 (EST)
Date: Wed, 10 Dec 2008 22:07:18 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <724394867.20081210220718@emcraft.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re[2]: [PATCH] ASYNC_TX: async_xor mapping fix
In-Reply-To: <1228934826.1224.5.camel@dwillia2-linux.ch.intel.com>
References: <200812082214.26811.yur@emcraft.com>
	<1228770496.26373.3.camel@dwillia2-linux.ch.intel.com>
	<1228934826.1224.5.camel@dwillia2-linux.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: "wd@denx.de" <wd@denx.de>, "dzu@denx.de" <dzu@denx.de>,
	Saeed Bishara <saeed@marvell.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Dan,

On Wednesday, December 10, 2008 you wrote:

> On Mon, 2008-12-08 at 14:08 -0700, Dan Williams wrote:
>> On Mon, 2008-12-08 at 12:14 -0700, Yuri Tikhonov wrote:
>> > The destination address may be present in the source list, so we should
>> > map the addresses from the source list first.
>> >  Otherwise, if page corresponding to destination is not marked as writ=
e-
>> > through (with regards to CPU cache), then mapping it with DMA_FROM_DEV=
ICE
>> > may lead to data loss, and finally to an incorrect result of calculati=
ons.
>> >=20
>>=20
>> Thanks Yuri.  I think we should avoid mapping the destination twice
>> altogether, and for simplicity just always map it bidirectionally.

> Yuri, Saeed, can I get your acked-by's for the following 2.6.28 patch:

 I would do the "src_list[i] =3D=3D dest" check with unlikely(), since we=
=20
a-priori aware that only one of all src_cnt addresses is the possible=20
destination.

 As for the rest:

Acked-by: Yuri Tikhonov <yur@emcraft.com>

> Thanks,
> Dan


----snip---->>
> async_xor: dma_map destination DMA_BIDIRECTIONAL

> From: Dan Williams <dan.j.williams@intel.com>

> Mapping the destination multiple times is a misuse of the dma-api.
> Since the destination may be reused as a source, ensure that it is only
> mapped once and that it is mapped bidirectionally.  This appears to add
> ugliness on the unmap side in that it always reads back the destination
> address from the descriptor, but gcc can determine that dma_unmap is a
> nop and not emit the code that calculates its arguments.

> Cc: <stable@kernel.org>
> Cc: Saeed Bishara <saeed@marvell.com>
> Reported-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  crypto/async_tx/async_xor.c |   11 +++++++++--
>  drivers/dma/iop-adma.c      |   16 +++++++++++++---
>  drivers/dma/mv_xor.c        |   15 ++++++++++++---
>  3 files changed, 34 insertions(+), 8 deletions(-)

> diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
> index c029d3e..a6faa90 100644
> --- a/crypto/async_tx/async_xor.c
> +++ b/crypto/async_tx/async_xor.c
> @@ -53,10 +53,17 @@ do_async_xor(struct dma_chan *chan, struct page *dest=
, struct page **src_list,
>         int xor_src_cnt;
>         dma_addr_t dma_dest;
> =20
> -       dma_dest =3D dma_map_page(dma->dev, dest, offset, len, DMA_FROM_D=
EVICE);
> -       for (i =3D 0; i < src_cnt; i++)
> +       /* map the dest bidrectional in case it is re-used as a source */
> +       dma_dest =3D dma_map_page(dma->dev, dest, offset, len, DMA_BIDIRE=
CTIONAL);
> +       for (i =3D 0; i < src_cnt; i++) {
> +               /* only map the dest once */
> +               if (src_list[i] =3D=3D dest) {
> +                       dma_src[i] =3D dma_dest;
> +                       continue;
> +               }
>                 dma_src[i] =3D dma_map_page(dma->dev, src_list[i], offset,
>                                           len, DMA_TO_DEVICE);
> +       }
> =20
>         while (src_cnt) {
>                 async_flags =3D flags;
> diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
> index c7a9306..6be3172 100644
> --- a/drivers/dma/iop-adma.c
> +++ b/drivers/dma/iop-adma.c
> @@ -85,18 +85,28 @@ iop_adma_run_tx_complete_actions(struct iop_adma_desc=
_slot *desc,
>                         enum dma_ctrl_flags flags =3D desc->async_tx.flag=
s;
>                         u32 src_cnt;
>                         dma_addr_t addr;
> +                       dma_addr_t dest;
> =20
> +                       src_cnt =3D unmap->unmap_src_cnt;
> +                       dest =3D iop_desc_get_dest_addr(unmap, iop_chan);
>                         if (!(flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
> -                               addr =3D
> iop_desc_get_dest_addr(unmap, iop_chan);
> -                               dma_unmap_page(dev, addr, len, DMA_FROM_D=
EVICE);
> +                               enum dma_data_direction dir;
> +
> +                               if (src_cnt > 1) /* is xor? */
> +                                       dir =3D DMA_BIDIRECTIONAL;
> +                               else
> +                                       dir =3D DMA_FROM_DEVICE;
> +
> +                               dma_unmap_page(dev, dest, len, dir);
>                         }
> =20
>                         if (!(flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
> -                               src_cnt =3D unmap->unmap_src_cnt;
>                                 while (src_cnt--) {
>                                         addr =3D iop_desc_get_src_addr(un=
map,
>                                                                     iop_c=
han,
>                                                                     src_c=
nt);
> +                                       if (addr =3D=3D dest)
> +                                               continue;
>                                         dma_unmap_page(dev, addr, len,
>                                                        DMA_TO_DEVICE);
>                                 }
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 0328da0..bcda174 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -311,17 +311,26 @@ mv_xor_run_tx_complete_actions(struct mv_xor_desc_s=
lot *desc,
>                         enum dma_ctrl_flags flags =3D desc->async_tx.flag=
s;
>                         u32 src_cnt;
>                         dma_addr_t addr;
> +                       dma_addr_t dest;
> =20
> +                       src_cnt =3D unmap->unmap_src_cnt;
> +                       dest =3D mv_desc_get_dest_addr(unmap);
>                         if (!(flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
> -                               addr =3D mv_desc_get_dest_addr(unmap);
> -                               dma_unmap_page(dev, addr, len, DMA_FROM_D=
EVICE);
> +                               enum dma_data_direction dir;
> +
> +                               if (src_cnt > 1) /* is xor ? */
> +                                       dir =3D DMA_BIDIRECTIONAL;
> +                               else
> +                                       dir =3D DMA_FROM_DEVICE;
> +                               dma_unmap_page(dev, dest, len, dir);
>                         }
> =20
>                         if (!(flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
> -                               src_cnt =3D unmap->unmap_src_cnt;
>                                 while (src_cnt--) {
>                                         addr =3D mv_desc_get_src_addr(unm=
ap,
>                                                                     src_c=
nt);
> +                                       if (addr =3D=3D dest)
> +                                               continue;
>                                         dma_unmap_page(dev, addr, len,
>                                                        DMA_TO_DEVICE);
>                                 }





 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
