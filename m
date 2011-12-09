Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 712861007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 01:00:21 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so2341632vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2011 06:00:18 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 9 Dec 2011 09:00:18 -0500
Message-ID: <CA+5PVA6tSuycrK-jh2UD3SfTEvhCoFNY=LmfwZYX-w=uOn+cdQ@mail.gmail.com>
Subject: Please pull 'next' branch of new 4xx tree (updated)
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 30, 2011 at 10:14 AM, Josh Boyer <jwboyer@gmail.com> wrote:
> Hi Ben,
>
> I have a new 4xx tree setup now. =A0Two small commits for the next
> branch are queued up. =A0I'd like to get the patch series from Suzie and
> Tony included soon as well, but thought I'd start with these to get
> things rolling.

I've updated my next branch to include the Currituck changes from
Tony.  Suzie's patches from today look good, but he has an error in
one of them that is missing a file, so I'll have to send those on once
that is fixed.

Please pull this time ;)

josh

The following changes since commit fa8cbaaf5a68f62db3f9a8444ecbb940b47984cb=
:

  powerpc+sparc64/mm: Remove hack in mmap randomize layout (2011-11-28
11:42:09 +1100)

are available in the git repository at:
  git://git.infradead.org/users/jwboyer/powerpc-4xx.git next

Christoph Egger (1):
      powerpc/44x: Removing dead CONFIG_PPC47x

Josh Boyer (1):
      MAINTAINERS: Update PowerPC 4xx git tree

Tanmay Inamdar (1):
      powerpc/40x: Add APM8018X SOC support

Tony Breeds (7):
      powerpc/44x: pci: Use PCI_BASE_ADDRESS_MEM_PREFETCH rather than
magic value.
      powerpc/44x: pci: Add a want_sdr flag into ppc4xx_pciex_hwops
      powerpc/44x: pci: Setup the dma_window properties for each pci_contro=
ller
      powerpc/boot: Add extended precision shifts to the boot wrapper.
      powerpc/boot: Add mfdcrx
      powerpc/476fpe: Add 476fpe SoC code
      powerpc/47x: Add support for the new IBM currituck platform

 MAINTAINERS                                  |    2 +-
 arch/powerpc/boot/Makefile                   |    5 +-
 arch/powerpc/boot/dcr.h                      |    6 +
 arch/powerpc/boot/div64.S                    |   52 ++++++
 arch/powerpc/boot/dts/currituck.dts          |  237 ++++++++++++++++++++++=
++++
 arch/powerpc/boot/dts/klondike.dts           |  227 ++++++++++++++++++++++=
++
 arch/powerpc/boot/treeboot-currituck.c       |  119 +++++++++++++
 arch/powerpc/boot/wrapper                    |    3 +
 arch/powerpc/configs/40x/klondike_defconfig  |   55 ++++++
 arch/powerpc/configs/44x/currituck_defconfig |  110 ++++++++++++
 arch/powerpc/include/asm/reg.h               |    1 +
 arch/powerpc/kernel/cputable.c               |   27 +++
 arch/powerpc/kernel/head_44x.S               |    2 +
 arch/powerpc/mm/44x_mmu.c                    |    4 -
 arch/powerpc/platforms/40x/Kconfig           |   11 ++
 arch/powerpc/platforms/40x/ppc40x_simple.c   |    1 +
 arch/powerpc/platforms/44x/Kconfig           |   14 ++
 arch/powerpc/platforms/44x/Makefile          |    1 +
 arch/powerpc/platforms/44x/currituck.c       |  204 ++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.c             |   85 +++++++++-
 arch/powerpc/sysdev/ppc4xx_pci.h             |    7 +
 21 files changed, 1159 insertions(+), 14 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/currituck.dts
 create mode 100644 arch/powerpc/boot/dts/klondike.dts
 create mode 100644 arch/powerpc/boot/treeboot-currituck.c
 create mode 100644 arch/powerpc/configs/40x/klondike_defconfig
 create mode 100644 arch/powerpc/configs/44x/currituck_defconfig
 create mode 100644 arch/powerpc/platforms/44x/currituck.c
