Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH v2 0/5] Consolidate OF IRQ handling code
To: microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Jun 2010 16:30:11 -0600
Message-ID: <20100621222052.18925.61569.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series merges the common IRQ handling code between Microblaze and Powerpc

Changes in v2:
- The 3 patches to merge of_irq_find_parent(), of_irq_map_raw() and
  of_irq_map_one() have been merged into a single patch.
- Patch added to move powermac quirk handing into
  arch/powerpc/platforms/powermac.
- Add endian fixes patch from Rob Herring

Ben, please take a look and let me know if you like this better.

Thanks,
g.

---

Grant Likely (4):
      of/irq: Move irq_of_parse_and_map() to common code
      of/microblaze: strip out of_irq_workarounds code
      of/powerpc: Move Powermac irq quirk code into powermac pic driver code
      of/irq: merge irq mapping code

Rob Herring (1):
      of/irq: little endian fixes


 arch/microblaze/include/asm/irq.h     |   13 -
 arch/microblaze/include/asm/prom.h    |   67 ------
 arch/microblaze/kernel/irq.c          |   14 -
 arch/microblaze/kernel/prom_parse.c   |  331 -------------------------------
 arch/powerpc/include/asm/irq.h        |   13 -
 arch/powerpc/include/asm/prom.h       |   68 ------
 arch/powerpc/kernel/irq.c             |   14 -
 arch/powerpc/kernel/prom_parse.c      |  351 ---------------------------------
 arch/powerpc/platforms/powermac/pic.c |   72 ++++++-
 arch/sparc/include/asm/prom.h         |    1 
 drivers/of/Kconfig                    |    4 
 drivers/of/Makefile                   |    1 
 drivers/of/irq.c                      |  339 ++++++++++++++++++++++++++++++++
 drivers/of/of_mdio.c                  |    1 
 include/linux/of_irq.h                |   70 +++++++
 15 files changed, 487 insertions(+), 872 deletions(-)
 create mode 100644 drivers/of/irq.c
 create mode 100644 include/linux/of_irq.h
