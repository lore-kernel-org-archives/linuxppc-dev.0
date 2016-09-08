Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVFW54yMpzDsTD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:33:05 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Remove all usages of NO_IRQ
Date: Thu, 08 Sep 2016 11:28:22 +0200
Message-ID: <9024911.juYcnHzy1x@wuerfel>
In-Reply-To: <87lgz2lpk3.fsf@concordia.ellerman.id.au>
References: <1473162804-6802-1-git-send-email-mpe@ellerman.id.au>
 <4300236.QNKFM5GGo3@wuerfel> <87lgz2lpk3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, September 8, 2016 7:16:12 PM CEST Michael Ellerman wrote:
> 
> The rest below I haven't looked at yet, I'm not entirely clear on which
> FSL pieces are able to build on arm.
> 
> > drivers/dma/bestcomm/bestcomm.c:              if (tsk->irq != NO_IRQ)
> > drivers/dma/fsl_raid.c:       if (chan->irq == NO_IRQ) {
> > drivers/dma/fsldma.c: if (fdev->irq != NO_IRQ) {
> > drivers/dma/mpc512x_dma.c:    if (mdma->irq == NO_IRQ) {
> > drivers/edac/mpc85xx_edac.c:  pdata->irq = NO_IRQ;
> > drivers/iommu/fsl_pamu.c:     if (irq != NO_IRQ)
> > drivers/media/platform/fsl-viu.c:     if (viu_irq == NO_IRQ) {
> > drivers/mtd/nand/mpc5121_nfc.c:       if (prv->irq == NO_IRQ) {
> > drivers/net/ethernet/freescale/fs_enet/mac-fcc.c:     if (fep->interrupt == NO_IRQ)
> > drivers/net/ethernet/freescale/fs_enet/mac-fec.c:     if (fep->interrupt == NO_IRQ)
> > drivers/net/ethernet/freescale/fs_enet/mac-scc.c:     if (fep->interrupt == NO_IRQ)
> > drivers/soc/fsl/qe/qe_ic.c:           return NO_IRQ;
> > drivers/spi/spi-mpc52xx.c:    if (status && (irq != NO_IRQ))
> > drivers/tty/ehv_bytechan.c:   if (stdout_irq == NO_IRQ) {
> > drivers/tty/serial/cpm_uart/cpm_uart_core.c:  if (pinfo->port.irq == NO_IRQ) {
> > drivers/uio/uio_fsl_elbc_gpcm.c:      if (irq != NO_IRQ) {
> > drivers/usb/host/ehci-grlib.c:        if (irq == NO_IRQ) {
> > drivers/usb/host/ehci-ppc-of.c:       if (irq == NO_IRQ) {
> > drivers/usb/host/fhci-hcd.c:  if (usb_irq == NO_IRQ) {
> > drivers/usb/host/ohci-ppc-of.c:       if (irq == NO_IRQ) {
> > drivers/usb/host/uhci-grlib.c:        if (irq == NO_IRQ) {
> > drivers/video/fbdev/mb862xx/mb862xxfbdrv.c:   if (par->irq == NO_IRQ) {
> > drivers/virt/fsl_hypervisor.c:                if (!handle || (irq == NO_IRQ)) {
> > include/soc/fsl/qe/qe_ic.h:   if (cascade_irq != NO_IRQ)

None of these are used on ARM at the moment (as of linux-next yesterday),
they would have shown up in my randconfig tests otherwise.

The "qe" stuff is the only thing that will likely get used on ARM
in the future, but the usage of NO_IRQ in that driver is actually
wrong on ARM, so that has to be fixed anyway before we can use it.

	Arnd
