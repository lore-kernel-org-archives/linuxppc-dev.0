Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzj4f1hmyzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:42:09 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 00/37] PCI: Support for configurable PCI endpoint
Date: Thu, 12 Jan 2017 15:55:49 +0530
Message-ID: <1484216786-17292-1-git-send-email-kishon@ti.com>
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

The RFC series that was sent before this patch series can be found at [1].
The patches are split here so that it can be better reviewed.

This main purpose of this patch series is to
 *) add PCI endpoint core layer
 *) modifie designware/dra7xx driver to be configured in EP mode
 *) add a PCI endpoint *test* function driver and corresponding host
    driver

Major Improvements from RFC:
 *) support multi-function devices (hw supported not virtual)
 *) Access host side buffers
 *) Raise MSI interrupts
 *) Add user space program to use the host side PCI driver
 *) Adapt all other users of designware to use the new design (only
    compile tested. Since I have only dra7xx boards, the new design
    has only been tested in dra7xx. I'd require the help of others
    to test the platforms they have access to).

This patch series has been developed on top of 4.10-rc1, [2] & [3]

[1] -> https://lwn.net/Articles/700605/
[2] -> https://lkml.org/lkml/2016/12/28/34
[3] -> https://lkml.org/lkml/2017/1/11/238

I've also pushed the tree to
git://git.ti.com/linux-phy/linux-phy.git pci_ep_v1

Using PCI EPF Test:
ON THE EP SIDE:
***************
/* EP function is configured using configfs */
# mount -t configfs none /sys/kernel/config

/* PCI EP core layer creates "pci_ep" entry in configfs */
# cd /sys/kernel/config/pci_ep/

/*
 * This is the 1st step in creating an endpoint function. This
 * creates the endpoint device.
 */
# mkdir dev

/*
 * dev has 2 entries. *epc* for binding a EPC device and *epf*
 * is a directory containing all the functions of the endpoint
 */
# ls dev
epc  epf

/*
 * This creates the endpoint function device *instance*. The string
 * before the .<num> suffix will identify the driver this
 * EP function will bind to.
 * Just pci_epf_test is also valid. The .<num> suffix is used
 * if there are multiple PCI controllers and all of them wants
 * to use the same function.
 */
# mkdir dev/epf/pci_epf_test.0

/*
 * When the above command is given, the function device will
 * also be bound to a function driver. To find the list of
 * function drivers available in the system, use the following
 * command. To create a new driver, the following can be referred
 * drivers/pci/endpoint/functions/pci-epf-test.c
 */
# ls /sys/bus/pci-epf/drivers
pci_epf_test

/* Now configure the endpoint function */
/* These are the fields that can be configured */
# ls dev/epf/pci_epf_test.0/
baseclass_code    function          progif_code       subsys_id
cache_line_size   interrupt_pin     revid             subsys_vendor_id
deviceid          msi_interrupts    subclass_code     vendorid

/* The function driver will populate these fields with default values */
# cat dev/epf/pci_epf_test.0/vendorid 
0xffff

# cat dev/epf/pci_epf_test.0/interrupt_pin
0x0001

/* The user can configure any of these fields */
# echo 0x104c > dev/epf/pci_epf_test.0/vendorid
# echo 16 > dev/epf/pci_epf_test.0/msi_interrupts

/*
 * Next is binding this function driver to the controller driver. In
 * order to find the possible controller drivers that this function
 * driver can be bound to, the following sysfs entry can be used
 */
# ls /sys/class/pci_epc/
51000000.pci

/* Now bind the function driver to the controller driver */
# echo "51000000.pcie_ep" > epc
[  494.743487] dra7-pcie 51000000.pcie: no free inbound window
[  494.749367] pci_epf_test pci_epf_test.0: failed to set BAR4
[  494.755238] dra7-pcie 51000000.pcie: no free inbound window
[  494.761451] pci_epf_test pci_epf_test.0: failed to set BAR5

/*
 * the above error messages are due to non availability of free
 * inbound windows. So the function drivers in dra7xx can use
 * only 4 (BAR0..BAR3) BARs
 */

/****** PCI endpoint is configured ******/

ON THE HOST SIDE:
*****************
# ./pcitest.sh 
BAR tests

BAR0:           OKAY
BAR1:           OKAY
BAR2:           OKAY
BAR3:           OKAY
BAR4:           NOT OKAY
BAR5:           NOT OKAY

Interrupt tests

LEGACY IRQ:     NOT OKAY
MSI1:           OKAY
MSI2:           OKAY
MSI3:           OKAY
MSI4:           OKAY
MSI5:           OKAY
MSI6:           OKAY
MSI7:           OKAY
MSI8:           OKAY
MSI9:           OKAY
MSI10:          OKAY
MSI11:          OKAY
MSI12:          OKAY
MSI13:          OKAY
MSI14:          OKAY
MSI15:          OKAY
MSI16:          OKAY
MSI17:          NOT OKAY
MSI18:          NOT OKAY
MSI19:          NOT OKAY
MSI20:          NOT OKAY
MSI21:          NOT OKAY
MSI22:          NOT OKAY
MSI23:          NOT OKAY
MSI24:          NOT OKAY
MSI25:          NOT OKAY
MSI26:          NOT OKAY
MSI27:          NOT OKAY
MSI28:          NOT OKAY
MSI29:          NOT OKAY
MSI30:          NOT OKAY
MSI31:          NOT OKAY
MSI32:          NOT OKAY

Read Tests

READ (      1 bytes):           OKAY
READ (   1024 bytes):           OKAY
READ (   1025 bytes):           OKAY
READ (1024000 bytes):           OKAY
READ (1024001 bytes):           OKAY

Write Tests

WRITE (      1 bytes):          OKAY
WRITE (   1024 bytes):          OKAY
WRITE (   1025 bytes):          OKAY
WRITE (1024000 bytes):          OKAY
WRITE (1024001 bytes):          OKAY

Copy Tests

COPY (      1 bytes):           OKAY
COPY (   1024 bytes):           OKAY
COPY (   1025 bytes):           OKAY
COPY (1024000 bytes):           OKAY
COPY (1024001 bytes):           OKAY

Kishon Vijay Abraham I (37):
  PCI: dwc: dra7xx: Group all host related setup in add_pcie_port
  PCI: dwc: designware: Add new *ops* for cpu addr fixup
  PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
  PCI: dwc: designware: Move the register defines to designware header
    file
  PCI: dwc: Add platform_set_drvdata
  PCI: dwc: Rename cfg_read/cfg_write to read/write
  PCI: dwc: designware: Get device pointer at the start of
    dw_pcie_host_init
  PCI: dwc: Split *struct pcie_port* into host only and core structures
  PCI: dwc: designware: Parse *num-lanes* property in dw_pcie_setup_rc
  PCI: dwc: designware: Fix style errors in pcie-designware.c
  PCI: dwc: Split pcie-designware.c into host and core      files
  PCI: dwc: Create a new config symbol to enable pci dwc host
  PCI: dwc: Remove dependency of designware to CONFIG_PCI
  PCI: endpoint: Add EP core layer to enable EP controller and EP
    functions
  Documentation: PCI: Guide to use PCI Endpoint Core Layer
  PCI: endpoint: Introduce configfs entry for configuring EP functions
  Documentation: PCI: Guide to use pci endpoint configfs
  Documentation: PCI: Add specification for the *pci test* function
    device
  PCI: endpoint: functions: Add an EP function to test PCI
  Documentation: PCI: Add binding documentation for pci-test endpoint
    function
  PCI: dwc: Modify dbi accessors to take dbi_base as argument
  PCI: dwc: Modify dbi accessors to access data of 4/2/1 bytes
  PCI: dwc: Add *ops* to start and stop pcie link
  PCI: dwc: designware: Add EP mode support
  dt-bindings: PCI: Add dt bindings for pci designware EP mode
  PCI: dwc: dra7xx: Facilitate wrapper and msi interrupts to be enabled
    independently
  PCI: dwc: dra7xx: Add EP mode support
  dt-bindings: PCI: dra7xx: Add dt bindings for pci dra7xx EP mode
  PCI: dwc: dra7xx: Workaround for errata id i870
  dt-bindings: PCI: dra7xx: Add dt bindings to enable legacy mode
  misc: Add host side pci driver for pci test function device
  Documentation: misc-devices: Add Documentation for pci-endpoint-test
    driver
  tools: PCI: Add a userspace tool to test PCI endpoint
  tools: PCI: Add sample test script to invoke pcitest
  MAINTAINERS: add PCI EP maintainer
  ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to
    SW_WKUP
  ARM: dts: DRA7: Add pcie1 dt node for EP mode

 Documentation/PCI/00-INDEX                         |    8 +
 .../PCI/endpoint/function/binding/pci-test.txt     |   17 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.txt    |   84 ++
 Documentation/PCI/endpoint/pci-endpoint.txt        |  190 +++++
 Documentation/PCI/endpoint/pci-test-function.txt   |   66 ++
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   41 +-
 Documentation/misc-devices/pci-endpoint-test.txt   |   35 +
 MAINTAINERS                                        |    9 +
 arch/arm/boot/dts/am572x-idk.dts                   |    7 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |    7 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    4 +
 arch/arm/boot/dts/dra7.dtsi                        |   22 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |    4 +
 arch/arm/mach-omap2/clockdomains7xx_data.c         |    2 +-
 drivers/Makefile                                   |    5 +
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/pci_endpoint_test.c                   |  533 ++++++++++++
 drivers/pci/Kconfig                                |    1 +
 drivers/pci/Makefile                               |    3 -
 drivers/pci/dwc/Kconfig                            |   73 +-
 drivers/pci/dwc/Makefile                           |    6 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  372 +++++++--
 drivers/pci/dwc/pci-exynos.c                       |   83 +-
 drivers/pci/dwc/pci-imx6.c                         |  142 ++--
 drivers/pci/dwc/pci-keystone-dw.c                  |   91 +-
 drivers/pci/dwc/pci-keystone.c                     |   56 +-
 drivers/pci/dwc/pci-keystone.h                     |    4 +-
 drivers/pci/dwc/pci-layerscape.c                   |   93 ++-
 drivers/pci/dwc/pcie-armada8k.c                    |   92 ++-
 drivers/pci/dwc/pcie-artpec6.c                     |   51 +-
 drivers/pci/dwc/pcie-designware-ep.c               |  342 ++++++++
 drivers/pci/dwc/pcie-designware-host.c             |  620 ++++++++++++++
 drivers/pci/dwc/pcie-designware-plat.c             |   29 +-
 drivers/pci/dwc/pcie-designware.c                  |  868 ++++----------------
 drivers/pci/dwc/pcie-designware.h                  |  254 +++++-
 drivers/pci/dwc/pcie-hisi.c                        |   60 +-
 drivers/pci/dwc/pcie-qcom.c                        |   72 +-
 drivers/pci/dwc/pcie-spear13xx.c                   |   85 +-
 drivers/pci/endpoint/Kconfig                       |   25 +
 drivers/pci/endpoint/Makefile                      |    7 +
 drivers/pci/endpoint/functions/Kconfig             |   12 +
 drivers/pci/endpoint/functions/Makefile            |    5 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |  513 ++++++++++++
 drivers/pci/endpoint/pci-ep-cfs.c                  |  427 ++++++++++
 drivers/pci/endpoint/pci-epc-core.c                |  548 ++++++++++++
 drivers/pci/endpoint/pci-epc-mem.c                 |  143 ++++
 drivers/pci/endpoint/pci-epf-core.c                |  347 ++++++++
 include/linux/mod_devicetable.h                    |   10 +
 include/linux/pci-epc.h                            |  141 ++++
 include/linux/pci-epf.h                            |  160 ++++
 include/uapi/linux/Kbuild                          |    1 +
 include/uapi/linux/pcitest.h                       |   19 +
 tools/pci/pcitest.c                                |  186 +++++
 tools/pci/pcitest.sh                               |   56 ++
 56 files changed, 5880 insertions(+), 1185 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-cfs.txt
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint.txt
 create mode 100644 Documentation/PCI/endpoint/pci-test-function.txt
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.txt
 create mode 100644 drivers/misc/pci_endpoint_test.c
 create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
 create mode 100644 drivers/pci/dwc/pcie-designware-host.c
 create mode 100644 drivers/pci/endpoint/Kconfig
 create mode 100644 drivers/pci/endpoint/Makefile
 create mode 100644 drivers/pci/endpoint/functions/Kconfig
 create mode 100644 drivers/pci/endpoint/functions/Makefile
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-test.c
 create mode 100644 drivers/pci/endpoint/pci-ep-cfs.c
 create mode 100644 drivers/pci/endpoint/pci-epc-core.c
 create mode 100644 drivers/pci/endpoint/pci-epc-mem.c
 create mode 100644 drivers/pci/endpoint/pci-epf-core.c
 create mode 100644 include/linux/pci-epc.h
 create mode 100644 include/linux/pci-epf.h
 create mode 100644 include/uapi/linux/pcitest.h
 create mode 100644 tools/pci/pcitest.c
 create mode 100644 tools/pci/pcitest.sh

-- 
1.7.9.5
