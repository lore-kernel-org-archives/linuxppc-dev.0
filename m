Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
	[209.85.211.177]) by ozlabs.org (Postfix) with ESMTP id 3A5DFB7D19
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Apr 2010 15:13:29 +1000 (EST)
Received: by ywh7 with SMTP id 7so357555ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Apr 2010 22:13:27 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272421789.2877.21.camel@iscandar.digidescorp.com>
References: <201004280206.38220.temerkhanov@yandex.ru>
	<1272421344.2877.6.camel@iscandar.digidescorp.com>
	<1272421789.2877.21.camel@iscandar.digidescorp.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 23:13:06 -0600
Message-ID: <n2vfa686aa41004272213wceeef998tadc483ec1de7b792@mail.gmail.com>
Subject: Re: [microblaze-uclinux] [PATCHv2] [RFC] Xilinx MPMC SDMA subsystem
To: steve@digidescorp.com, Sergey Temerkhanov <temerkhanov@yandex.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sergey and Steven,

On Tue, Apr 27, 2010 at 8:29 PM, Steven J. Magnani
<steve@digidescorp.com> wrote:
> On Wed, 2010-04-28 at 02:06 +0400, Sergey Temerkhanov wrote:
>> This is the 2nd version of Xilinx MPMC LocalLink SDMA subsystem
>>
>> Changelog v2:
>> * Changed the functions and struct definition prefix from sdma_ to xllsd=
ma_
>> * Platform bus bindings and various changes by Steven J. Magnani.
>> * Moved source files from arch/powerpc/sysdev to global locations and ad=
ded
>> =A0 CONFIG_XLLSDMA option.
>>
>> Regards, Sergey Temerkhanov,
>> Cifronic ZAO
>>
>> diff -r baced9e29ab5 drivers/dma/Kconfig
>> --- a/drivers/dma/Kconfig =A0 =A0 Tue Apr 27 20:48:50 2010 +0400
>> +++ b/drivers/dma/Kconfig =A0 =A0 Wed Apr 28 02:00:51 2010 +0400
>> @@ -97,6 +97,14 @@
>> =A0 =A0 =A0 =A0 Support the TXx9 SoC internal DMA controller. =A0This ca=
n be
>> =A0 =A0 =A0 =A0 integrated in chips such as the Toshiba TX4927/38/39.
>>
>> +config XLLSDMA

I'd prefer XILINX_LLSDMA.  XLLSDMA could be ambiguous in the global
namespace (for a human reader), particularly as it is something that
few people will actually see.

>> + =A0 =A0 bool "Xilinx MPMC DMA support"
>> + =A0 =A0 depends on XILINX_VIRTEX || MICROBLAZE
>> + =A0 =A0 select DMA_ENGINE
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Support fot Xilinx MPMC LocalLink SDMA. Virtex FPGA family
>> + =A0 =A0 =A0 has it integrated or fabric-based.
>> +
>
> fot --> for
>
> Since the xllsdma driver provides services to other drivers - not to user=
land -
> I think this would be better as a "silent" option, selected automatically=
 when
> something like ll_temac or the forthcoming Xilinx DMA engine is selected.
> If we do it that way, note that XLLSDMA is independent of DMA_ENGINE so
> drivers/Makefile will need to be patched so that the dma subdirectory is
> always "y".

Agreed.  However, looking at this code, I don't see anything that
actually uses DMA_ENGINE here.  Am I missing something?

>> diff -r baced9e29ab5 drivers/dma/Makefile
>> --- a/drivers/dma/Makefile =A0 =A0Tue Apr 27 20:48:50 2010 +0400
>> +++ b/drivers/dma/Makefile =A0 =A0Wed Apr 28 02:00:51 2010 +0400
>> @@ -10,3 +10,4 @@
>> =A0obj-$(CONFIG_AT_HDMAC) +=3D at_hdmac.o
>> =A0obj-$(CONFIG_MX3_IPU) +=3D ipu/
>> =A0obj-$(CONFIG_TXX9_DMAC) +=3D txx9dmac.o
>> +obj-$(CONFIG_XLLSDMA) +=3D xllsdma.o
>> diff -r baced9e29ab5 drivers/dma/xllsdma.c
>> --- /dev/null Thu Jan 01 00:00:00 1970 +0000
>> +++ b/drivers/dma/xllsdma.c =A0 Wed Apr 28 02:00:51 2010 +0400
>> @@ -0,0 +1,887 @@
>> +/*
>> + * SDMA subsystem support for Xilinx MPMC.
>> + *
>> + * Author: Sergey Temerkhanov
>> + * Platform Bus by Steven J. Magnani
>> + *
>> + * Copyright (c) 2008-2010 Cifronic ZAO
>> + *
>> + * This program is free software; you can redistribute =A0it and/or mod=
ify it
>> + * under =A0the terms of =A0the GNU General =A0Public License as publis=
hed by the
>> + * Free Software Foundation; either version 2 of the License, or (at yo=
ur
>> + * option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/errno.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/list.h>
>> +#include <linux/io.h>
>> +#include <linux/xllsdma.h>
>> +
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +
>> +#define DRV_VERSION "0.1.0"

Irrelevant, can be dropped

>> +#define DRV_NAME "sdma"

Used only once, drop.

>> +
>> +MODULE_AUTHOR("Sergey Temerkhanov <temerkhanov@cifronik.ru>");
>> +MODULE_DESCRIPTION("Xilinx SDMA driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_VERSION(DRV_VERSION);
>> +
>> +LIST_HEAD(mpmc_devs);
>> +DEFINE_MUTEX(mpmc_devs_lock);
>> +
>> +void xllsdma_tx_irq_enable(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 tx_cr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 BUG_ON(sdma->tx_irq =3D=3D NO_IRQ);
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 tx_cr =3D xllsdma_tx_in32(sdma, XLLSDMA_CR);
>> + =A0 =A0 xllsdma_tx_out32(sdma, XLLSDMA_CR, tx_cr | XLLSDMA_CR_IRQ_EN);
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);

This pattern is used a lot.  Might be worth while to implement
xllsdma_tx_* variants of setbits32, clrbits32 and clrsetbits32.

Also, there are a lot of these little functions; really trivial and
small.  Would it be better to have them as static inlines in the
header file instead of exported globals?

>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_tx_irq_enable);
>> +
>> +void xllsdma_rx_irq_enable(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 rx_cr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 BUG_ON(sdma->rx_irq =3D=3D NO_IRQ);
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 rx_cr =3D xllsdma_rx_in32(sdma, XLLSDMA_CR);
>> + =A0 =A0 xllsdma_rx_out32(sdma, XLLSDMA_CR, rx_cr | XLLSDMA_CR_IRQ_EN);
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_rx_irq_enable);
>> +
>> +void xllsdma_tx_irq_disable(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 tx_cr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 tx_cr =3D xllsdma_tx_in32(sdma, XLLSDMA_CR);
>> + =A0 =A0 xllsdma_tx_out32(sdma, XLLSDMA_CR, tx_cr & ~XLLSDMA_CR_IRQ_EN)=
;
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_tx_irq_disable);
>> +
>> +void xllsdma_rx_irq_disable(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 rx_cr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 rx_cr =3D xllsdma_rx_in32(sdma, XLLSDMA_CR);
>> + =A0 =A0 xllsdma_rx_out32(sdma, XLLSDMA_CR, rx_cr & ~XLLSDMA_CR_IRQ_EN)=
;
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_rx_irq_disable);
>> +
>> +void xllsdma_tx_irq_ack(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 irq_stat;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 irq_stat =3D xllsdma_tx_in32(sdma, XLLSDMA_IRQ);
>> + =A0 =A0 xllsdma_tx_out32(sdma, XLLSDMA_IRQ, irq_stat & XLLSDMA_IRQ_ALL=
_DONE);
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_tx_irq_ack);
>> +
>> +void xllsdma_rx_irq_ack(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 irq_stat;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 irq_stat =3D xllsdma_rx_in32(sdma, XLLSDMA_IRQ);
>> + =A0 =A0 xllsdma_rx_out32(sdma, XLLSDMA_IRQ, irq_stat & XLLSDMA_IRQ_ALL=
_DONE);
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_rx_irq_ack);
>> +
>> +void xllsdma_pause(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 dmacr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 dmacr =3D xllsdma_read_cr(sdma);
>> + =A0 =A0 dmacr |=3D XLLSDMA_DMACR_TX_PAUSE | XLLSDMA_DMACR_RX_PAUSE;
>> + =A0 =A0 xllsdma_write_cr(sdma, dmacr);
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_pause);
>> +
>> +void xllsdma_resume(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 u32 dmacr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 dmacr =3D xllsdma_read_cr(sdma);
>> + =A0 =A0 dmacr &=3D ~(XLLSDMA_DMACR_TX_PAUSE | XLLSDMA_DMACR_RX_PAUSE);
>> + =A0 =A0 xllsdma_write_cr(sdma, dmacr);
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_resume);
>> +
>> +int xllsdma_set_coalesce(struct xllsdma_device *sdma, struct xllsdma_co=
alesce *coal)
>> +{
>> + =A0 =A0 u32 tx_cr, rx_cr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 if (coal->tx_timeout > 255 ||
>> + =A0 =A0 =A0 =A0 coal->rx_timeout > 255 ||
>> + =A0 =A0 =A0 =A0 coal->tx_threshold > 255 ||
>> + =A0 =A0 =A0 =A0 coal->rx_threshold > 255)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> +
>> + =A0 =A0 if (sdma->rx_irq !=3D NO_IRQ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_cr =3D xllsdma_rx_in32(sdma, XLLSDMA_CR);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (coal->rx_timeout =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coal->rx_timeout =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_cr &=3D ~XLLSDMA_CR_IRQ_TIM=
EOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_cr |=3D XLLSDMA_CR_IRQ_TIME=
OUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_cr &=3D ~(XLLSDMA_CR_IRQ_THRESHOLD_MSK | XL=
LSDMA_CR_IRQ_TIMEOUT_SH);
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_cr |=3D (coal->rx_threshold << XLLSDMA_CR_I=
RQ_THRESHOLD_SH)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& XLLSDMA_CR_IRQ_THRESHOLD_=
MSK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_cr |=3D (coal->rx_timeout << XLLSDMA_CR_IRQ=
_TIMEOUT_SH)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& XLLSDMA_CR_IRQ_TIMEOUT_MS=
K;
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_cr |=3D XLLSDMA_CR_LD_IRQ_CNT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 xllsdma_rx_out32(sdma, XLLSDMA_CR, rx_cr);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (sdma->tx_irq !=3D NO_IRQ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_cr =3D xllsdma_tx_in32(sdma, XLLSDMA_CR);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (coal->tx_timeout =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coal->tx_timeout =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_cr &=3D ~XLLSDMA_CR_IRQ_TIM=
EOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_cr |=3D XLLSDMA_CR_IRQ_TIME=
OUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_cr &=3D ~(XLLSDMA_CR_IRQ_THRESHOLD_MSK | XL=
LSDMA_CR_IRQ_TIMEOUT_SH);
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_cr |=3D (coal->tx_threshold << XLLSDMA_CR_I=
RQ_THRESHOLD_SH)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& XLLSDMA_CR_IRQ_THRESHOLD_=
MSK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_cr |=3D (coal->tx_timeout << XLLSDMA_CR_IRQ=
_TIMEOUT_SH)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& XLLSDMA_CR_IRQ_TIMEOUT_MS=
K;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_cr |=3D XLLSDMA_CR_LD_IRQ_CNT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 xllsdma_tx_out32(sdma, XLLSDMA_CR, tx_cr);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_set_coalesce);
>> +
>> +int xllsdma_get_coalesce(struct xllsdma_device *sdma, struct xllsdma_co=
alesce *coal)
>> +{
>> + =A0 =A0 u32 tx_cr, rx_cr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> +
>> + =A0 =A0 tx_cr =3D xllsdma_tx_in32(sdma, XLLSDMA_CR);
>> + =A0 =A0 rx_cr =3D xllsdma_rx_in32(sdma, XLLSDMA_CR);
>> +
>> + =A0 =A0 coal->tx_threshold =3D (tx_cr & XLLSDMA_CR_IRQ_THRESHOLD_MSK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> XLLSDMA_CR_IRQ_T=
HRESHOLD_SH;
>> + =A0 =A0 coal->tx_timeout =3D (tx_cr & XLLSDMA_CR_IRQ_TIMEOUT_MSK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> XLLSDMA_CR_IRQ_TIMEO=
UT_SH;
>> +
>> + =A0 =A0 coal->rx_threshold =3D (rx_cr & XLLSDMA_CR_IRQ_THRESHOLD_MSK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> XLLSDMA_CR_IRQ_T=
HRESHOLD_SH;
>> + =A0 =A0 coal->rx_timeout =3D (rx_cr & XLLSDMA_CR_IRQ_TIMEOUT_MSK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> XLLSDMA_CR_IRQ_T=
IMEOUT_SH;
>> +
>> + =A0 =A0 if (!(tx_cr & XLLSDMA_CR_IRQ_TIMEOUT))
>> + =A0 =A0 =A0 =A0 =A0 =A0 coal->tx_timeout =3D 0;
>> +
>> + =A0 =A0 if (!(rx_cr & XLLSDMA_CR_IRQ_TIMEOUT))
>> + =A0 =A0 =A0 =A0 =A0 =A0 coal->rx_timeout =3D 0;
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_get_coalesce);
>> +
>> +int xllsdma_tx_submit(struct xllsdma_device *sdma, dma_addr_t desc)
>> +{
>> + =A0 =A0 xllsdma_tx_out32(sdma, XLLSDMA_TDESCR, desc);
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_tx_submit);
>
> Invariant return value can be dropped.

Also are more tiny functions that could be considered for static inlines.

>> +int xllsdma_rx_submit(struct xllsdma_device *sdma, dma_addr_t desc)
>> +{
>> + =A0 =A0 xllsdma_rx_out32(sdma, XLLSDMA_TDESCR, desc);
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_rx_submit);
>>
> Invariant return value can be dropped.
>
>> +
>> +void xllsdma_tx_init(struct xllsdma_device *sdma, dma_addr_t desc)
>> +{
>> + =A0 =A0 xllsdma_tx_out32(sdma, XLLSDMA_CDESCR, desc);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_tx_init);
>> +
>> +void xllsdma_rx_init(struct xllsdma_device *sdma, dma_addr_t desc)
>> +{
>> + =A0 =A0 xllsdma_rx_out32(sdma, XLLSDMA_CDESCR, desc);
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_rx_init);
>> +
>> +struct xllsdma_device *xllsdma_find_device(int phandle)
>> +{
>> + =A0 =A0 struct mpmc_device *mpmc;
>> + =A0 =A0 struct xllsdma_device *sdma =3D NULL;
>> + =A0 =A0 int found =3D 0;
>> + =A0 =A0 mutex_lock(&mpmc_devs_lock);
>> + =A0 =A0 list_for_each_entry(mpmc, &mpmc_devs, item) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&mpmc->devs_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(sdma, &mpmc->xllsdma_devs,=
 item) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sdma->phandle =3D=3D phand=
le) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&mpmc->devs_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (found)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdma =3D NULL;
>> + =A0 =A0 }
>> + =A0 =A0 mutex_unlock(&mpmc_devs_lock);

Why is the lock getting dropped on each iteration of the loop?  It
doesn't look necessary to me at all.

>> + =A0 =A0 return sdma;
>> +}
>> +EXPORT_SYMBOL_GPL(xllsdma_find_device);
>
> I'm still concerned that there is no concept of "allocating" or "reservin=
g" a
> channel. This seems to invite accidental concurrent use of a channel, if =
not in
> the field, then during development.

In the device tree use-case I doubt it will be a practical problem.
To get multiple users would require multiple nodes to reference the
same dma device node.

However, I've got concerns about the device model used here.... need
to read the rest of this driver first to figure out what is bothering
me....

>> +static void xllsdma_dev_register(struct mpmc_device *mpmc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct xllsdma_dev=
ice *sdma)
>> +{
>> + =A0 =A0 mutex_lock(&mpmc->devs_lock);
>> + =A0 =A0 list_add(&sdma->item, &mpmc->xllsdma_devs);
>> + =A0 =A0 mutex_unlock(&mpmc->devs_lock);
>> +}

This driver could use some documentation on what the data model is
here.  Is it that the system can have one or more mpmc_devices, and
each mpmc device can contain one or more xllsdma_device?

How will the ll_temac driver plug into this model?

>> +
>> +static void xllsdma_dev_unregister(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 struct mpmc_device *mpmc =3D sdma->parent;
>> +
>> + =A0 =A0 mutex_lock(&mpmc->devs_lock);
>> + =A0 =A0 list_del(&sdma->item);
>> + =A0 =A0 mutex_unlock(&mpmc->devs_lock);
>> +}
>> +
>> +static void xllsdma_cleanup(struct device *dev)
>> +{
>> + =A0 =A0 struct xllsdma_device *sdma =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 if (sdma->tx_irq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_irq(sdma->tx_irq, sdma);
>> +
>> + =A0 =A0 if (sdma->rx_irq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_irq(sdma->rx_irq, sdma);
>> +
>> + =A0 =A0 if (sdma->memregion.start)
>> + =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(sdma->memregion.start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdma->memregion.end - sdma->me=
mregion.start + 1);
>> +
>> + =A0 =A0 if (sdma->ioaddr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iounmap(sdma->ioaddr);
>> +
>> + =A0 =A0 xllsdma_dev_unregister(sdma);
>> + =A0 =A0 kfree(sdma);
>> + =A0 =A0 dev_set_drvdata(dev, NULL);
>> +}
>> +
>> +static void mpmc_dev_register(struct mpmc_device *mpmc)
>> +{
>> + =A0 =A0 mutex_lock(&mpmc_devs_lock);
>> + =A0 =A0 list_add_tail(&mpmc->item, &mpmc_devs);
>> + =A0 =A0 mutex_unlock(&mpmc_devs_lock);
>> +}
>> +
>> +static void mpmc_dev_unregister(struct mpmc_device *mpmc)
>> +{
>> + =A0 =A0 mutex_lock(&mpmc_devs_lock);
>> + =A0 =A0 list_del(&mpmc->item);
>> + =A0 =A0 mutex_unlock(&mpmc_devs_lock);
>> +}
>> +
>> +static void mpmc_cleanup(struct device *dev)
>> +{
>> + =A0 =A0 struct mpmc_device *mpmc =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 if (mpmc->registered)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mpmc_dev_unregister(mpmc);

Under what condition would the mpmc not be registered when this
function is called?  I don't see any code path where this would be the
case, or any other users of the .registered data member.

>> +
>> + =A0 =A0 kfree(mpmc);
>> + =A0 =A0 dev_set_drvdata(dev, NULL);
>> +}
>> +
>> +static int __devinit xllsdma_init(struct device *dev, struct resource *=
rx_irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resource=
 *tx_irq, struct resource *mem,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int phandle)
>> +{
>> + =A0 =A0 struct xllsdma_device *sdma;
>> + =A0 =A0 struct mpmc_device *mpmc;
>> +
>> + =A0 =A0 resource_size_t region_size;
>> + =A0 =A0 int res;
>> +
>> + =A0 =A0 mpmc =3D dev_get_drvdata(dev->parent);
>> +
>> + =A0 =A0 sdma =3D kzalloc(sizeof(struct xllsdma_device), GFP_KERNEL);
>> + =A0 =A0 if (!sdma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Cannot allocate SDMA device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> + =A0 =A0 dev_set_drvdata(dev, sdma);
>> + =A0 =A0 sdma->dev =3D dev;
>> +
>> + =A0 =A0 spin_lock_init(&sdma->lock);
>> + =A0 =A0 INIT_LIST_HEAD(&sdma->clients);
>> + =A0 =A0 mutex_init(&sdma->clients_lock);
>> + =A0 =A0 sdma->parent =3D mpmc;
>> + =A0 =A0 sdma->phandle =3D phandle;
>> +
>> + =A0 =A0 region_size =3D mem->end - mem->start + 1;
>> + =A0 =A0 if (!request_mem_region(mem->start, region_size, DRV_NAME)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "I/O memory region at %p is busy\=
n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)mem->start);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;

Error paths need to unwind allocations and setups.  ie. freeing
memory, releasing irqs, etc.

>> + =A0 =A0 }
>> + =A0 =A0 sdma->memregion =3D *mem;
>> +
>> + =A0 =A0 sdma->ioaddr =3D ioremap(mem->start, region_size);
>> + =A0 =A0 if (!sdma->ioaddr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Cannot ioremap() I/O memory %p\n=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)mem->start);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 xllsdma_reset(sdma);
>> +
>> + =A0 =A0 sdma->rx_irq =3D NO_IRQ;
>> + =A0 =A0 if (rx_irq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 res =3D request_irq(rx_irq->start, xllsdma_rx_=
intr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_SHARED, "=
SDMA RX", sdma);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Could not alloca=
te RX interrupt %d.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_irq->start)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdma->rx_irq =3D rx_irq->start;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 sdma->tx_irq =3D NO_IRQ;
>> + =A0 =A0 if (tx_irq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 res =3D request_irq(tx_irq->start, xllsdma_tx_=
intr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_SHARED, "=
SDMA TX", sdma);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Could not alloca=
te TX interrupt %d.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_irq->start)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdma->tx_irq =3D tx_irq->start;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 sdma->rx_ack =3D 1;
>> + =A0 =A0 sdma->tx_ack =3D 1;
>> + =A0 =A0 xllsdma_dev_register(mpmc, sdma);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int __devinit mpmc_init(struct device *dev)
>> +{
>> + =A0 =A0 struct mpmc_device *mpmc;
>> +
>> + =A0 =A0 mpmc =3D kzalloc(sizeof(struct mpmc_device), GFP_KERNEL);
>> +
>> + =A0 =A0 if (!mpmc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Cannot allocate MPMC device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_set_drvdata(dev, mpmc);
>> +
>> + =A0 =A0 INIT_LIST_HEAD(&mpmc->xllsdma_devs);
>> + =A0 =A0 mutex_init(&mpmc->devs_lock);
>> +
>> + =A0 =A0 mpmc_dev_register(mpmc);
>> + =A0 =A0 mpmc->registered =3D 1;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static int xllsdma_of_remove(struct of_device *op)

+static int __devexit xllsdma_of_remove(struct of_device *op)

>> +{
>> + =A0 =A0 xllsdma_cleanup(&op->dev);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* Match table for of_platform binding */
>> +static struct of_device_id xllsdma_of_match[] =3D {
>> + =A0 =A0 { .compatible =3D "xlnx,ll-dma-1.00.a" },
>> + =A0 =A0 {},
>> +};
>> +
>> +static int __devinit xllsdma_of_probe(struct of_device *op,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const s=
truct of_device_id *match)
>> +{
>> + =A0 =A0 const int *prop;
>> + =A0 =A0 int phandle;
>> + =A0 =A0 struct resource rx_irq, tx_irq, mem;
>> + =A0 =A0 struct resource *tx_irq_res =3D NULL;
>> + =A0 =A0 struct resource *rx_irq_res =3D NULL;
>> + =A0 =A0 int res;
>> +
>> + =A0 =A0 res =3D of_address_to_resource(op->node, 0, &mem);
>> + =A0 =A0 if (res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid address\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return res;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* IRQ */
>> + =A0 =A0 res =3D of_irq_to_resource(op->node, 0, &rx_irq);
>> + =A0 =A0 if (res !=3D NO_IRQ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_irq_res =3D &rx_irq;
>> +
>> + =A0 =A0 res =3D of_irq_to_resource(op->node, 1, &tx_irq);
>> + =A0 =A0 if (res !=3D NO_IRQ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_irq_res =3D &tx_irq;
>> +
>> + =A0 =A0 prop =3D of_get_property(op->node, "linux,phandle", NULL);
>> + =A0 =A0 phandle =3D (prop) ? *prop : -1;

Don't use phandles here.  Just store the node pointer directly.  When
looking up a phandle, first convert it to a node pointer, and then use
the node pointer to search.

>> +
>> + =A0 =A0 res =3D xllsdma_init(&op->dev, rx_irq_res, tx_irq_res, &mem, p=
handle);
>> + =A0 =A0 if (res)
>> + =A0 =A0 =A0 =A0 =A0 =A0 xllsdma_of_remove(op);

This looks odd.  If init fails, there is nothing in this function that
needs to be deallocated or unwound.  You can simply do:

+return xllsdma_init(&op->dev, rx_irq_res, tx_irq_res, &mem, phandle);

>> +
>> + =A0 =A0 return res;
>> +}
>> +
>> +static struct of_platform_driver xllsdma_of_driver =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "xilinx-sdma",
>> + =A0 =A0 .match_table =A0 =A0=3D xllsdma_of_match,
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D xllsdma_of_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D xllsdma_of_remove,
>> +};

Should be:
+static struct of_platform_driver xllsdma_of_driver =3D {
+ =A0 =A0 .driver =3D {
+             .name =3D "xilinx-sdma",
+             .owner =3D THIS_MODULE,
+     }
+ =A0 =A0 .match_table =A0 =A0=3D xllsdma_of_match,
+ =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D xllsdma_of_probe,
+ =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(xllsdma_of_remove),
+};

>> +
>> +int __init xllsdma_of_init(void)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D of_register_platform_driver(&xllsdma_of_driver);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_unregister_platform_driver(&xllsdma_of_driv=
er);
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "registering driver failed: er=
r=3D%i", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}

If registering fails, unregistering is not needed.  This function
should simply be:

+int __init xllsdma_of_init(void)
+{
+ =A0 =A0 return of_register_platform_driver(&xllsdma_of_driver);
+}

>> +
>> +void xllsdma_of_exit(void)
>> +{
>> + =A0 =A0 of_unregister_platform_driver(&xllsdma_of_driver);
>> +}
>> +
>> +static int mpmc_of_remove(struct of_device *op)

+static int __devexit mpmc_of_remove(struct of_device *op)

>> +{
>> + =A0 =A0 struct device_node *node;
>> + =A0 =A0 struct of_device *ofdev;
>> +
>> + =A0 =A0 for_each_child_of_node(op->node, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ofdev =3D of_find_device_by_node(node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_device_unregister(ofdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_device_free(ofdev);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mpmc_cleanup(&op->dev);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int __devinit mpmc_of_probe(struct of_device *op,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct of_device_id *mat=
ch)
>> +{
>> + =A0 =A0 int err =3D mpmc_init(&op->dev);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 of_platform_bus_probe(op->node, xllsdma_of_match, &op->dev);
>> + =A0 =A0 return 0;
>> +}

Okay, I think I've figured out what is bothering me....

While this *does* work; it really is the long way to go about things.
Doing it this way requires going back out to the driver model to tell
it things and trigger a probe on things that *this* driver needs, and
*this* driver already knows about.  It doesn't need to be this
complex.

Rather than register a bunch more of_platform devices, do something
like this instead:

+static int __devinit mpmc_of_probe(struct of_device *op,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct of_device_id *match)
+{
+ =A0 =A0 struct mpmc_device *mpmc;
+     struct device_node *node;
+
+ =A0 =A0 mpmc =3D mpmc_init(&op->dev);
+ =A0 =A0 if (!mpmc)
+ =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
+
+ =A0 =A0 for_each_child_of_node(op->node, node) {
+             xllsdma_of_init(mpmc, node);
+ =A0 =A0 }
+ =A0 =A0 return 0;
+}

You do *not* need to register a separate struct device for each DMA
channel sub node (at least with regard to the driver model; I don't
know about the dma subsystem).  If you *want* a struct device, then
xllsdma_of_init() is free to register one, but it does not need to be
on the of_platform_bus, and this driver should not require a probe
step for each DMA channel.

>> +
>> +static struct of_device_id =A0__devinitdata mpmc_of_match[] =3D {
>> + =A0 =A0 { .compatible =3D "xlnx,mpmc-4.01.a" },
>> + =A0 =A0 { .compatible =3D "xlnx,mpmc-4.03.a" },
>> + =A0 =A0 {},
>> +};
>> +
>> +static struct of_platform_driver mpmc_of_driver =3D {
>> + =A0 =A0 .name =3D "xilinx-mpmc",
>> + =A0 =A0 .match_table =3D mpmc_of_match,
>> + =A0 =A0 .probe =3D mpmc_of_probe,
>> + =A0 =A0 .remove =3D mpmc_of_remove,
>> +};
>> +
>> +int __init mpmc_of_init(void)
>> +{
>> + =A0 =A0 return of_register_platform_driver(&mpmc_of_driver);
>> +}
>> +
>> +void mpmc_of_exit(void)
>> +{
>> + =A0 =A0 of_unregister_platform_driver(&mpmc_of_driver);
>> +}

Missing the module exit hook?

>> +
>> +subsys_initcall(mpmc_of_init);
>> +subsys_initcall(xllsdma_of_init);

Typically initcall statements are placed immediately after the init
function they reference.

>> +#else =A0 =A0 =A0 =A0/* CONFIG_OF */

Why else?  It is perfectly valid to have both of_platform and platform
bus bindings.  That being said, this split will become unnecessary in
the very near future.  I've eliminated of_platform_bus_type, and
automatically moved all users of it over to the platform bus (without
driver changes).

However, current powerpc and microblaze code makes CONFIG_OF
manditory.  What condition will compile in the platform bus
attachment?

>> +/*---------------------------------------------------------------------=
------
>> + * Platform bus attachment
>> + */
>> +
>> +static __devexit int xllsdma_plat_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 xllsdma_cleanup(&pdev->dev);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int __devinit xllsdma_plat_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct resource *rx_irq, *tx_irq, *mem;
>> + =A0 =A0 int err =3D 0;
>> +
>> + =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "invalid address\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* RX interrupt is optional, and first */
>> + =A0 =A0 rx_irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +
>> + =A0 =A0 /* TX interrupt is optional, and second */
>> + =A0 =A0 tx_irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 1);
>> +
>
> If it is impossible to create duplicate phandles in Device Tree,
> there should be a check here that no device with pdev->id already exists
> (i.e., it's NOT impossible with platform bus). It might be just as well t=
o
> put the check in xllsdma_init() since that's not a 'hot' code path.

Question: microblaze and powerpc both use the device tree.  What is
the use-case for the non-dts version?

>
>> + =A0 =A0 err =3D xllsdma_init(&pdev->dev, rx_irq, tx_irq, mem, pdev->id=
);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 xllsdma_plat_remove(pdev);
>> +fail:
>> + =A0 =A0 return err;
>> +}
>> +
>> +static struct platform_driver xllsdma_plat_driver =3D {
>> + =A0 =A0 .probe =3D xllsdma_plat_probe,
>> + =A0 =A0 .remove =3D __devexit_p(xllsdma_plat_remove),
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0=3D "xilinx-sdma",
>> + =A0 =A0 },
>> +};
>> +
>> +int __init xllsdma_plat_init(void)
>> +{
>> + =A0 =A0 int err =3D platform_driver_register(&xllsdma_plat_driver);
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 platform_driver_unregister(&xllsdma_plat_drive=
r);
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "registering driver failed: er=
r=3D%i", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +subsys_initcall(xllsdma_plat_init);

Again, if driver registration fails, then the driver doesn't need to
be unregistered.  Same as with the of_platform_bus binding.

>> +
>> +void xllsdma_plat_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&xllsdma_plat_driver);
>> +}
>> +
>> +static int mpmc_plat_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return mpmc_init(&pdev->dev);
>> +}
>> +
>> +static int __devexit mpmc_plat_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 mpmc_cleanup(&pdev->dev);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver mpmc_plat_driver =3D {
>> + =A0 =A0 .probe =3D mpmc_plat_probe,
>> + =A0 =A0 .remove =3D __devexit_p(mpmc_plat_remove),
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0=3D "xilinx-mpmc",
>> + =A0 =A0 },
>> +};

I'll make the same argument here.  The multiple registrations in this
driver is weird.  This driver already knows about all of it's dma
channels, so why depend on the core driver model to probe a driver
instance for each?

>> +
>> +int __init mpmc_plat_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&mpmc_plat_driver);
>> +}
>> +subsys_initcall(mpmc_plat_init);
>> +
>> +void mpmc_plat_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&mpmc_plat_driver);
>> +}
>> +#endif =A0 =A0 =A0 /* CONFIG_OF */
>> diff -r baced9e29ab5 include/linux/xllsdma.h
>> --- /dev/null Thu Jan 01 00:00:00 1970 +0000
>> +++ b/include/linux/xllsdma.h Wed Apr 28 02:00:51 2010 +0400
>> @@ -0,0 +1,187 @@
>> +/*
>> + * SDMA subsystem support for Xilinx MPMC.
>> + *
>> + * Author: Sergey Temerkhanov
>> + *
>> + * Copyright (c) 2008-2010 Cifronic ZAO
>> + *
>> + * This program is free software; you can redistribute =A0it and/or mod=
ify it
>> + * under =A0the terms of =A0the GNU General =A0Public License as publis=
hed by the
>> + * Free Software Foundation; =A0either version 2 of the =A0License, or =
(at your
>> + * option) any later version.
>> + *
>> + */
>> +
>> +#ifndef __XLLSDMA_H__
>> +#define __XLLSDMA_H__
>> +
>> +#include <linux/types.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +#define XLLSDMA_ALIGNMENT =A0 =A00x40
>> +
>> +struct xllsdma_desc {
>> + =A0 =A0 __be32 next;
>> + =A0 =A0 __be32 address;
>> + =A0 =A0 __be32 length;
>> + =A0 =A0 __be32 stat_ctl;
>> + =A0 =A0 __be32 app1;
>> + =A0 =A0 __be32 app2;
>> + =A0 =A0 __be32 app3;
>> + =A0 =A0 __be32 app4;
>> + =A0 =A0 void *virt;
>> + =A0 =A0 u32 flags;
>> +} __attribute__((aligned(XLLSDMA_ALIGNMENT)));
>
> 'virt' and 'flags' are not used by this driver. Putting them in this stru=
cture,
> and using this structure in the API, forces them on all clients, which ca=
n lead
> to inefficiencies (this will certainly be true in the DMA engine driver, =
perhaps
> others). I think a better choice would be to have the API use a structure=
 without
> these two fields. For the convenience of other clients you could define a
> 'superstructure' _not_ used in the API, like:
>
> struct xllsdma_fancy_desc {
> =A0 =A0 =A0 =A0struct xllsdma_desc =A0basic_desc;
> =A0 =A0 =A0 =A0void *virt;
> =A0 =A0 =A0 =A0u32 flags;
> }
>
>> +
>> +
>> +enum {
>> + =A0 =A0 XLLSDMA_STSCTL_ERROR =A0 =A0=3D (1 << 31), /* DMA error */
>> + =A0 =A0 XLLSDMA_STSCTL_IOE =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 30), /=
* Interrupt on end */
>> + =A0 =A0 XLLSDMA_STSCTL_SOE =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 29), /=
* Stop on end */
>> + =A0 =A0 XLLSDMA_STSCTL_DONE =A0 =A0 =3D (1 << 28), /* DMA completed */
>> + =A0 =A0 XLLSDMA_STSCTL_SOP =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 27), /=
* Start of packet */
>> + =A0 =A0 XLLSDMA_STSCTL_EOP =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 26), /=
* End of packet */
>> + =A0 =A0 XLLSDMA_STSCTL_BUSY =A0 =A0 =3D (1 << 25), /* DMA busy */
>> + =A0 =A0 XLLSDMA_STSCTL_CSUM =A0 =A0 =3D (1 << 0), =A0/* Checksum enabl=
e */
>> +
>> + =A0 =A0 XLLSDMA_STSCTL_MSK =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (0xFF << 24)=
, /*Status/control field */
>> +};
>
> The search-and-replace messed up your nice alignment.
>
>> +
>> +/* SDMA client operations */
>> +struct xllsdma_client {
>> + =A0 =A0 void *data;
>> + =A0 =A0 void (*tx_complete) (void *data);
>> + =A0 =A0 void (*rx_complete) (void *data);
>> + =A0 =A0 void (*error) (void *data);
>> + =A0 =A0 void (*reset) (void *data);
>> + =A0 =A0 struct list_head item;
>> +};
>> +
>> +struct xllsdma_coalesce {
>> + =A0 =A0 int tx_threshold;
>> + =A0 =A0 int tx_timeout;
>> +
>> + =A0 =A0 int rx_threshold;
>> + =A0 =A0 int rx_timeout;
>> +};
>> +
>> +#define DEFINE_XLLSDMA_COALESCE(x) struct xllsdma_coalesce x =3D { \
>> + =A0 =A0 .tx_timeout =A0 =A0 =3D 0, \
>> + =A0 =A0 .tx_threshold =A0 =3D 1, \
>> + =A0 =A0 .rx_timeout =A0 =A0 =3D 0, \
>> + =A0 =A0 .rx_threshold =A0 =3D 1, };
>> +
>> +struct mpmc_device {
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*ioaddr;
>> +
>> + =A0 =A0 struct resource =A0 =A0 =A0 =A0 memregion;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 registered;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0item;
>> +
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0devs_lock;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0xllsdma_devs;
>> +};
>> +
>> +struct xllsdma_device {
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*ioaddr;
>> + =A0 =A0 wait_queue_head_t =A0 =A0 =A0 wait;
>> +
>> + =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
>> +
>> + =A0 =A0 struct resource =A0 =A0 =A0 =A0 memregion;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_irq;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_irq;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_ack;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_ack;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phandle;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 registered;
>> + =A0 =A0 struct mpmc_device =A0 =A0 =A0*parent;
>> +
>> + =A0 =A0 struct xllsdma_coalesce coal;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0item;
>> +
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0clients_lock;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0clients;
>> +};
>> +
>> +static inline void xllsdma_add_client(struct xllsdma_device *sdma,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
xllsdma_client *client)
>> +{
>> + =A0 =A0 mutex_lock(&sdma->clients_lock);
>> + =A0 =A0 list_add(&client->item, &sdma->clients);
>> + =A0 =A0 mutex_unlock(&sdma->clients_lock);
>> +}
>> +
>> +static inline void xllsdma_del_client(struct xllsdma_device *sdma,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
xllsdma_client *client)
>> +{
>> + =A0 =A0 mutex_lock(&sdma->clients_lock);
>> + =A0 =A0 list_del(&client->item);
>> + =A0 =A0 mutex_unlock(&sdma->clients_lock);
>> +}
>> +
>> +struct xllsdma_device *xllsdma_find_device(int phandle);
>> +void xllsdma_pause(struct xllsdma_device *sdma);
>> +void xllsdma_resume(struct xllsdma_device *sdma);
>> +void xllsdma_reset(struct xllsdma_device *sdma);
>> +void xllsdma_rx_init(struct xllsdma_device *sdma, dma_addr_t desc);
>> +void xllsdma_tx_init(struct xllsdma_device *sdma, dma_addr_t desc);
>> +
>> +int xllsdma_tx_submit(struct xllsdma_device *sdma, dma_addr_t desc);
>> +int xllsdma_rx_submit(struct xllsdma_device *sdma, dma_addr_t desc);
>> +
>> +void xllsdma_tx_irq_enable(struct xllsdma_device *sdma);
>> +void xllsdma_rx_irq_enable(struct xllsdma_device *sdma);
>> +void xllsdma_tx_irq_disable(struct xllsdma_device *sdma);
>> +void xllsdma_rx_irq_disable(struct xllsdma_device *sdma);
>> +void xllsdma_tx_irq_ack(struct xllsdma_device *sdma);
>> +void xllsdma_rx_irq_ack(struct xllsdma_device *sdma);
>> +
>> +int xllsdma_set_coalesce(struct xllsdma_device *sdma, struct xllsdma_co=
alesce *coal);
>> +int xllsdma_get_coalesce(struct xllsdma_device *sdma, struct xllsdma_co=
alesce *coal);
>> +
>> +static inline int xllsdma_has_tx_irq(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 return sdma->tx_irq !=3D NO_IRQ;
>> +}
>> +
>> +static inline int xllsdma_has_rx_irq(struct xllsdma_device *sdma)
>> +{
>> + =A0 =A0 return sdma->rx_irq !=3D NO_IRQ;
>> +}
>> +
>> +static inline int xllsdma_desc_busy(struct xllsdma_desc *desc)
>> +{
>> + =A0 =A0 return desc->stat_ctl & __constant_be32_to_cpu(XLLSDMA_STSCTL_=
BUSY);
>> +}
>> +
>> +static inline int xllsdma_desc_done(struct xllsdma_desc *desc)
>> +{
>> + =A0 =A0 return desc->stat_ctl & __constant_be32_to_cpu(XLLSDMA_STSCTL_=
DONE);
>> +}
>> +
>> +static inline int xllsdma_desc_sop(struct xllsdma_desc *desc)
>> +{
>> + =A0 =A0 return desc->stat_ctl & __constant_be32_to_cpu(XLLSDMA_STSCTL_=
SOP);
>> +}
>> +
>> +static inline int xllsdma_desc_eop(struct xllsdma_desc *desc)
>> +{
>> + =A0 =A0 return desc->stat_ctl & __constant_be32_to_cpu(XLLSDMA_STSCTL_=
EOP);
>> +}
>> +
>> +static inline void xllsdma_set_ack(struct xllsdma_device *sdma, int rx_=
ack,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int tx_ack)
>> +{
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 spin_lock_irqsave(&sdma->lock, flags);
>> + =A0 =A0 sdma->rx_ack =3D rx_ack;
>> + =A0 =A0 sdma->tx_ack =3D tx_ack;
>> + =A0 =A0 spin_unlock_irqrestore(&sdma->lock, flags);
>> +}
>> +
>> +#endif
>
> ------------------------------------------------------------------------
> =A0Steven J. Magnani =A0 =A0 =A0 =A0 =A0 =A0 =A0 "I claim this network fo=
r MARS!
> =A0www.digidescorp.com =A0 =A0 =A0 =A0 =A0 =A0 =A0Earthling, return my sp=
ace modulator!"
>
> =A0#include <standard.disclaimer>
>
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
