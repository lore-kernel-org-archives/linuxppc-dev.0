Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVF7h2WqKzDsTF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:16:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Remove all usages of NO_IRQ
In-Reply-To: <4300236.QNKFM5GGo3@wuerfel>
References: <1473162804-6802-1-git-send-email-mpe@ellerman.id.au>
 <4300236.QNKFM5GGo3@wuerfel>
Date: Thu, 08 Sep 2016 19:16:12 +1000
Message-ID: <87lgz2lpk3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday, September 6, 2016 9:53:24 PM CEST Michael Ellerman wrote:
>>  drivers/macintosh/macio_asic.c                   |  4 ++--
>>  drivers/macintosh/rack-meter.c                   |  2 +-
>>  drivers/macintosh/smu.c                          | 18 +++++++++---------
>>  drivers/macintosh/via-cuda.c                     |  2 +-
>>  drivers/macintosh/via-pmu.c                      |  6 +++---
>>  drivers/ps3/ps3-vuart.c                          |  4 ++--
>>  sound/aoa/core/gpio-feature.c                    |  4 ++--
>>  sound/ppc/tumbler.c                              |  8 ++++----
>
> I've got a tree in which I've fixed up all drivers that use NO_IRQ on
> ARM (tested with lots of randconfig builds). I found a couple remaining
> ones that all look powerpc specific:

Thanks.

I have some of these already as per-subsystem patches:

 drivers/dma/ppc4xx/adma.c                    |  4 ++--
 drivers/edac/mv64x60_edac.c                  |  8 ++++----
 drivers/edac/ppc4xx_edac.c                   |  6 +++---
 drivers/net/ethernet/ibm/emac/core.c         | 10 +++++-----
 drivers/net/ethernet/ibm/emac/mal.c          |  5 ++---
 drivers/net/ethernet/ibm/ibmvnic.c           |  4 ++--
 drivers/net/ethernet/toshiba/ps3_gelic_net.c |  4 ++--
 drivers/pcmcia/electra_cf.c                  |  4 ++--

The rest below I haven't looked at yet, I'm not entirely clear on which
FSL pieces are able to build on arm.

> drivers/dma/bestcomm/bestcomm.c:		if (tsk->irq != NO_IRQ)
> drivers/dma/fsl_raid.c:	if (chan->irq == NO_IRQ) {
> drivers/dma/fsldma.c:	if (fdev->irq != NO_IRQ) {
> drivers/dma/mpc512x_dma.c:	if (mdma->irq == NO_IRQ) {
> drivers/edac/mpc85xx_edac.c:	pdata->irq = NO_IRQ;
> drivers/iommu/fsl_pamu.c:	if (irq != NO_IRQ)
> drivers/media/platform/fsl-viu.c:	if (viu_irq == NO_IRQ) {
> drivers/mtd/nand/mpc5121_nfc.c:	if (prv->irq == NO_IRQ) {
> drivers/net/ethernet/freescale/fs_enet/mac-fcc.c:	if (fep->interrupt == NO_IRQ)
> drivers/net/ethernet/freescale/fs_enet/mac-fec.c:	if (fep->interrupt == NO_IRQ)
> drivers/net/ethernet/freescale/fs_enet/mac-scc.c:	if (fep->interrupt == NO_IRQ)
> drivers/soc/fsl/qe/qe_ic.c:		return NO_IRQ;
> drivers/spi/spi-mpc52xx.c:	if (status && (irq != NO_IRQ))
> drivers/tty/ehv_bytechan.c:	if (stdout_irq == NO_IRQ) {
> drivers/tty/serial/cpm_uart/cpm_uart_core.c:	if (pinfo->port.irq == NO_IRQ) {
> drivers/uio/uio_fsl_elbc_gpcm.c:	if (irq != NO_IRQ) {
> drivers/usb/host/ehci-grlib.c:	if (irq == NO_IRQ) {
> drivers/usb/host/ehci-ppc-of.c:	if (irq == NO_IRQ) {
> drivers/usb/host/fhci-hcd.c:	if (usb_irq == NO_IRQ) {
> drivers/usb/host/ohci-ppc-of.c:	if (irq == NO_IRQ) {
> drivers/usb/host/uhci-grlib.c:	if (irq == NO_IRQ) {
> drivers/video/fbdev/mb862xx/mb862xxfbdrv.c:	if (par->irq == NO_IRQ) {
> drivers/virt/fsl_hypervisor.c:		if (!handle || (irq == NO_IRQ)) {
> include/soc/fsl/qe/qe_ic.h:	if (cascade_irq != NO_IRQ)

cheers
