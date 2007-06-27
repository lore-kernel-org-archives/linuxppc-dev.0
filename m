Return-Path: <dgibson@ozlabs.org>
Date: Wed, 27 Jun 2007 17:10:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] First cut at PReP support for arch/powerpc
Message-ID: <20070627071008.GA30648@localhost.localdomain>
References: <20070627065335.GD11191@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070627065335.GD11191@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is an implementation to allow PReP systems to boot under the
arch/powerpc codebase, one of the few remaining platforms supported in
arch/ppc but not so far in arch/powerpc.

This support is still fairly incomplete - it needs to obtain a lot
more device information from the residual data and put it into the
device tree, rather than relying on hardcoded values (both in the code
and in prep.dts).  Likewise many peripherals will not be supported -
in particular the RTC is not yet supported, so the time will generally
be wrong.

Still, it should do enough to boot on a number of PReP machines, and
makes a reasonable start.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Too big for the list, the patch is at:
	http://ozlabs.org/~dgibson/home/prep-support

 arch/powerpc/Kconfig.debug           |    7 
 arch/powerpc/boot/Makefile           |    8 
 arch/powerpc/boot/dts/prep.dts       |  130 ++++
 arch/powerpc/boot/mkprep.c           |  178 ++++++
 arch/powerpc/boot/pnp.h              |  640 ++++++++++++++++++++++
 arch/powerpc/boot/prep.c             |  150 +++++
 arch/powerpc/boot/residual.h         |  313 ++++++++++
 arch/powerpc/boot/wrapper            |    7 
 arch/powerpc/configs/prep_defconfig  | 1006 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S        |   27 
 arch/powerpc/kernel/setup_32.c       |    1 
 arch/powerpc/kernel/udbg.c           |    2 
 arch/powerpc/kernel/udbg_16550.c     |   28 
 arch/powerpc/platforms/Makefile      |    1 
 arch/powerpc/platforms/prep/Kconfig  |    3 
 arch/powerpc/platforms/prep/Makefile |    4 
 arch/powerpc/platforms/prep/nvram.c  |  135 ++++
 arch/powerpc/platforms/prep/pci.c    |   66 ++
 arch/powerpc/platforms/prep/setup.c  |  720 +++++++++++++++++++++++++
 include/asm-powerpc/residual.h       |  350 ++++++++++++
 include/asm-powerpc/udbg.h           |    1 
 21 files changed, 3772 insertions(+), 5 deletions(-)
