Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DCE27B70C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 02:45:07 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 3AC37DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 02:45:06 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1067742ywt.39
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 09:45:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090606163837.17482.56209.stgit@localhost.localdomain>
References: <20090606163837.17482.56209.stgit@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 6 Jun 2009 10:44:44 -0600
Message-ID: <fa686aa40906060944x46bc8b40ybe3a66cf1bc8685f@mail.gmail.com>
Subject: Re: [PATCH] powerpc/install: Bail with error code on error in install
	script
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops, forgot one.  Here is a new request including the xilinxfb refactoring=
:

The following changes since commit baf75b0a42a1b3f6fca80f8949b6141eaff61b0d=
:
  Stephen Rothwell (1):
        powerpc/pci: Fix annotation of pcibios_claim_one_bus

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next

Grant Likely (1):
      powerpc/virtex: refactor intc driver and add support for i8259 cascad=
ing

John Linn (1):
      fbdev: Add PLB support and cleanup DCR in xilinxfb driver.

Roderick Colenbrander (3):
      powerpc/virtex: Add support for Xilinx PCI host bridge
      powerpc/virtex: Add Xilinx ML510 reference design support
      powerpc/virtex: Add ml510 reference design device tree

 arch/powerpc/boot/dts/virtex440-ml510.dts |  465 +++++++++++++++++++++++++=
++++
 arch/powerpc/include/asm/xilinx_pci.h     |   21 ++
 arch/powerpc/platforms/40x/virtex.c       |    2 +
 arch/powerpc/platforms/44x/Kconfig        |   13 +-
 arch/powerpc/platforms/44x/Makefile       |    1 +
 arch/powerpc/platforms/44x/virtex.c       |    2 +
 arch/powerpc/platforms/44x/virtex_ml510.c |   29 ++
 arch/powerpc/platforms/Kconfig            |    4 +
 arch/powerpc/sysdev/Makefile              |    1 +
 arch/powerpc/sysdev/xilinx_intc.c         |   81 ++++--
 arch/powerpc/sysdev/xilinx_pci.c          |  132 ++++++++
 drivers/video/xilinxfb.c                  |  290 ++++++++++---------
 12 files changed, 883 insertions(+), 158 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/virtex440-ml510.dts
 create mode 100644 arch/powerpc/include/asm/xilinx_pci.h
 create mode 100644 arch/powerpc/platforms/44x/virtex_ml510.c
 create mode 100644 arch/powerpc/sysdev/xilinx_pci.c


On Sat, Jun 6, 2009 at 10:39 AM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> If anything goes wrong when copying images into the install path, then
> the install script should exit with an error code so that 'make' knows
> about it and tells the user.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0arch/powerpc/boot/install.sh | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
>
> diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
> index 51b2387..98312d1 100644
> --- a/arch/powerpc/boot/install.sh
> +++ b/arch/powerpc/boot/install.sh
> @@ -18,6 +18,9 @@
> =A0# =A0 $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc=
.
> =A0#
>
> +# Bail with error code if anything goes wrong
> +set -e
> +
> =A0# User may have a custom install script
>
> =A0if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS=
_COMPILE}installkernel "$@"; fi
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
