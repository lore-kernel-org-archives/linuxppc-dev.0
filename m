Return-Path: <stephen.neuendorffer@xilinx.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: <grant.likely@secretlab.ca>, <dirk.brandewie@gmail.com>,
	<devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>,
	<microblaze-uclinux@itee.uq.edu.au>
Subject: [PATCH 0/7] add of_fdt_unflatten_tree
Date: Thu, 18 Nov 2010 15:54:55 -0800
In-Reply-To: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cce2a5ec-536b-4668-8bbe-ae413cb435ac@VA3EHSMHS006.ehs.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Currently, fdt blobs are handled solely at boot time.  However,
it may be useful to parse blobs into device trees after boot time.  For
instance, a PCIe device may have an FPGA which includes a device
tree.  This set of patches locally refactors the existing code to enable
this.

Patch 1 and 4-7 are the interesting bits.
Patch 2 and 3 provide the ability to use this code on x86, and are provided mostly for reference.

The non-early boot code has been compile-tested and executed on X86.

Stephen Neuendorffer (7):
  fdt: Add Kconfig for EARLY_FLATTREE
  arch/x86: Add support for device tree code.
  arch/x86: select OF and OF_FLATTREE
  fdt.c: Add non-boottime device tree functions
  fdt.c: Refactor unflatten_dt_node
  fdt.c: Reorder unflatten_dt_node
  fdt.c: Refactor unflatten_device_tree and add fdt_unflatten_tree

 arch/microblaze/Kconfig    |    1 +
 arch/powerpc/Kconfig       |    1 +
 arch/x86/Kconfig           |    2 +
 arch/x86/include/asm/irq.h |    2 +
 arch/x86/kernel/irq.c      |   11 ++
 drivers/of/Kconfig         |    5 +
 drivers/of/fdt.c           |  393 ++++++++++++++++++++++++++------------------
 include/linux/of_fdt.h     |   13 ++
 8 files changed, 272 insertions(+), 156 deletions(-)



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
