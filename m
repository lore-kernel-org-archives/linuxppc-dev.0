Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 93230B7D68
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 13:45:00 +1100 (EST)
Received: by yxe11 with SMTP id 11so785669yxe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 18:44:59 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265377377-29327-7-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-7-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 19:44:39 -0700
Message-ID: <fa686aa41002091844k3303feecm57e730e7fe22cffe@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] dma: Add MPC512x DMA driver
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 6:42 AM, Anatolij Gustschin <agust@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>
> Adds initial version of MPC512x DMA driver.
> Only memory to memory transfers are currenly supported.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

on brief review...

Acked-by: Grant Likely <grant.likely@secretlab.ca>



> ---
> No changes since v2
>
> Changes since v1:
> =A0- move content of the mpc512x.h into the drivers .c file as
> =A0 it is only used by this DMA driver
> =A0- use __devinit/__devexit/__devexit_p as requested
> =A0- add unregistration of the dma device
> =A0- remove meaningless comment
>
> Changes since patch version submitted in May 2009:
> =A0- don't use wildcards in compatible property, use "fsl,mpc5121-dma"
> =A0- don't add "fsl,mpc5121-dma" compatible to of_bus_ids[] as the
> =A0 dma device is part of IMMR
>
> =A0drivers/dma/Kconfig =A0 =A0 =A0 | =A0 =A07 +
> =A0drivers/dma/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/dma/mpc512x_dma.c | =A0800 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 808 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/dma/mpc512x_dma.c
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index e02d74b..ac67a53 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -69,6 +69,13 @@ config FSL_DMA
> =A0 =A0 =A0 =A0 =A0The Elo is the DMA controller on some 82xx and 83xx pa=
rts, and the
> =A0 =A0 =A0 =A0 =A0Elo Plus is the DMA controller on 85xx and 86xx parts.
>
> +config MPC512X_DMA
> + =A0 =A0 =A0 tristate "Freescale MPC512x built-in DMA engine support"
> + =A0 =A0 =A0 depends on PPC_MPC512x
> + =A0 =A0 =A0 select DMA_ENGINE
> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 =A0 Enable support for the Freescale MPC512x built-in DMA e=
ngine.
> +
> =A0config MV_XOR
> =A0 =A0 =A0 =A0bool "Marvell XOR engine support"
> =A0 =A0 =A0 =A0depends on PLAT_ORION
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 807053d..4696bcf 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_DMATEST) +=3D dmatest.o
> =A0obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
> =A0obj-$(CONFIG_INTEL_IOP_ADMA) +=3D iop-adma.o
> =A0obj-$(CONFIG_FSL_DMA) +=3D fsldma.o
> +obj-$(CONFIG_MPC512X_DMA) +=3D mpc512x_dma.o
> =A0obj-$(CONFIG_MV_XOR) +=3D mv_xor.o
> =A0obj-$(CONFIG_DW_DMAC) +=3D dw_dmac.o
> =A0obj-$(CONFIG_AT_HDMAC) +=3D at_hdmac.o
> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> new file mode 100644
> index 0000000..3fdf1f4
> --- /dev/null
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -0,0 +1,800 @@
> +/*
> + * Copyright (C) Freescale Semicondutor, Inc. 2007, 2008.
> + * Copyright (C) Semihalf 2009
> + *
> + * Written by Piotr Ziecik <kosmo@semihalf.com>. Hardware description
> + * (defines, structures and comments) was taken from MPC5121 DMA driver
> + * written by Hongjun Chen <hong-jun.chen@freescale.com>.
> + *
> + * Approved as OSADL project by a majority of OSADL members and funded
> + * by OSADL membership fees in 2009; =A0for details see www.osadl.org.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the=
 Free
> + * Software Foundation; either version 2 of the License, or (at your opt=
ion)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program; if not, write to the Free Software Foundation, Inc., 59
> + * Temple Place - Suite 330, Boston, MA =A002111-1307, USA.
> + *
> + * The full GNU General Public License is included in this distribution =
in the
> + * file called COPYING.
> + */
> +
> +/*
> + * This is initial version of MPC5121 DMA driver. Only memory to memory
> + * transfers are supported (tested using dmatest module).
> + */
> +
> +#include <linux/module.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +
> +#include <linux/random.h>
> +
> +/* Number of DMA Transfer descriptors allocated per channel */
> +#define MPC_DMA_DESCRIPTORS =A0 =A064
> +
> +/* Macro definitions */
> +#define MPC_DMA_CHANNELS =A0 =A0 =A0 64
> +#define MPC_DMA_TCD_OFFSET =A0 =A0 0x1000
> +
> +/* Arbitration mode of group and channel */
> +#define MPC_DMA_DMACR_EDCG =A0 =A0 (1 << 31)
> +#define MPC_DMA_DMACR_ERGA =A0 =A0 (1 << 3)
> +#define MPC_DMA_DMACR_ERCA =A0 =A0 (1 << 2)
> +
> +/* Error codes */
> +#define MPC_DMA_DMAES_VLD =A0 =A0 =A0(1 << 31)
> +#define MPC_DMA_DMAES_GPE =A0 =A0 =A0(1 << 15)
> +#define MPC_DMA_DMAES_CPE =A0 =A0 =A0(1 << 14)
> +#define MPC_DMA_DMAES_ERRCHN(err) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((err) >> =
8) & 0x3f)
> +#define MPC_DMA_DMAES_SAE =A0 =A0 =A0(1 << 7)
> +#define MPC_DMA_DMAES_SOE =A0 =A0 =A0(1 << 6)
> +#define MPC_DMA_DMAES_DAE =A0 =A0 =A0(1 << 5)
> +#define MPC_DMA_DMAES_DOE =A0 =A0 =A0(1 << 4)
> +#define MPC_DMA_DMAES_NCE =A0 =A0 =A0(1 << 3)
> +#define MPC_DMA_DMAES_SGE =A0 =A0 =A0(1 << 2)
> +#define MPC_DMA_DMAES_SBE =A0 =A0 =A0(1 << 1)
> +#define MPC_DMA_DMAES_DBE =A0 =A0 =A0(1 << 0)
> +
> +#define MPC_DMA_TSIZE_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
> +#define MPC_DMA_TSIZE_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> +#define MPC_DMA_TSIZE_4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02
> +#define MPC_DMA_TSIZE_16 =A0 =A0 =A0 0x04
> +#define MPC_DMA_TSIZE_32 =A0 =A0 =A0 0x05
> +
> +/* MPC5121 DMA engine registers */
> +struct __attribute__ ((__packed__)) mpc_dma_regs {
> + =A0 =A0 =A0 /* 0x00 */
> + =A0 =A0 =A0 u32 dmacr; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DMA control regist=
er */
> + =A0 =A0 =A0 u32 dmaes; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DMA error status *=
/
> + =A0 =A0 =A0 /* 0x08 */
> + =A0 =A0 =A0 u32 dmaerqh; =A0 =A0 =A0 =A0 =A0 =A0/* DMA enable request h=
igh(channels 63~32) */
> + =A0 =A0 =A0 u32 dmaerql; =A0 =A0 =A0 =A0 =A0 =A0/* DMA enable request l=
ow(channels 31~0) */
> + =A0 =A0 =A0 u32 dmaeeih; =A0 =A0 =A0 =A0 =A0 =A0/* DMA enable error int=
errupt high(ch63~32) */
> + =A0 =A0 =A0 u32 dmaeeil; =A0 =A0 =A0 =A0 =A0 =A0/* DMA enable error int=
errupt low(ch31~0) */
> + =A0 =A0 =A0 /* 0x18 */
> + =A0 =A0 =A0 u8 dmaserq; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA set enable reque=
st */
> + =A0 =A0 =A0 u8 dmacerq; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA clear enable req=
uest */
> + =A0 =A0 =A0 u8 dmaseei; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA set enable error=
 interrupt */
> + =A0 =A0 =A0 u8 dmaceei; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA clear enable err=
or interrupt */
> + =A0 =A0 =A0 /* 0x1c */
> + =A0 =A0 =A0 u8 dmacint; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA clear interrupt =
request */
> + =A0 =A0 =A0 u8 dmacerr; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA clear error */
> + =A0 =A0 =A0 u8 dmassrt; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA set start bit */
> + =A0 =A0 =A0 u8 dmacdne; =A0 =A0 =A0 =A0 =A0 =A0 /* DMA clear DONE statu=
s bit */
> + =A0 =A0 =A0 /* 0x20 */
> + =A0 =A0 =A0 u32 dmainth; =A0 =A0 =A0 =A0 =A0 =A0/* DMA interrupt reques=
t high(ch63~32) */
> + =A0 =A0 =A0 u32 dmaintl; =A0 =A0 =A0 =A0 =A0 =A0/* DMA interrupt reques=
t low(ch31~0) */
> + =A0 =A0 =A0 u32 dmaerrh; =A0 =A0 =A0 =A0 =A0 =A0/* DMA error high(ch63~=
32) */
> + =A0 =A0 =A0 u32 dmaerrl; =A0 =A0 =A0 =A0 =A0 =A0/* DMA error low(ch31~0=
) */
> + =A0 =A0 =A0 /* 0x30 */
> + =A0 =A0 =A0 u32 dmahrsh; =A0 =A0 =A0 =A0 =A0 =A0/* DMA hw request statu=
s high(ch63~32) */
> + =A0 =A0 =A0 u32 dmahrsl; =A0 =A0 =A0 =A0 =A0 =A0/* DMA hardware request=
 status low(ch31~0) */
> + =A0 =A0 =A0 u32 dmaihsa; =A0 =A0 =A0 =A0 =A0 =A0/* DMA interrupt high s=
elect AXE(ch63~32) */
> + =A0 =A0 =A0 u32 dmailsa; =A0 =A0 =A0 =A0 =A0 =A0/* DMA interrupt low se=
lect AXE(ch31~0) */
> + =A0 =A0 =A0 /* 0x40 ~ 0xff */
> + =A0 =A0 =A0 u32 reserve0[48]; =A0 =A0 =A0 /* Reserved */
> + =A0 =A0 =A0 /* 0x100 */
> + =A0 =A0 =A0 u8 dchpri[MPC_DMA_CHANNELS];
> + =A0 =A0 =A0 /* DMA channels(0~63) priority */
> +};
> +
> +struct __attribute__ ((__packed__)) mpc_dma_tcd {
> + =A0 =A0 =A0 /* 0x00 */
> + =A0 =A0 =A0 u32 saddr; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Source address */
> +
> + =A0 =A0 =A0 u32 smod:5; =A0 =A0 =A0 =A0 =A0 =A0 /* Source address modul=
o */
> + =A0 =A0 =A0 u32 ssize:3; =A0 =A0 =A0 =A0 =A0 =A0/* Source data transfer=
 size */
> + =A0 =A0 =A0 u32 dmod:5; =A0 =A0 =A0 =A0 =A0 =A0 /* Destination address =
modulo */
> + =A0 =A0 =A0 u32 dsize:3; =A0 =A0 =A0 =A0 =A0 =A0/* Destination data tra=
nsfer size */
> + =A0 =A0 =A0 u32 soff:16; =A0 =A0 =A0 =A0 =A0 =A0/* Signed source addres=
s offset */
> +
> + =A0 =A0 =A0 /* 0x08 */
> + =A0 =A0 =A0 u32 nbytes; =A0 =A0 =A0 =A0 =A0 =A0 /* Inner "minor" byte c=
ount */
> + =A0 =A0 =A0 u32 slast; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Last source addres=
s adjustment */
> + =A0 =A0 =A0 u32 daddr; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Destination addres=
s */
> +
> + =A0 =A0 =A0 /* 0x14 */
> + =A0 =A0 =A0 u32 citer_elink:1; =A0 =A0 =A0/* Enable channel-to-channel =
linking on
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* minor =
loop complete
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u32 citer_linkch:6; =A0 =A0 /* Link channel for minor loop =
complete */
> + =A0 =A0 =A0 u32 citer:9; =A0 =A0 =A0 =A0 =A0 =A0/* Current "major" iter=
ation count */
> + =A0 =A0 =A0 u32 doff:16; =A0 =A0 =A0 =A0 =A0 =A0/* Signed destination a=
ddress offset */
> +
> + =A0 =A0 =A0 /* 0x18 */
> + =A0 =A0 =A0 u32 dlast_sga; =A0 =A0 =A0 =A0 =A0/* Last Destination addre=
ss adjustment/scatter
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* gather=
 address
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* 0x1c */
> + =A0 =A0 =A0 u32 biter_elink:1; =A0 =A0 =A0/* Enable channel-to-channel =
linking on major
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* loop c=
omplete
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u32 biter_linkch:6;
> + =A0 =A0 =A0 u32 biter:9; =A0 =A0 =A0 =A0 =A0 =A0/* Beginning "major" it=
eration count */
> + =A0 =A0 =A0 u32 bwc:2; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Bandwidth control =
*/
> + =A0 =A0 =A0 u32 major_linkch:6; =A0 =A0 /* Link channel number */
> + =A0 =A0 =A0 u32 done:1; =A0 =A0 =A0 =A0 =A0 =A0 /* Channel done */
> + =A0 =A0 =A0 u32 active:1; =A0 =A0 =A0 =A0 =A0 /* Channel active */
> + =A0 =A0 =A0 u32 major_elink:1; =A0 =A0 =A0/* Enable channel-to-channel =
linking on major
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* loop c=
omplete
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u32 e_sg:1; =A0 =A0 =A0 =A0 =A0 =A0 /* Enable scatter/gathe=
r processing */
> + =A0 =A0 =A0 u32 d_req:1; =A0 =A0 =A0 =A0 =A0 =A0/* Disable request */
> + =A0 =A0 =A0 u32 int_half:1; =A0 =A0 =A0 =A0 /* Enable an interrupt when=
 major counter is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* half c=
omplete
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u32 int_maj:1; =A0 =A0 =A0 =A0 =A0/* Enable an interrupt wh=
en major iteration
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* count =
completes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u32 start:1; =A0 =A0 =A0 =A0 =A0 =A0/* Channel start */
> +};
> +
> +struct mpc_dma_desc {
> + =A0 =A0 =A0 struct dma_async_tx_descriptor =A0desc;
> + =A0 =A0 =A0 struct mpc_dma_tcd =A0 =A0 =A0 =A0 =A0 =A0 =A0*tcd;
> + =A0 =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tcd_p=
addr;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 error;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node;
> +};
> +
> +struct mpc_dma_chan {
> + =A0 =A0 =A0 struct dma_chan =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chan;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prepared;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queued;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0active;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0completed;
> + =A0 =A0 =A0 struct mpc_dma_tcd =A0 =A0 =A0 =A0 =A0 =A0 =A0*tcd;
> + =A0 =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tcd_p=
addr;
> + =A0 =A0 =A0 dma_cookie_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0complet=
ed_cookie;
> +
> + =A0 =A0 =A0 /* Lock for this structure */
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> +};
> +
> +struct mpc_dma {
> + =A0 =A0 =A0 struct dma_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma;
> + =A0 =A0 =A0 struct tasklet_struct =A0 =A0 =A0 =A0 =A0 tasklet;
> + =A0 =A0 =A0 struct mpc_dma_chan =A0 =A0 =A0 =A0 =A0 =A0 channels[MPC_DM=
A_CHANNELS];
> + =A0 =A0 =A0 struct mpc_dma_regs __iomem =A0 =A0 *regs;
> + =A0 =A0 =A0 struct mpc_dma_tcd __iomem =A0 =A0 =A0*tcd;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 irq;
> + =A0 =A0 =A0 uint =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0error_status;
> +
> + =A0 =A0 =A0 /* Lock for error_status field in this structure */
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error=
_status_lock;
> +};
> +
> +#define DRV_NAME =A0 =A0 =A0 "mpc512x_dma"
> +
> +/* Convert struct dma_chan to struct mpc_dma_chan */
> +static inline struct mpc_dma_chan *dma_chan_to_mpc_dma_chan(struct dma_c=
han *c)
> +{
> + =A0 =A0 =A0 return container_of(c, struct mpc_dma_chan, chan);
> +}
> +
> +/* Convert struct dma_chan to struct mpc_dma */
> +static inline struct mpc_dma *dma_chan_to_mpc_dma(struct dma_chan *c)
> +{
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan =3D dma_chan_to_mpc_dma_chan(c);
> + =A0 =A0 =A0 return container_of(mchan, struct mpc_dma, channels[c->chan=
_id]);
> +}
> +
> +/*
> + * Execute all queued DMA descriptors.
> + *
> + * Following requirements must be met while calling mpc_dma_execute():
> + * =A0 =A0 a) mchan->lock is acquired,
> + * =A0 =A0 b) mchan->active list is empty,
> + * =A0 =A0 c) mchan->queued list contains at least one entry.
> + */
> +static void mpc_dma_execute(struct mpc_dma_chan *mchan)
> +{
> + =A0 =A0 =A0 struct mpc_dma *mdma =3D dma_chan_to_mpc_dma(&mchan->chan);
> + =A0 =A0 =A0 struct mpc_dma_desc *first =3D NULL;
> + =A0 =A0 =A0 struct mpc_dma_desc *prev =3D NULL;
> + =A0 =A0 =A0 struct mpc_dma_desc *mdesc;
> + =A0 =A0 =A0 int cid =3D mchan->chan.chan_id;
> +
> + =A0 =A0 =A0 /* Move all queued descriptors to active list */
> + =A0 =A0 =A0 list_splice_tail_init(&mchan->queued, &mchan->active);
> +
> + =A0 =A0 =A0 /* Chain descriptors into one transaction */
> + =A0 =A0 =A0 list_for_each_entry(mdesc, &mchan->active, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!first)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 first =3D mdesc;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!prev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev =3D mdesc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev->tcd->dlast_sga =3D mdesc->tcd_paddr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev->tcd->e_sg =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc->tcd->start =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev =3D mdesc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 prev->tcd->start =3D 0;
> + =A0 =A0 =A0 prev->tcd->int_maj =3D 1;
> +
> + =A0 =A0 =A0 /* Send first descriptor in chain into hardware */
> + =A0 =A0 =A0 memcpy_toio(&mdma->tcd[cid], first->tcd, sizeof(struct mpc_=
dma_tcd));
> + =A0 =A0 =A0 out_8(&mdma->regs->dmassrt, cid);
> +}
> +
> +/* Handle interrupt on one half of DMA controller (32 channels) */
> +static void mpc_dma_irq_process(struct mpc_dma *mdma, u32 is, u32 es, in=
t off)
> +{
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan;
> + =A0 =A0 =A0 struct mpc_dma_desc *mdesc;
> + =A0 =A0 =A0 u32 status =3D is | es;
> + =A0 =A0 =A0 int ch;
> +
> + =A0 =A0 =A0 while ((ch =3D fls(status) - 1) >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status &=3D ~(1 << ch);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan =3D &mdma->channels[ch + off];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mchan->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check error status */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & (1 << ch))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(mdesc, =
&mchan->active, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc->erro=
r =3D -EIO;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Execute queued descriptors */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_splice_tail_init(&mchan->active, &mcha=
n->completed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&mchan->queued))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_dma_execute(mchan);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mchan->lock);
> + =A0 =A0 =A0 }
> +}
> +
> +/* Interrupt handler */
> +static irqreturn_t mpc_dma_irq(int irq, void *data)
> +{
> + =A0 =A0 =A0 struct mpc_dma *mdma =3D data;
> + =A0 =A0 =A0 uint es;
> +
> + =A0 =A0 =A0 /* Save error status register */
> + =A0 =A0 =A0 es =3D in_be32(&mdma->regs->dmaes);
> + =A0 =A0 =A0 spin_lock(&mdma->error_status_lock);
> + =A0 =A0 =A0 if ((es & MPC_DMA_DMAES_VLD) && mdma->error_status =3D=3D 0=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdma->error_status =3D es;
> + =A0 =A0 =A0 spin_unlock(&mdma->error_status_lock);
> +
> + =A0 =A0 =A0 /* Handle interrupt on each channel */
> + =A0 =A0 =A0 mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmainth),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 in_be32(&mdma->regs->dmaerrh), 32);
> + =A0 =A0 =A0 mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmaintl),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 in_be32(&mdma->regs->dmaerrl), 0);
> +
> + =A0 =A0 =A0 /* Ack interrupt on all channels */
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmainth, 0xFFFFFFFF);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaintl, 0xFFFFFFFF);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaerrh, 0xFFFFFFFF);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaerrl, 0xFFFFFFFF);
> +
> + =A0 =A0 =A0 /* Schedule tasklet */
> + =A0 =A0 =A0 tasklet_schedule(&mdma->tasklet);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/* DMA Tasklet */
> +static void mpc_dma_tasklet(unsigned long data)
> +{
> + =A0 =A0 =A0 struct mpc_dma *mdma =3D (void *)data;
> + =A0 =A0 =A0 dma_cookie_t last_cookie =3D 0;
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan;
> + =A0 =A0 =A0 struct mpc_dma_desc *mdesc;
> + =A0 =A0 =A0 struct dma_async_tx_descriptor *desc;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 LIST_HEAD(list);
> + =A0 =A0 =A0 uint es;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&mdma->error_status_lock, flags);
> + =A0 =A0 =A0 es =3D mdma->error_status;
> + =A0 =A0 =A0 mdma->error_status =3D 0;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mdma->error_status_lock, flags);
> +
> + =A0 =A0 =A0 /* Print nice error report */
> + =A0 =A0 =A0 if (es) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Hardware reported followin=
g error(s) on channel %u:\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC_DMA_DMAES_ERRCHN(es));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_GPE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- G=
roup Priority Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_CPE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- C=
hannel Priority Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_SAE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- S=
ource Address Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_SOE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- S=
ource Offset"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 " Configuration Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_DAE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- D=
estination Address"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_DOE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- D=
estination Offset"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 " Configuration Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_NCE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- N=
Bytes/Citter"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 " Configuration Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_SGE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- S=
catter/Gather"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 " Configuration Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_SBE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- S=
ource Bus Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es & MPC_DMA_DMAES_DBE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mdma->dma.dev, "- D=
estination Bus Error\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < mdma->dma.chancnt; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan =3D &mdma->channels[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get all completed descriptors */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&mchan->completed))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_splice_tail_init(&mcha=
n->completed, &list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, flags)=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&list))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Execute callbacks and run dependencies *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(mdesc, &list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D &mdesc->desc;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->callback)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->callb=
ack(desc->callback_param);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_cookie =3D desc->cooki=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_run_dependencies(desc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free descriptors */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_splice_tail_init(&list, &mchan->free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan->completed_cookie =3D last_cookie;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, flags)=
;
> + =A0 =A0 =A0 }
> +}
> +
> +/* Submit descriptor to hardware */
> +static dma_cookie_t mpc_dma_tx_submit(struct dma_async_tx_descriptor *tx=
d)
> +{
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan =3D dma_chan_to_mpc_dma_chan(txd=
->chan);
> + =A0 =A0 =A0 struct mpc_dma_desc *mdesc;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 dma_cookie_t cookie;
> +
> + =A0 =A0 =A0 mdesc =3D container_of(txd, struct mpc_dma_desc, desc);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, flags);
> +
> + =A0 =A0 =A0 /* Move descriptor to queue */
> + =A0 =A0 =A0 list_move_tail(&mdesc->node, &mchan->queued);
> +
> + =A0 =A0 =A0 /* If channel is idle, execute all queued descriptors */
> + =A0 =A0 =A0 if (list_empty(&mchan->active))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_dma_execute(mchan);
> +
> + =A0 =A0 =A0 /* Update cookie */
> + =A0 =A0 =A0 cookie =3D mchan->chan.cookie + 1;
> + =A0 =A0 =A0 if (cookie <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cookie =3D 1;
> +
> + =A0 =A0 =A0 mchan->chan.cookie =3D cookie;
> + =A0 =A0 =A0 mdesc->desc.cookie =3D cookie;
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, flags);
> +
> + =A0 =A0 =A0 return cookie;
> +}
> +
> +/* Alloc channel resources */
> +static int mpc_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> + =A0 =A0 =A0 struct mpc_dma *mdma =3D dma_chan_to_mpc_dma(chan);
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan =3D dma_chan_to_mpc_dma_chan(cha=
n);
> + =A0 =A0 =A0 struct mpc_dma_desc *mdesc;
> + =A0 =A0 =A0 struct mpc_dma_tcd *tcd;
> + =A0 =A0 =A0 dma_addr_t tcd_paddr;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 LIST_HEAD(descs);
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /* Alloc DMA memory for Transfer Control Descriptors */
> + =A0 =A0 =A0 tcd =3D dma_alloc_coherent(mdma->dma.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC_DMA_DESCRIPTORS * sizeo=
f(struct mpc_dma_tcd),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &tcd_paddr, GFP_KERNEL);
> + =A0 =A0 =A0 if (!tcd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 /* Alloc descriptors for this channel */
> + =A0 =A0 =A0 for (i =3D 0; i < MPC_DMA_DESCRIPTORS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc =3D kzalloc(sizeof(struct mpc_dma_des=
c), GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mdesc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_notice(mdma->dma.dev, "=
Memory allocation error. "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "Allocated only %u descriptors\n", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_async_tx_descriptor_init(&mdesc->desc, =
chan);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc->desc.flags =3D DMA_CTRL_ACK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc->desc.tx_submit =3D mpc_dma_tx_submit=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc->tcd =3D &tcd[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc->tcd_paddr =3D tcd_paddr + (i * sizeo=
f(struct mpc_dma_tcd));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&mdesc->node, &descs);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Return error only if no descriptors were allocated */
> + =A0 =A0 =A0 if (i =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(mdma->dma.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC_DMA_DESCRIPTORS * sizeo=
f(struct mpc_dma_tcd),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd, tcd_paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, flags);
> + =A0 =A0 =A0 mchan->tcd =3D tcd;
> + =A0 =A0 =A0 mchan->tcd_paddr =3D tcd_paddr;
> + =A0 =A0 =A0 list_splice_tail_init(&descs, &mchan->free);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, flags);
> +
> + =A0 =A0 =A0 /* Enable Error Interrupt */
> + =A0 =A0 =A0 out_8(&mdma->regs->dmaseei, chan->chan_id);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Free channel resources */
> +static void mpc_dma_free_chan_resources(struct dma_chan *chan)
> +{
> + =A0 =A0 =A0 struct mpc_dma *mdma =3D dma_chan_to_mpc_dma(chan);
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan =3D dma_chan_to_mpc_dma_chan(cha=
n);
> + =A0 =A0 =A0 struct mpc_dma_desc *mdesc, *tmp;
> + =A0 =A0 =A0 struct mpc_dma_tcd *tcd;
> + =A0 =A0 =A0 dma_addr_t tcd_paddr;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 LIST_HEAD(descs);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, flags);
> +
> + =A0 =A0 =A0 /* Channel must be idle */
> + =A0 =A0 =A0 BUG_ON(!list_empty(&mchan->prepared));
> + =A0 =A0 =A0 BUG_ON(!list_empty(&mchan->queued));
> + =A0 =A0 =A0 BUG_ON(!list_empty(&mchan->active));
> + =A0 =A0 =A0 BUG_ON(!list_empty(&mchan->completed));
> +
> + =A0 =A0 =A0 /* Move data */
> + =A0 =A0 =A0 list_splice_tail_init(&mchan->free, &descs);
> + =A0 =A0 =A0 tcd =3D mchan->tcd;
> + =A0 =A0 =A0 tcd_paddr =3D mchan->tcd_paddr;
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, flags);
> +
> + =A0 =A0 =A0 /* Free DMA memory used by descriptors */
> + =A0 =A0 =A0 dma_free_coherent(mdma->dma.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC_DMA_DESCRIPTORS * sizeo=
f(struct mpc_dma_tcd),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd, tcd_paddr);
> +
> + =A0 =A0 =A0 /* Free descriptors */
> + =A0 =A0 =A0 list_for_each_entry_safe(mdesc, tmp, &descs, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(mdesc);
> +
> + =A0 =A0 =A0 /* Disable Error Interrupt */
> + =A0 =A0 =A0 out_8(&mdma->regs->dmaceei, chan->chan_id);
> +}
> +
> +/* Send all pending descriptor to hardware */
> +static void mpc_dma_issue_pending(struct dma_chan *chan)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We are posting descriptors to the hardware as soon as
> + =A0 =A0 =A0 =A0* they are ready, so this function does nothing.
> + =A0 =A0 =A0 =A0*/
> +}
> +
> +/* Check request completion status */
> +static enum dma_status
> +mpc_dma_is_tx_complete(struct dma_chan *chan, dma_cookie_t cookie,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dma_cookie_t *done, dma_cookie_t *used)
> +{
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan =3D dma_chan_to_mpc_dma_chan(cha=
n);
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 dma_cookie_t last_used;
> + =A0 =A0 =A0 dma_cookie_t last_complete;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, flags);
> + =A0 =A0 =A0 last_used =3D mchan->chan.cookie;
> + =A0 =A0 =A0 last_complete =3D mchan->completed_cookie;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, flags);
> +
> + =A0 =A0 =A0 if (done)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *done =3D last_complete;
> +
> + =A0 =A0 =A0 if (used)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *used =3D last_used;
> +
> + =A0 =A0 =A0 return dma_async_is_complete(cookie, last_complete, last_us=
ed);
> +}
> +
> +/* Prepare descriptor for memory to memory copy */
> +static struct dma_async_tx_descriptor *
> +mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t sr=
c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 size_t len, unsigned long flags)
> +{
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan =3D dma_chan_to_mpc_dma_chan(cha=
n);
> + =A0 =A0 =A0 struct mpc_dma_desc *mdesc =3D NULL;
> + =A0 =A0 =A0 struct mpc_dma_tcd *tcd;
> + =A0 =A0 =A0 unsigned long iflags;
> +
> + =A0 =A0 =A0 /* Get free descriptor */
> + =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, iflags);
> + =A0 =A0 =A0 if (!list_empty(&mchan->free)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdesc =3D list_first_entry(&mchan->free, st=
ruct mpc_dma_desc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&mdesc->node);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, iflags);
> +
> + =A0 =A0 =A0 if (!mdesc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 mdesc->error =3D 0;
> + =A0 =A0 =A0 tcd =3D mdesc->tcd;
> +
> + =A0 =A0 =A0 /* Prepare Transfer Control Descriptor for this transaction=
 */
> + =A0 =A0 =A0 memset(tcd, 0, sizeof(struct mpc_dma_tcd));
> +
> + =A0 =A0 =A0 if (IS_ALIGNED(src | dst | len, 32)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->ssize =3D MPC_DMA_TSIZE_32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->dsize =3D MPC_DMA_TSIZE_32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->soff =3D 32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->doff =3D 32;
> + =A0 =A0 =A0 } else if (IS_ALIGNED(src | dst | len, 16)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->ssize =3D MPC_DMA_TSIZE_16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->dsize =3D MPC_DMA_TSIZE_16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->soff =3D 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->doff =3D 16;
> + =A0 =A0 =A0 } else if (IS_ALIGNED(src | dst | len, 4)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->ssize =3D MPC_DMA_TSIZE_4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->dsize =3D MPC_DMA_TSIZE_4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->soff =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->doff =3D 4;
> + =A0 =A0 =A0 } else if (IS_ALIGNED(src | dst | len, 2)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->ssize =3D MPC_DMA_TSIZE_2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->dsize =3D MPC_DMA_TSIZE_2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->soff =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->doff =3D 2;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->ssize =3D MPC_DMA_TSIZE_1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->dsize =3D MPC_DMA_TSIZE_1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->soff =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tcd->doff =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tcd->saddr =3D src;
> + =A0 =A0 =A0 tcd->daddr =3D dst;
> + =A0 =A0 =A0 tcd->nbytes =3D len;
> + =A0 =A0 =A0 tcd->biter =3D 1;
> + =A0 =A0 =A0 tcd->citer =3D 1;
> +
> + =A0 =A0 =A0 /* Place descriptor in prepared list */
> + =A0 =A0 =A0 spin_lock_irqsave(&mchan->lock, iflags);
> + =A0 =A0 =A0 list_add_tail(&mdesc->node, &mchan->prepared);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mchan->lock, iflags);
> +
> + =A0 =A0 =A0 return &mdesc->desc;
> +}
> +
> +static int __devinit mpc_dma_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)
> +{
> + =A0 =A0 =A0 struct device_node *dn =3D op->node;
> + =A0 =A0 =A0 struct device *dev =3D &op->dev;
> + =A0 =A0 =A0 struct dma_device *dma;
> + =A0 =A0 =A0 struct mpc_dma *mdma;
> + =A0 =A0 =A0 struct mpc_dma_chan *mchan;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 ulong regs_start, regs_size;
> + =A0 =A0 =A0 int retval, i;
> +
> + =A0 =A0 =A0 mdma =3D devm_kzalloc(dev, sizeof(struct mpc_dma), GFP_KERN=
EL);
> + =A0 =A0 =A0 if (!mdma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory exhausted!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mdma->irq =3D irq_of_parse_and_map(dn, 0);
> + =A0 =A0 =A0 if (mdma->irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error mapping IRQ!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D of_address_to_resource(dn, 0, &res);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error parsing memory region!\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 regs_start =3D res.start;
> + =A0 =A0 =A0 regs_size =3D res.end - res.start + 1;
> +
> + =A0 =A0 =A0 if (!devm_request_mem_region(dev, regs_start, regs_size, DR=
V_NAME)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error requesting memory regio=
n!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mdma->regs =3D devm_ioremap(dev, regs_start, regs_size);
> + =A0 =A0 =A0 if (!mdma->regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error mapping memory region!\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mdma->tcd =3D (struct mpc_dma_tcd *)((u8 *)(mdma->regs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + MPC_DMA_TCD_OFFSET);
> +
> + =A0 =A0 =A0 retval =3D devm_request_irq(dev, mdma->irq, &mpc_dma_irq, 0=
, DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdma);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error requesting IRQ!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_init(&mdma->error_status_lock);
> +
> + =A0 =A0 =A0 dma =3D &mdma->dma;
> + =A0 =A0 =A0 dma->dev =3D dev;
> + =A0 =A0 =A0 dma->chancnt =3D MPC_DMA_CHANNELS;
> + =A0 =A0 =A0 dma->device_alloc_chan_resources =3D mpc_dma_alloc_chan_res=
ources;
> + =A0 =A0 =A0 dma->device_free_chan_resources =3D mpc_dma_free_chan_resou=
rces;
> + =A0 =A0 =A0 dma->device_issue_pending =3D mpc_dma_issue_pending;
> + =A0 =A0 =A0 dma->device_is_tx_complete =3D mpc_dma_is_tx_complete;
> + =A0 =A0 =A0 dma->device_prep_dma_memcpy =3D mpc_dma_prep_memcpy;
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&dma->channels);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < dma->chancnt; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan =3D &mdma->channels[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan->chan.device =3D dma;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan->chan.chan_id =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan->chan.cookie =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mchan->completed_cookie =3D mchan->chan.coo=
kie;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&mchan->free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&mchan->prepared);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&mchan->queued);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&mchan->active);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&mchan->completed);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&mchan->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&mchan->chan.device_node, &dm=
a->channels);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tasklet_init(&mdma->tasklet, mpc_dma_tasklet, (unsigned lon=
g)mdma);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Configure DMA Engine:
> + =A0 =A0 =A0 =A0* - Dynamic clock,
> + =A0 =A0 =A0 =A0* - Round-robin group arbitration,
> + =A0 =A0 =A0 =A0* - Round-robin channel arbitration.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_EDCG |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC_DMA_DMA=
CR_ERGA | MPC_DMA_DMACR_ERCA);
> +
> + =A0 =A0 =A0 /* Disable hardware DMA requests */
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaerqh, 0);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaerql, 0);
> +
> + =A0 =A0 =A0 /* Disable error interrupts */
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaeeih, 0);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaeeil, 0);
> +
> + =A0 =A0 =A0 /* Clear interrupts status */
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmainth, 0xFFFFFFFF);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaintl, 0xFFFFFFFF);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaerrh, 0xFFFFFFFF);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaerrl, 0xFFFFFFFF);
> +
> + =A0 =A0 =A0 /* Route interrupts to IPIC */
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmaihsa, 0);
> + =A0 =A0 =A0 out_be32(&mdma->regs->dmailsa, 0);
> +
> + =A0 =A0 =A0 /* Register DMA engine */
> + =A0 =A0 =A0 dev_set_drvdata(dev, mdma);
> + =A0 =A0 =A0 retval =3D dma_async_device_register(dma);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, mdma->irq, mdma);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_dispose_mapping(mdma->irq);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static int __devexit mpc_dma_remove(struct of_device *op)
> +{
> + =A0 =A0 =A0 struct device *dev =3D &op->dev;
> + =A0 =A0 =A0 struct mpc_dma *mdma =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 dma_async_device_unregister(&mdma->dma);
> + =A0 =A0 =A0 devm_free_irq(dev, mdma->irq, mdma);
> + =A0 =A0 =A0 irq_dispose_mapping(mdma->irq);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct of_device_id mpc_dma_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-dma", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver mpc_dma_driver =3D {
> + =A0 =A0 =A0 .match_table =A0 =A0=3D mpc_dma_match,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpc_dma_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(mpc_dma_remove),
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init mpc_dma_init(void)
> +{
> + =A0 =A0 =A0 return of_register_platform_driver(&mpc_dma_driver);
> +}
> +module_init(mpc_dma_init);
> +
> +static void __exit mpc_dma_exit(void)
> +{
> + =A0 =A0 =A0 of_unregister_platform_driver(&mpc_dma_driver);
> +}
> +module_exit(mpc_dma_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Piotr Ziecik <kosmo@semihalf.com>");
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
