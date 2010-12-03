Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 8AAE7B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 10:58:06 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFCv3 0/2] CARMA Board Support
Date: Fri,  3 Dec 2010 15:57:38 -0800
Message-Id: <1291420660-25733-1-git-send-email-iws@ovro.caltech.edu>
Cc: linux-kernel@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

This is the third posting of these drivers, taking into account comments
from earlier postings. The DMAEngine patches are in mainline now, and
therefore are not part of this series anymore.

RFCv2 -> RFCv3:
- use miscdevice framework (removing the carma class)
- add bitfile readback capability to the programmer

RFCv1 -> RFCv2:
- change comments to kerneldoc format
- Kconfig improvements
- use the videobuf_dma_sg API in the programmer
- updates for Freescale DMAEngine DMA_SLAVE API changes

Information about the CARMA board:

The CARMA board is essentially an MPC8349EA MDS reference design with a
1GHz ADC and 4 high powered data processing FPGAs connected to the local
bus. It is all packed into a compact PCI form factor. It is used at the
Owens Valley Radio Observatory as the main component in the correlator
system.

For more information, see this webpage, maintained by the board's hardware
engineer: http://www.mmarray.org/~dwh/carma_board/index.html

These drivers are the necessary pieces to get the data processing FPGAs
working and producing data. Despite the fact that the hardware is custom
and we are the only users, I'd still like to get the drivers upstream.
Several people have suggested that this is possible.

Some further patches will be forthcoming. I have a driver for the LED
subsystem and the PPS subsystem. The LED register layout is expected to
change soon, so I won't post the driver until that is finished. The PPS
driver will be posted seperately from this patch series; it is very
generic.

Thanks to everyone who has provided comments on earlier versions!

Ira W. Snyder (2):
  misc: add CARMA DATA-FPGA Access Driver
  misc: add CARMA DATA-FPGA Programmer support

 drivers/misc/Kconfig                    |    1 +
 drivers/misc/Makefile                   |    1 +
 drivers/misc/carma/Kconfig              |   18 +
 drivers/misc/carma/Makefile             |    2 +
 drivers/misc/carma/carma-fpga-program.c | 1084 +++++++++++++++++++++++
 drivers/misc/carma/carma-fpga.c         | 1433 +++++++++++++++++++++++++++++++
 6 files changed, 2539 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/carma/Kconfig
 create mode 100644 drivers/misc/carma/Makefile
 create mode 100644 drivers/misc/carma/carma-fpga-program.c
 create mode 100644 drivers/misc/carma/carma-fpga.c

-- 
1.7.2.2
