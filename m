Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 546A2DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 09:24:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
Date: Tue, 7 Aug 2007 01:24:04 +0200
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
In-Reply-To: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200708070124.04748.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 07 August 2007, Wolfgang Reissnegger wrote:
>=20
> Make support for Xilinx boards more generic, making it easier
> to add new boards. =A0Add initial support for xupv2p and ml410 boards.

I really think we shouldn't add stuff to arch/ppc at this point,
it has been deprecated for over two years now.

> --- a/arch/ppc/platforms/4xx/virtex.h
> +++ b/arch/ppc/platforms/4xx/virtex.h
> @@ -31,5 +31,14 @@ extern const char* virtex_machine_name;
> =A0#define PPC4xx_ONB_IO_VADDR=A0=A0=A0=A00u
> =A0#define PPC4xx_ONB_IO_SIZE=A0=A0=A0=A0=A00u
> =A0
> +
> +#if defined(CONFIG_XILINX_VIRTEX_II_PRO)
> +#define XILINX_ARCH "Virtex-II Pro"
> +#elif defined(CONFIG_XILINX_VIRTEX_4_FX)
> +#define XILINX_ARCH "Virtex-4 FX"
> +#else
> +#error "No Xilinx Architecture recognized."
> +#endif
> +
> =A0#endif=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0/* __ASM_VIRTEX_H__ */
> =A0#endif=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0/* __KERNEL__ */

When you move over to arch/powerpc, you can't do it this way, because
that prevents you from building a multiplatform kernel.

Every macro and global function that gets defined must be able to coexist
with others that are enabled by nonexclusive configuration options.

> +#if defined(CONFIG_XILINX_ML300)
> +const char *virtex_machine_name =3D "Xilinx ML300";
> +#elif defined(CONFIG_XILINX_XUPV2P)
> +const char *virtex_machine_name =3D "Xilinx XUPV2P";
> +#elif defined(CONFIG_XILINX_ML40x)
> +const char *virtex_machine_name =3D "Xilinx ML40x";
> +#elif defined(CONFIG_XILINX_ML41x)
> +const char *virtex_machine_name =3D "Xilinx ML41x";
> +#else
> +const char *virtex_machine_name =3D "Unknown Xilinx with PowerPC";
> +#endif

same here.

> +
> +
> +#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
> +static volatile unsigned *powerdown_base =3D
> + =A0 =A0(volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;

volatile is a bug. This needs to be __iomem, and the address probably
needs to come from of_iomap() or a similar function.

> +static void
> +xilinx_power_off(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0local_irq_disable();
> +=A0=A0=A0=A0=A0=A0=A0out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VAL=
UE);
> +=A0=A0=A0=A0=A0=A0=A0while (1) ;
> +}
> +#endif

You should run 'sparse' on your code before submitting patches. That
would have caught this bug in the out_be32() instruction that expects
an __iomem pointer.

> +
> +void __init
> +xilinx_generic_ppc_map_io(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0ppc4xx_map_io();
> +
> +#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
> +=A0=A0=A0=A0=A0=A0=A0powerdown_base =3D ioremap((unsigned long) powerdow=
n_base,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 XPAR_POWER_0_POWERDOWN_HIGHADDR -
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
> +#endif
> +}

It's a rather unconventional way of working with the addresses.
You should never use a single variable for pointers going to
two different address spaces (physical and kernel virtual in this
case).

> +void __init
> +xilinx_generic_ppc_setup_arch(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0virtex_early_serial_map();

Use legacy_serial/of_serial to do this, with proper device tree entries.

> +
> +int virtex_device_fixup(struct platform_device *dev)
> +{
> + int i;
> +#ifdef XPAR_ONEWIRE_0_BASEADDR
> + /* Use the Silicon Serial ID attached on the onewire bus to */
> + /* generate sensible MAC addresses. */
> + unsigned char *pOnewire =3D ioremap(XPAR_ONEWIRE_0_BASEADDR, 6);
> + struct xemac_platform_data *pdata =3D dev->dev.platform_data;
> + if (strcmp(dev->name, "xilinx_emac") =3D=3D 0) {

This is heavily whitespace damaged, use tabs for indentation instead
of spaces.

> diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/=
platforms/4xx/xparameters/xparameters.h
> index 01aa043..34d9844 100644
> --- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
> +++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
> @@ -15,8 +15,12 @@
> =A0
> =A0#if defined(CONFIG_XILINX_ML300)
> =A0 =A0#include "xparameters_ml300.h"
> +#elif defined(CONFIG_XILINX_XUPV2P)
> + =A0#include "xparameters_xupv2p.h"
> =A0#elif defined(CONFIG_XILINX_ML403)
> =A0 =A0#include "xparameters_ml403.h"
> +#elif defined(CONFIG_XILINX_ML41x)
> + =A0#include "xparameters_ml41x.h"
> =A0#else
> =A0 =A0/* Add other board xparameter includes here before the #else */
> =A0 =A0#error No xparameters_*.h file included

see comment above.

> +/* Definitions for driver PLBARB */
> +#define XPAR_XPLBARB_NUM_INSTANCES 1
> +
> +/* Definitions for peripheral PLB */
> +#define XPAR_PLB_BASEADDR 0x00000000
> +#define XPAR_PLB_HIGHADDR 0x00000000
> +#define XPAR_PLB_DEVICE_ID 0
> +#define XPAR_PLB_PLB_NUM_MASTERS 3
> +
> +
> +/******************************************************************/
> +
> +/* Definitions for driver OPBARB */
> +#define XPAR_XOPBARB_NUM_INSTANCES 1
> +
> +/* Definitions for peripheral OPB */
> +#define XPAR_OPB_BASEADDR 0xFFFFFFFF
> +#define XPAR_OPB_HIGHADDR 0x00000000
> +#define XPAR_OPB_DEVICE_ID 0
> +#define XPAR_OPB_NUM_MASTERS 1
> +
> +/******************************************************************/
> +
> +
> +/* Definitions for peripheral OPB_SOCKET_0 */
> +#define XPAR_OPB_SOCKET_0_BASEADDR 0x40000000
> +#define XPAR_OPB_SOCKET_0_HIGHADDR 0x7FFFFFFF
> +#define XPAR_OPB_SOCKET_0_DCR_BASEADDR 0x40700300
> +#define XPAR_OPB_SOCKET_0_DCR_HIGHADDR 0x40700307
> +
> +/******************************************************************/
> +
> +/* Definitions for driver UARTNS550 */
> +#define XPAR_XUARTNS550_NUM_INSTANCES 2
> +#define XPAR_XUARTNS550_CLOCK_HZ 100000000
> +
> +/* Definitions for peripheral RS232_UART_1 */
> +#define XPAR_RS232_UART_1_BASEADDR 0x40400000
> +#define XPAR_RS232_UART_1_HIGHADDR 0x4040FFFF
> +#define XPAR_RS232_UART_1_DEVICE_ID 0
> +
> +
> +/* Definitions for peripheral RS232_UART_2 */
> +#define XPAR_RS232_UART_2_BASEADDR 0x40420000
> +#define XPAR_RS232_UART_2_HIGHADDR 0x4042FFFF
> +#define XPAR_RS232_UART_2_DEVICE_ID 1
> +

none of theses addresses, nor those following below should be hardcoded
in the kernel source, but should come from the device tree.

	Arnd <><
