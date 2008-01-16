Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD8D5DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 23:50:53 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0GBlp4b007027
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 06:47:51 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0GCom0B092564
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 05:50:48 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0GComig026092
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 05:50:48 -0700
Date: Wed, 16 Jan 2008 06:49:16 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Please pull from 'for-2.6.25' branch of 4xx tree
Message-ID: <20080116064916.2829f4a4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.25

to pick up a small number of changes for 2.6.25.  Mostly Xilinx stuff
from Stephen and Grant, with a couple of EMAC enables and a bug fix.

I'll likely send another pull request with some more patches from
Stefan and David, as well as the PIKA Warp platform patches.  But I
need to look at those a bit longer.

josh

Grant Likely (1):
      [POWERPC] 4xx: typo in calling machine_device_initcall() for Sequoia board

Hollis Blanchard (1):
      [POWERPC] 4xx: enable built-in networking for Sequoia defconfig

Josh Boyer (1):
      Merge branch 'virtex-for-2.6.25' of git://git.secretlab.ca/git/linux-2.6-v

Matthias Fuchs (1):
      [POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper

Stefan Roese (2):
      [POWERPC] 4xx: Add EMAC support to Kilauea defconfig
      [POWERPC] 4xx: PCIe: Increase max busses per port to 64

Stephen Neuendorffer (5):
      [POWERPC] Xilinx: update compatible list for interrupt controller
      [POWERPC] Xilinx: Add correct compatible list for device tree bus bindings
      [POWERPC] Xilinx: Update booting-without-of.
      [POWERPC] Xilinx: updated device tree compatibility to match uboot bsp gen
      [POWERPC] Xilinx uartlite: Section type fixups

 Documentation/powerpc/booting-without-of.txt |   56 +++++++++++-------
 arch/powerpc/boot/4xx.c                      |   81 +++++++++++++++++++++++--
 arch/powerpc/boot/4xx.h                      |    1 +
 arch/powerpc/boot/dcr.h                      |    5 ++
 arch/powerpc/boot/serial.c                   |    3 +-
 arch/powerpc/configs/bamboo_defconfig        |    4 +-
 arch/powerpc/configs/kilauea_defconfig       |   23 +++++++-
 arch/powerpc/configs/sequoia_defconfig       |   24 ++++++-
 arch/powerpc/platforms/40x/virtex.c          |   12 ++++-
 arch/powerpc/platforms/44x/sequoia.c         |    2 +-
 arch/powerpc/sysdev/ppc4xx_pci.c             |    2 +-
 arch/powerpc/sysdev/xilinx_intc.c            |    8 ++-
 drivers/serial/uartlite.c                    |    6 +-
 13 files changed, 180 insertions(+), 47 deletions(-)
