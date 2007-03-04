Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 01202DDF31
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2007 01:06:53 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] [POWERPC] allow pSeries to build without CONFIG_PCI
Date: Sun, 4 Mar 2007 15:07:06 +0100
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170348.511af7cb.sfr@canb.auug.org.au>
	<20070304170444.2eb423ce.sfr@canb.auug.org.au>
In-Reply-To: <20070304170444.2eb423ce.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703041507.06307.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 04 March 2007 07:04:44 Stephen Rothwell wrote:
> =A0config PCI
> =A0=A0=A0=A0=A0=A0=A0=A0bool "PCI support" if 40x || CPM2 || PPC_83xx || =
PPC_85xx || PPC_86xx \=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|| PPC_MPC52xx || (EMBEDDED=
 && PPC_ISERIES) || MPC7448HPC2 || PPC_PS3=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|| PPC_MPC52xx || (EMBEDDED=
 &&  (PPC_PSERIES || PPC_ISERIES)) \=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|| MPC7448HPC2 || PPC_PS3=20

This may be a dumb question, but system would you want to run a pSeries
kernel without PCI on? Is this just for build tests, or is there an
actual application for this?

>  procfs-$(CONFIG_PPC64)         :=3D proc_ppc64.o
>  obj-$(CONFIG_PROC_FS)          +=3D $(procfs-y)
> -rtaspci-$(CONFIG_PPC64)                :=3D rtas_pci.o
> -obj-$(CONFIG_PPC_RTAS)         +=3D rtas.o rtas-rtc.o $(rtaspci-y)
> +rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)  :=3D rtas_pci.o
> +obj-$(CONFIG_PPC_RTAS)         +=3D rtas.o rtas-rtc.o $(rtaspci-y-y)
>  obj-$(CONFIG_RTAS_FLASH)       +=3D rtas_flash.o
>  obj-$(CONFIG_RTAS_PROC)                +=3D rtas-proc.o

The double -y suffix always confuses me. Do you mind turning this
into a Kconfig symbol instead?

config RTAS_PCI
	default y
	depends on PCI && PPC64 && PPC_RTAS

obj-$(CONFIG_RTAS_PCI)	+=3D rtas_pci.o

	Arnd <><
