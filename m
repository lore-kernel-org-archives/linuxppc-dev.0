Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 076F51007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:29:21 +1100 (EST)
Received: by yxe9 with SMTP id 9so4922678yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:29:19 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:28:58 -0700
Message-ID: <fa686aa40911221528y1980a95bw1dc8aa75a86c061e@mail.gmail.com>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Add support for the interrupt controller included in the "Flipper"
> chipset of the Nintendo GameCube video game console.
> The same interrupt controller is also present in the "Hollywood" chipset
> of the Nintendo Wii.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
> =A0arch/powerpc/platforms/embedded6xx/Kconfig =A0 =A0 =A0 | =A0 =A06 +
> =A0arch/powerpc/platforms/embedded6xx/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/platforms/embedded6xx/flipper-pic.c | =A0247 ++++++++++++=
++++++++++
> =A0arch/powerpc/platforms/embedded6xx/flipper-pic.h | =A0 25 +++
> =A04 files changed, 279 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h
>
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/pl=
atforms/embedded6xx/Kconfig
> index bfd88be..29a98c6 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -94,6 +94,7 @@ config MPC10X_STORE_GATHERING
> =A0config GAMECUBE_COMMON
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0select NOT_COHERENT_CACHE
> + =A0 =A0 =A0 select FLIPPER_PIC
>
> =A0config USBGECKO_UDBG
> =A0 =A0 =A0 =A0bool "USB Gecko udbg console for the Nintendo GameCube/Wii=
"
> @@ -108,3 +109,8 @@ config USBGECKO_UDBG
>
> =A0 =A0 =A0 =A0 =A0If in doubt, say N here.
>
> +config FLIPPER_PIC
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on GAMECUBE_COMMON
> + =A0 =A0 =A0 default y

You'll always want this driver when GAMECUBE common is set.  Don't add
another Kconfig entry.

> +
> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/p=
latforms/embedded6xx/Makefile
> index 0ab7492..35258fd 100644
> --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_PPC_HOLLY) =A0 =A0 =A0 =A0 +=3D holly.o
> =A0obj-$(CONFIG_PPC_PRPMC2800) =A0 =A0+=3D prpmc2800.o
> =A0obj-$(CONFIG_PPC_C2K) =A0 =A0 =A0 =A0 =A0+=3D c2k.o
> =A0obj-$(CONFIG_USBGECKO_UDBG) =A0 =A0+=3D usbgecko_udbg.o
> +obj-$(CONFIG_FLIPPER_PIC) =A0 =A0 =A0+=3D flipper-pic.o

> +unsigned int flipper_pic_get_irq(void)
> +{
> + =A0 =A0 =A0 void __iomem *io_base =3D flipper_irq_host->host_data;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 u32 irq_status;
> +
> + =A0 =A0 =A0 irq_status =3D in_be32(io_base + FLIPPER_ICR) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_be32(io_base + FLIPPER_IMR);
> + =A0 =A0 =A0 if (irq_status =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1; =A0 =A0 =A0/* no more IRQs pendi=
ng */

NO_IRQ_IGNORE

> +
> + =A0 =A0 =A0 __asm__ __volatile__("cntlzw %0,%1" : "=3Dr"(irq) : "r"(irq=
_status));
> + =A0 =A0 =A0 return irq_linear_revmap(flipper_irq_host, 31 - irq);
> +}
> +

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
