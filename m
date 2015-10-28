Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 973011A0B72
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 23:48:52 +1100 (AEDT)
From: <igal.liberman@freescale.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>, <madalin.bucur@freescale.com>,
 <pebolle@tiscali.nl>, <joakim.tjernlund@transmode.se>, <ppc@mindchasers.com>,
 <stephen@networkplumber.org>, <davem@davemloft.net>, Igal Liberman
 <igal.liberman@freescale.com>
Subject: [v6, 0/6] Freescale DPAA FMan
Date: Wed, 28 Oct 2015 10:53:43 +0200
Message-ID: <1446022429-31621-1-git-send-email-igal.liberman@freescale.com>
Reply-To: <igal.liberman@freescale.com>
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

From: Igal Liberman <igal.liberman@freescale.com>

The Freescale Data Path Acceleration Architecture (DPAA) is a set
of hardware components on specific QorIQ multicore processors.
This architecture provides the infrastructure to support
simplified sharing of networking interfaces and accelerators
by multiple CPU cores and the accelerators.

One of the DPAA accelerators is the Frame Manager (FMan)
which contains a series of hardware blocks: ports, Ethernet MACs,
a multi user RAM (MURAM) and Storage Profile (SP).

This patch set introduce the FMan drivers.
Each driver configures and initializes the corresponding
FMan hardware module (described above).
The MAC driver offers support for three different
types of MACs (eTSEC, TGEC, MEMAC).

v5 --> v6:
	- Addressed feedback from Scott:
		- Moved kernel doc to source files
		- Removed a series of configurable settings
		- Miscellaneous code updates

v4 --> v5:
	- Addressed feedback from David Miller:
		- Removed driver layering
		- Reduce namespace pollution
		- Reduce code complexity and size

v3 --> v4:
	- Remove device_initcall call in driver registration (redundant)
	- Remove hot/cold labels
	- Minor update in FMan Clock read from device-tree
	- Update fixed-link support
	- Addressed feedback from Stephen Hemminger
		- Remove bogus blank line

v2 --> v3:
	- Addressed feedback from Scott:
		- Remove typedefs
		- Remove unnecessary memory barriers
		- Remove unnecessary casting
		- Remove KConfig options
		- Remove early_params
		- Remove Hungarian notation
		- Remove __packed__  attribute and padding from structures
		- Remove unlikely attribute (where it's not needed)
		- Use proper error codes and remove unnecessary prints
		- Use proper values for sleep routines
		- Replace complex Macros with functions
		- Improve device tree processing code
		- Use symbolic defines
		- Add time-out in busy-wait loops
		- Removed exit code (loadable module support will be added later)
	- Fixed "fixed-link" issue raised by Joakim Tjernlund

v1 --> v2:
	- Addressed feedback from Paul Bolle:
		- General feedback of FMan Driver layer
		- Remove Errata defines
		- Aligned comments to Kernel Doc
		- Remove Loadable Module support (not yet supported)
		- Removed not needed KConfig dependencies
	- Addressed feedback from Scott Wood
		- Use Kernel ioread/iowrite services
		- Squash FLIB source and header patches together

This submission is based on the prior Freescale DPAA FMan V3,RFC submission.
Several issues addresses in this submission:
	- Reduced MAC layering and complexity
	- Reduced code base
	- T1024/T2080 10G best effort support

Igal Liberman (6):
  fsl/fman: Add FMan MURAM support
  fsl/fman: Add FMan support
  fsl/fman: Add FMan MAC support
  fsl/fman: Add FMan SP support
  fsl/fman: Add FMan Port Support
  fsl/fman: Add FMan MAC driver

 drivers/net/ethernet/freescale/Kconfig             |    1 +
 drivers/net/ethernet/freescale/Makefile            |    2 +
 drivers/net/ethernet/freescale/fman/Kconfig        |    8 +
 drivers/net/ethernet/freescale/fman/Makefile       |    7 +
 .../net/ethernet/freescale/fman/crc_mac_addr_ext.h |  314 +++
 drivers/net/ethernet/freescale/fman/fman.c         | 2896 ++++++++++++++++++++
 drivers/net/ethernet/freescale/fman/fman.h         |  329 +++
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   | 1608 +++++++++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h   |   59 +
 drivers/net/ethernet/freescale/fman/fman_mac.h     |  276 ++
 drivers/net/ethernet/freescale/fman/fman_memac.c   | 1307 +++++++++
 drivers/net/ethernet/freescale/fman/fman_memac.h   |   60 +
 drivers/net/ethernet/freescale/fman/fman_muram.c   |  159 ++
 drivers/net/ethernet/freescale/fman/fman_muram.h   |   51 +
 drivers/net/ethernet/freescale/fman/fman_port.c    | 1800 ++++++++++++
 drivers/net/ethernet/freescale/fman/fman_port.h    |  151 +
 drivers/net/ethernet/freescale/fman/fman_sp.c      |  167 ++
 drivers/net/ethernet/freescale/fman/fman_sp.h      |  103 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |  798 ++++++
 drivers/net/ethernet/freescale/fman/fman_tgec.h    |   55 +
 drivers/net/ethernet/freescale/fman/mac.c          |  980 +++++++
 drivers/net/ethernet/freescale/fman/mac.h          |   97 +
 22 files changed, 11228 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/fman/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/fman/Makefile
 create mode 100644 drivers/net/ethernet/freescale/fman/crc_mac_addr_ext.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_dtsec.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_dtsec.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_mac.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_memac.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_memac.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_muram.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_muram.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_port.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_port.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_sp.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_sp.h
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_tgec.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_tgec.h
 create mode 100644 drivers/net/ethernet/freescale/fman/mac.c
 create mode 100644 drivers/net/ethernet/freescale/fman/mac.h

--
1.7.9.5
