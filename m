Return-Path: <dirk.brandewie@gmail.com>
From: dirk.brandewie@gmail.com
To: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 0/5] Add the ability to link device blobs into vmlinux
Date: Tue, 16 Nov 2010 14:41:35 -0800
Message-Id: <cover.1289943240.git.dirk.brandewie@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	sodaville@linutronix.de, microblaze-uclinux@itee.uq.edu.au,
	dirk.brandewie@gmail.com, arjan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch set adds the ability to link device tree blob(s)
directly into the vmlinux image and specify the blob to be used via a
kernel command line option.

Patch 1 implements the changes to include/asm-generic/vmlinux.lds.h,
add generic rules for building and linking the DTB's into vmlinux.

Patch 2 adds the command line option, the functions for the
platform code to retrieve the value passed in and locate the matching
blob in the image.  This patch has been tested on x86.

Patch 3-5 show using the generic dts->dtb rule in x86, microblaze and
powerpc. The microblaze and powerpc patches have only been compile
tested.

Dirk Brandewie (5):
  of: Add support for linking device tree blobs into vmlinux
  of/fdt: add kernel command line option for dtb_compat string
  x86/of:  Add building device tree blob(s) into image.
  of/powerpc: Move build to use generic dts->dtb rule
  of/microblaze: Move build to use generic dts->dtb rule

 Documentation/kernel-parameters.txt |    7 +++++
 arch/microblaze/boot/Makefile       |   13 +--------
 arch/powerpc/boot/Makefile          |    7 -----
 arch/x86/Kconfig                    |    6 +++-
 arch/x86/kernel/Makefile            |    6 ++++
 arch/x86/kernel/dts/Kconfig         |    7 +++++
 drivers/of/fdt.c                    |   52 +++++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h   |   19 +++++++++++-
 include/linux/of_fdt.h              |    4 +++
 scripts/Makefile.lib                |   20 +++++++++++++
 10 files changed, 119 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/kernel/dts/Kconfig

-- 
1.7.2.3
