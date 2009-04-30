Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFD34DE3FE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 10:01:31 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 0/8] section name cleanup for powerpc
Date: Thu, 30 Apr 2009 19:56:09 -0400
Message-Id: <1241135777-9462-1-git-send-email-tabbott@mit.edu>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@mit.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Tim Abbott <tabbott@mit.edu>,
	Waseem Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series cleans up the section names on the powerpc
architecture.  It requires the architecture-independent macro
definitions from this patch series:

<http://www.spinics.net/lists/mips/msg33499.html>

The long-term goal here is to add support for building the kernel with
-ffunction-sections -fdata-sections.  This requires renaming all the
magic section names in the kernel of the form .text.foo, .data.foo,
.bss.foo, and .rodata.foo to not have collisions with sections
generated for code like:

static int nosave = 0; /* -fdata-sections places in .data.nosave */
static void head(); /* -ffunction-sections places in .text.head */

Note that these patches have not been boot-tested (aside from testing
the analogous changes on x86), since I don't have access to the
appropriate hardware.

	-Tim Abbott


Tim Abbott (8):
  powerpc: Remove unused __page_aligned macro.
  powerpc: share .data output section definition between 32 and 64
    bits.
  powerpc: Use macros for .data.page_aligned section.
  powerpc: use NOSAVE_DATA macro for .data.nosave section.
  powerpc: use new macro for .data.cacheline_aligned section.
  powerpc: use new macros for .data.init_task.
  powerpc: use new macro for .data.read_mostly section.
  powerpc: convert to new generic read_mostly support.

 arch/powerpc/Kconfig                        |    3 ++
 arch/powerpc/include/asm/cache.h            |    4 --
 arch/powerpc/include/asm/page_64.h          |    8 ----
 arch/powerpc/kernel/init_task.c             |    3 +-
 arch/powerpc/kernel/machine_kexec_64.c      |    4 +-
 arch/powerpc/kernel/vdso.c                  |    3 +-
 arch/powerpc/kernel/vdso32/vdso32_wrapper.S |    3 +-
 arch/powerpc/kernel/vdso64/vdso64_wrapper.S |    3 +-
 arch/powerpc/kernel/vmlinux.lds.S           |   47 ++++++--------------------
 9 files changed, 23 insertions(+), 55 deletions(-)
