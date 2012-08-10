Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 89EFB2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 23:12:15 +1000 (EST)
Subject: Re: [PATCH V6 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344586776-3115-1-git-send-email-B38951@freescale.com>
Date: Fri, 10 Aug 2012 08:12:11 -0500
Message-Id: <8639423F-3A56-4344-A662-F790098985FD@kernel.crashing.org>
References: <1344586776-3115-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2012, at 3:19 AM, Jia Hongtao wrote:

> We unified the Freescale pci/pcie initialization by changing the =
fsl_pci
> to a platform driver. In previous PCI code architecture the =
initialization
> routine is called at board_setup_arch stage. Now the initialization is =
done
> in probe function which is architectural better. Also It's convenient =
for
> adding PM support for PCI controller in later patch.
>=20
> We also change the way of determining primary bus for fitting platform
> driver. Thanks to the proposal from Ben. Please refer to the link =
below:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-June/098586.html
>=20
> Now we registered pci controllers as platform devices. So we combine =
two
> initialization code as one platform driver.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> Changes for V6:
> - Fix "isa_io_base could not be zero" bug. Thanks to Ben.
>=20
> - Determining primary by looking for ISA node does not work for =
ge_imp3a.
>  It's fixed by adding ISA node to its devied tree.
>=20
> arch/powerpc/boot/dts/ge_imp3a.dts         |    4 +
> arch/powerpc/kernel/pci-common.c           |    2 +-
> arch/powerpc/platforms/85xx/common.c       |   10 +++
> arch/powerpc/platforms/85xx/corenet_ds.c   |   31 +--------
> arch/powerpc/platforms/85xx/ge_imp3a.c     |   48 +------------
> arch/powerpc/platforms/85xx/mpc8536_ds.c   |   36 +---------
> arch/powerpc/platforms/85xx/mpc85xx_ads.c  |    9 +--
> arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   14 +----
> arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   38 ++--------
> arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   38 +---------
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |   28 +++-----
> arch/powerpc/platforms/85xx/p1010rdb.c     |   14 +----
> arch/powerpc/platforms/85xx/p1022_ds.c     |   34 +---------
> arch/powerpc/platforms/85xx/p1022_rdk.c    |   34 +---------
> arch/powerpc/platforms/85xx/p1023_rds.c    |    7 +--
> arch/powerpc/platforms/85xx/p2041_rdb.c    |    2 +-
> arch/powerpc/platforms/85xx/p3041_ds.c     |    2 +-
> arch/powerpc/platforms/85xx/p4080_ds.c     |    2 +-
> arch/powerpc/platforms/85xx/p5020_ds.c     |    2 +-
> arch/powerpc/platforms/85xx/p5040_ds.c     |    2 +-
> arch/powerpc/platforms/85xx/qemu_e500.c    |    3 +-
> arch/powerpc/platforms/85xx/sbc8548.c      |   19 +-----
> arch/powerpc/platforms/85xx/socrates.c     |   11 +---
> arch/powerpc/platforms/85xx/stx_gp3.c      |   11 +---
> arch/powerpc/platforms/85xx/tqm85xx.c      |   21 +------
> arch/powerpc/platforms/85xx/xes_mpc85xx.c  |   54 ++-------------
> arch/powerpc/platforms/86xx/gef_ppc9a.c    |   10 +--
> arch/powerpc/platforms/86xx/gef_sbc310.c   |   11 +---
> arch/powerpc/platforms/86xx/gef_sbc610.c   |   10 +--
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   19 +----
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   40 +----------
> arch/powerpc/platforms/86xx/sbc8641d.c     |   12 +---
> arch/powerpc/sysdev/fsl_pci.c              |  102 =
+++++++++++++++++-----------
> arch/powerpc/sysdev/fsl_pci.h              |    9 ++-
> drivers/edac/mpc85xx_edac.c                |   43 +++---------
> 35 files changed, 165 insertions(+), 567 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/ge_imp3a.dts =
b/arch/powerpc/boot/dts/ge_imp3a.dts
> index fefae41..aa2c4b5 100644
> --- a/arch/powerpc/boot/dts/ge_imp3a.dts
> +++ b/arch/powerpc/boot/dts/ge_imp3a.dts
> @@ -248,6 +248,10 @@
> 				  0x1000000 0x0 0x0
> 				  0x1000000 0x0 0x0
> 				  0x0 0x10000>;
> +
> +			isa@1e {
> +				device_type =3D "isa";
> +			};
> 		};
> 	};
> };

Why are we adding an isa node to the ge_imp3a.dts?

If this is really needed it should be a separate patch as well.

- k
