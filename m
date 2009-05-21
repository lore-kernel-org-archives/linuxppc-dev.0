Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by ozlabs.org (Postfix) with ESMTP id D0BABDE112
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 03:05:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH v4 3/3] powerpc/virtex: Add Xilinx ML510 reference
	designsupport
Date: Thu, 21 May 2009 09:50:11 -0700
In-Reply-To: <20090521162434.10880.62883.stgit@localhost.localdomain>
References: <20090521162202.10880.34056.stgit@localhost.localdomain>
	<20090521162434.10880.62883.stgit@localhost.localdomain>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>,
	"Roderick Colenbrander" <thunderbird2k@gmail.com>
Message-ID: <20090521165008.A020D710053@mail54-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of Grant
Likely
> Sent: Thursday, May 21, 2009 9:25 AM
> To: linuxppc-dev@ozlabs.org; Roderick Colenbrander
> Subject: [PATCH v4 3/3] powerpc/virtex: Add Xilinx ML510 reference
designsupport
> =

> From: Roderick Colenbrander <thunderbird2k@gmail.com>
> =

> Signed-off-by: Roderick Colenbrander <thunderbird2k@gmail.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> =

>  arch/powerpc/platforms/44x/Kconfig        |   10 +++++++++-
>  arch/powerpc/platforms/44x/Makefile       |    1 +
>  arch/powerpc/platforms/44x/virtex_ml510.c |   29
+++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/xilinx_intc.c         |    5 +++++
>  4 files changed, 44 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/platforms/44x/virtex_ml510.c
> =

> =

> diff --git a/arch/powerpc/platforms/44x/Kconfig
b/arch/powerpc/platforms/44x/Kconfig
> index 0d83a6a..af1c51d 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -156,7 +156,7 @@ config YOSEMITE
>  #	  This option enables support for the IBM PPC440GX evaluation
board.
> =

>  config XILINX_VIRTEX440_GENERIC_BOARD
> -	bool "Generic Xilinx Virtex 440 board"
> +	bool "Xilinx Virtex 5 support"

'Virtex 5' is a little ambiguous..  I'd suggest keeping the old wording,
or saying 'Virtex 5 FXT support'.  Even then it's somewhat ambiguous,
since you could conceivably run linux on microblaze on V5FXT and use the
powerpc for something else..

>  	depends on 44x
>  	default n
>  	select XILINX_VIRTEX_5_FXT
> @@ -171,6 +171,14 @@ config XILINX_VIRTEX440_GENERIC_BOARD
>  	  Most Virtex 5 designs should use this unless it needs to do
some
>  	  special configuration at board probe time.
> =

> +config XILINX_ML510
> +	bool "Xilinx ML510 board support"
> +	depends on XILINX_VIRTEX440_GENERIC_BOARD
> +	select PPC_PCI_CHOICE
> +	select XILINX_PCI if PCI
> +	select PPC_INDIRECT_PCI if PCI
> +	select PPC_I8259 if PCI
> +
>  config PPC44x_SIMPLE
>  	bool "Simple PowerPC 44x board support"
>  	depends on 44x
> diff --git a/arch/powerpc/platforms/44x/Makefile
b/arch/powerpc/platforms/44x/Makefile
> index 01f51da..ee6185a 100644
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_EBONY)	+=3D ebony.o
>  obj-$(CONFIG_SAM440EP) 	+=3D sam440ep.o
>  obj-$(CONFIG_WARP)	+=3D warp.o
>  obj-$(CONFIG_XILINX_VIRTEX_5_FXT) +=3D virtex.o
> +obj-$(CONFIG_XILINX_ML510) +=3D virtex_ml510.o
> diff --git a/arch/powerpc/platforms/44x/virtex_ml510.c
b/arch/powerpc/platforms/44x/virtex_ml510.c
> new file mode 100644
> index 0000000..ba4a6e3
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/virtex_ml510.c
> @@ -0,0 +1,29 @@
> +#include <asm/i8259.h>
> +#include <linux/pci.h>
> +#include "44x.h"
> +
> +/**
> + * ml510_ail_quirk

Tpyo, but is the comment even necessary if it doesn't say anything
useful?

> + */
> +static void __devinit ml510_ali_quirk(struct pci_dev *dev)
> +{
> +	/* Enable the IDE controller */
> +	pci_write_config_byte(dev, 0x58, 0x4c);
> +	/* Assign irq 14 to the primary ide channel */
> +	pci_write_config_byte(dev, 0x44, 0x0d);
> +	/* Assign irq 15 to the secondary ide channel */
> +	pci_write_config_byte(dev, 0x75, 0x0f);
> +	/* Set the ide controller in native mode */
> +	pci_write_config_byte(dev, 0x09, 0xff);
> +
> +	/* INTB =3D disabled, INTA =3D disabled */
> +	pci_write_config_byte(dev, 0x48, 0x00);
> +	/* INTD =3D disabled, INTC =3D disabled */
> +	pci_write_config_byte(dev, 0x4a, 0x00);
> +	/* Audio =3D INT7, Modem =3D disabled. */
> +	pci_write_config_byte(dev, 0x4b, 0x60);
> +	/* USB =3D INT7 */
> +	pci_write_config_byte(dev, 0x74, 0x06);
> +}
> +DECLARE_PCI_FIXUP_EARLY(0x10b9, 0x1533, ml510_ali_quirk);
> +
> diff --git a/arch/powerpc/sysdev/xilinx_intc.c
b/arch/powerpc/sysdev/xilinx_intc.c
> index 90b5772..3ee1fd3 100644
> --- a/arch/powerpc/sysdev/xilinx_intc.c
> +++ b/arch/powerpc/sysdev/xilinx_intc.c
> @@ -257,6 +257,11 @@ static void __init
xilinx_i8259_setup_cascade(void)
>  	i8259_init(cascade_node, 0);
>  	set_irq_chained_handler(cascade_irq, xilinx_i8259_cascade);
> =

> +	/* Program irq 7 (usb/audio), 14/15 (ide) to level sensitive */
> +	/* This looks like a dirty hack to me --gcl */
> +	outb(0xc0, 0x4d0);
> +	outb(0xc0, 0x4d1);
> +

Yeow... I agree about the dirty hack part...  shouldn't this be in the
device tree somewhere, or in the ali driver?

I'm curious if this works on ml410 as well..  (Yes, I know, does this
really matter much?  But there are still a bunch of them floating around
in universities.)  It may be nice to factor this out so ml410/ppc405 and
microblaze can get it as well.

Steve

>   out:
>  	of_node_put(cascade_node);
>  }
> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
