Return-Path: <robherring2@gmail.com>
Sender: Rob Herring <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] PCI generic configuration space accessors
Date: Fri,  9 Jan 2015 20:34:34 -0600
Message-Id: <1420857290-8373-1-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Tanmay Inamdar <tinamdar@apm.com>,
 Greg Ungerer <gerg@uclinux.org>, Alexandre Courbot <gnurou@gmail.com>,
 linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>,
 Stephen Warren <swarren@wwwdotorg.org>, Michal Simek <michal.simek@xilinx.com>,
 linux-arm-kernel@lists.infradead.org, cbe-oss-dev@lists.ozlabs.org,
 Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 Simon Horman <horms@verge.net.au>, Krzysztof Halasa <khalasa@piap.pl>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds common accessor functions for PCI configuration space
accesses. This supports most PCI hosts with memory mapped configuration
space like ECAM or hosts with memory mapped address/data registers. ECAM
is not generically supported by this series, but could be added on top
of this. While some hosts have standard address decoding which could be 
common as well, the various checks on bus numbers and device numbers are 
quite varied. It is unclear how much of that is really necessary or 
could be common. 

The first 4 patches are preparatory cleanup. Patch 5 introduces the
common accessors. The remaining patches convert several PCI host
controllers. This is in no way a complete list of host controllers. The
conversion of more hosts should be possible. The Designware controller
in particular should be able to be converted, but its config space
accessors are a mess of override-able functions that I've not gotten my
head around.

This series is available here [1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-config-access

Rob Herring (16):
  frv: add struct pci_ops member names to initialization
  mips: add struct pci_ops member names to initialization
  mn10300: add struct pci_ops member names to initialization
  powerpc: add struct pci_ops member names to initialization
  pci: introduce common pci config space accessors
  ARM: cns3xxx: convert PCI to use generic config accesses
  ARM: integrator: convert PCI to use generic config accesses
  ARM: sa1100: convert PCI to use generic config accesses
  ARM: ks8695: convert PCI to use generic config accesses
  powerpc: fsl_pci: convert PCI to use generic config accesses
  powerpc: powermac: convert PCI to use generic config accesses
  pci/host: generic: convert to use generic config accesses
  pci/host: rcar-gen2: convert to use generic config accesses
  pci/host: tegra: convert to use generic config accesses
  pci/host: xgene: convert to use generic config accesses
  pci/host: xilinx: convert to use generic config accesses

 arch/arm/mach-cns3xxx/pcie.c                   |  52 ++----
 arch/arm/mach-integrator/pci_v3.c              |  61 +-------
 arch/arm/mach-ks8695/pci.c                     |  77 +--------
 arch/arm/mach-sa1100/pci-nanoengine.c          |  94 +----------
 arch/frv/mb93090-mb00/pci-vdk.c                |   4 +-
 arch/mips/pci/pci-bcm1480.c                    |   4 +-
 arch/mips/pci/pci-octeon.c                     |   4 +-
 arch/mips/pci/pcie-octeon.c                    |  12 +-
 arch/mn10300/unit-asb2305/pci.c                |   4 +-
 arch/powerpc/platforms/cell/celleb_scc_pciex.c |   4 +-
 arch/powerpc/platforms/powermac/pci.c          | 209 +++++--------------------
 arch/powerpc/sysdev/fsl_pci.c                  |  46 +-----
 drivers/pci/access.c                           |  87 ++++++++++
 drivers/pci/host/pci-host-generic.c            |  51 +-----
 drivers/pci/host/pci-rcar-gen2.c               |  51 +-----
 drivers/pci/host/pci-tegra.c                   |  55 +------
 drivers/pci/host/pci-xgene.c                   | 150 ++----------------
 drivers/pci/host/pcie-xilinx.c                 |  88 ++---------
 include/linux/pci.h                            |  11 ++
 19 files changed, 212 insertions(+), 852 deletions(-)

-- 
2.1.0
