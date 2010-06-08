Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 0/6] OF device code merges and improvements
To: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:26:13 -0600
Message-ID: <20100608142152.26088.1108.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches merge more common of_device code between microblaze and
powerpc and some other miscellaneous improvement in preparation for
the merge of of_platform_bus_type with platform_bus_type.

These patches are based on top of the IRQ and address code merge which
I posted earlier.  If you want to test them, I've pushed the commits
out to the here:

git://git.secretlab.ca/git/linux-2.6 devicetree-next

Cheers,
g.

---

Grant Likely (6):
      of: Use full node name in resource structures
      of/device: merge of_device_uevent
      of: Modify of_device_get_modalias to be passed struct device
      of/device: Merge of_platform_bus_probe()
      of: Merge of_device_alloc
      of/device: populate platform_device (of_device) resource table on allocation


 arch/microblaze/include/asm/device.h      |    3 
 arch/microblaze/include/asm/of_device.h   |   21 ---
 arch/microblaze/include/asm/of_platform.h |   33 ----
 arch/microblaze/kernel/Makefile           |    2 
 arch/microblaze/kernel/of_device.c        |  112 ---------------
 arch/microblaze/kernel/of_platform.c      |  141 ++-----------------
 arch/powerpc/include/asm/device.h         |    3 
 arch/powerpc/include/asm/of_device.h      |   13 --
 arch/powerpc/include/asm/of_platform.h    |   11 -
 arch/powerpc/kernel/of_device.c           |  110 +-------------
 arch/powerpc/kernel/of_platform.c         |  131 -----------------
 drivers/macintosh/macio_sysfs.c           |    5 -
 drivers/of/address.c                      |    2 
 drivers/of/device.c                       |   62 +++++++-
 drivers/of/irq.c                          |    1 
 drivers/of/platform.c                     |  221 +++++++++++++++++++++++++++++
 include/linux/of_device.h                 |    6 +
 include/linux/of_platform.h               |   21 +++
 18 files changed, 337 insertions(+), 561 deletions(-)
 delete mode 100644 arch/microblaze/kernel/of_device.c
