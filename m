Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 74B7A2C0091
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2012 04:58:18 +1000 (EST)
Subject: Re: [PATCH] [v3] powerpc/p5040ds: Add support for P5040DS board
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343240224-17607-1-git-send-email-timur@freescale.com>
Date: Wed, 25 Jul 2012 13:58:12 -0500
Message-Id: <8953B2C7-3EF6-42D0-BFB9-8E93B908EE3B@kernel.crashing.org>
References: <1343240224-17607-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 25, 2012, at 1:17 PM, Timur Tabi wrote:

> Add support for the Freescale P5040DS Reference Board ("Superhydra"), =
which
> is similar to the P5020DS.  Features of the P5040 are listed below, =
but
> not all of these features (e.g. DPAA networking) are currently =
supported.
>=20
> Four P5040 single-threaded e5500 cores built
>    Up to 2.4 GHz with 64-bit ISA support
>    Three levels of instruction: user, supervisor, hypervisor
> CoreNet platform cache (CPC)
>    2.0 MB configures as dual 1 MB blocks hierarchical interconnect =
fabric
> Two 64-bit DDR3/3L SDRAM memory controllers with ECC and interleaving =
support
>    Up to 1600MT/s
>    Memory pre-fetch engine
> DPAA incorporating acceleration for the following functions
>    Packet parsing, classification, and distribution (FMAN)
>    Queue management for scheduling, packet sequencing and
> 	congestion management (QMAN)
>    Hardware buffer management for buffer allocation and
> 	de-allocation (BMAN)
>    Cryptography acceleration (SEC 5.0) at up to 40 Gbps
> SerDes
>    20 lanes at up to 5 Gbps
>    Supports SGMII, XAUI, PCIe rev1.1/2.0, SATA
> Ethernet interfaces
>    Two 10 Gbps Ethernet MACs
>    Ten 1 Gbps Ethernet MACs
> High-speed peripheral interfaces
>    Two PCI Express 2.0/3.0 controllers
> Additional peripheral interfaces
>    Two serial ATA (SATA 2.0) controllers
>    Two high-speed USB 2.0 controllers with integrated PHY
>    Enhanced secure digital host controller (SD/MMC/eMMC)
>    Enhanced serial peripheral interface (eSPI)
>    Two I2C controllers
>    Four UARTs
>    Integrated flash controller supporting NAND and NOR flash
> DMA
>    Dual four channel
> Support for hardware virtualization and partitioning enforcement
>    Extra privileged level for hypervisor support
> QorIQ Trust Architecture 1.1
>    Secure boot, secure debug, tamper detection, volatile key storage
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> v3: fixes per Scott's comments, although only the things that I knew =
how
> to fix.
>=20
> arch/powerpc/boot/dts/fsl/p5040si-post.dtsi   |  320 =
+++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi    |  111 +++++++++
> arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |  118 +++++++++
> arch/powerpc/boot/dts/p5040ds.dts             |  203 ++++++++++++++++
> arch/powerpc/configs/corenet32_smp_defconfig  |    1 +
> arch/powerpc/configs/corenet64_smp_defconfig  |    1 +
> arch/powerpc/platforms/85xx/Kconfig           |   14 +
> arch/powerpc/platforms/85xx/Makefile          |    1 +
> arch/powerpc/platforms/85xx/p5040_ds.c        |   89 +++++++
> 9 files changed, 858 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
> create mode 100644 arch/powerpc/boot/dts/p5040ds.dts
> create mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c

High level comments, please split the p5040si*dtsi into a seperate =
patch.  Also, you need to update fsl_pci.c for "fsl,qoriq-pcie-v2.4"

- k=
