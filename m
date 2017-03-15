Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjgKz6lWNzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 16:35:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pcmcia@lists.infradead.org, linuxppc-dev@ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, oss@buserror.net,
 qiang.zhao@nxp.com, claudiu.manoil@nxp.com
Subject: Re: [PATCH] drivers/pcmcia: NO_IRQ removal for electra_cf.c
In-Reply-To: <CAK8P3a0wfXrj3gJAffHLhqQjqcZWy2=WEVUordLxH-jOKAe0qw@mail.gmail.com>
References: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
 <87wpbsuo4x.fsf@concordia.ellerman.id.au>
 <CAK8P3a0wfXrj3gJAffHLhqQjqcZWy2=WEVUordLxH-jOKAe0qw@mail.gmail.com>
Date: Wed, 15 Mar 2017 16:35:17 +1100
Message-ID: <8760jbump6.fsf@concordia.ellerman.id.au>
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

> On Tue, Mar 14, 2017 at 11:51 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>
>>> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
>>> from electra_cf.c which is a powerpc-only driver.
>>>
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>  drivers/pcmcia/electra_cf.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Ping anyone?
>>
>> Or should I merge this via the powerpc tree?
>
> That's what I would recommend for a powerpc specific pcmcia driver, yes.

Suits me.

> Looking at the bigger picture of powerpc drivers using NO_IRQ, I also
> see these others:
>
> drivers/ata/pata_mpc52xx.c:     if (ata_irq == NO_IRQ) {
> drivers/ata/sata_dwc_460ex.c:#ifndef NO_IRQ
> drivers/ata/sata_dwc_460ex.c:#define NO_IRQ             0
> drivers/ata/sata_dwc_460ex.c:   if (hsdev->dma->irq == NO_IRQ) {
> drivers/ata/sata_dwc_460ex.c:   if (irq == NO_IRQ) {
> drivers/iommu/fsl_pamu.c:       if (irq == NO_IRQ) {
> drivers/iommu/fsl_pamu.c:       if (irq != NO_IRQ)
> drivers/media/platform/fsl-viu.c:       if (viu_irq == NO_IRQ) {
> drivers/mtd/nand/mpc5121_nfc.c: if (prv->irq == NO_IRQ) {
> drivers/pcmcia/electra_cf.c:    cf->irq = NO_IRQ;
> drivers/pcmcia/electra_cf.c:    if (cf->irq != NO_IRQ)
> drivers/soc/fsl/qe/qe_ic.c:/* Return an interrupt vector or NO_IRQ if
> no interrupt is pending. */
> drivers/soc/fsl/qe/qe_ic.c:             return NO_IRQ;
> drivers/soc/fsl/qe/qe_ic.c:/* Return an interrupt vector or NO_IRQ if
> no interrupt is pending. */
> drivers/soc/fsl/qe/qe_ic.c:             return NO_IRQ;
> drivers/soc/fsl/qe/qe_ic.c:     if (qe_ic->virq_low == NO_IRQ) {
> drivers/soc/fsl/qe/qe_ic.c:     if (qe_ic->virq_high != NO_IRQ &&
> drivers/spi/spi-mpc52xx.c:      if (status && (irq != NO_IRQ))
> drivers/tty/ehv_bytechan.c:     if (stdout_irq == NO_IRQ) {
> drivers/tty/ehv_bytechan.c:     if ((bc->rx_irq == NO_IRQ) ||
> (bc->tx_irq == NO_IRQ)) {
> drivers/tty/serial/cpm_uart/cpm_uart_core.c:    if (pinfo->port.irq == NO_IRQ) {
> drivers/uio/uio_fsl_elbc_gpcm.c:        if (irq != NO_IRQ) {
> drivers/uio/uio_fsl_elbc_gpcm.c:                        irq = NO_IRQ;
> drivers/uio/uio_fsl_elbc_gpcm.c:                 irq != NO_IRQ ? irq : -1);
> drivers/usb/host/ehci-grlib.c:  if (irq == NO_IRQ) {
> drivers/usb/host/ehci-ppc-of.c: if (irq == NO_IRQ) {
> drivers/usb/host/fhci-hcd.c:    if (usb_irq == NO_IRQ) {
> drivers/usb/host/ohci-ppc-of.c: if (irq == NO_IRQ) {
> drivers/usb/host/uhci-grlib.c:  if (irq == NO_IRQ) {
> drivers/video/fbdev/mb862xx/mb862xxfbdrv.c:     if (par->irq == NO_IRQ) {
> drivers/virt/fsl_hypervisor.c:          if (!handle || (irq == NO_IRQ)) {
> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq == NO_IRQ)
> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
>
> Did you have other pending patches for those?

No. I stayed away from anything FSL related as I was under the
impression some of them were being ported to arch/arm, which uses -1 for
NO_IRQ IIUIC.

eg. all of include/soc/fsl and drivers/soc/fsl was moved from
arch/powerpc in commit 7aa1aa6ecec2, which said:

    QE: Move QE from arch/powerpc to drivers/soc
    
    ls1 has qe and ls1 has arm cpu.
    move qe from arch/powerpc to drivers/soc/fsl
    to adapt to powerpc and arm

But looking at the Kconfigs it looks like they're still only selectable
on PPC. So that's a bit annoying.

I'll do patches for everything above that's not drivers/soc or
include/soc and hopefully we can hear from someone at NXP on the plans
for getting the soc parts enabled on arm.

cheers
