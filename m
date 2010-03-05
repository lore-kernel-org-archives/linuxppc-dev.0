Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 17:42:56 -0300
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 00/13] powerpc/47x: Support for 476 core - Version 2
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add support for the 476 core.  The goal is to have a single
binary that will run on both 44x and 47x, but we still have some details to
work out.  The biggest is that the L1 cache line size differs on the two
platforms, but it's currently a compile-time option.

The code was originally written by Ben Herrenschmidt and Torez Smith, but
I've been maintaining it.  I'll take responsibility for the content, but I
can't take all the credit.

The first patch is a generic bookE feature.  Patches 2-5 add base 47x
support.  Patches 6 & 7 add a platform to support the ISS simulator, and
patches 8-13 add workarounds for DD1 and DD1.1 hardware bugs.

It's not yet decided if the workaround patches will make it into mainline.
Most likely the last one will not, since it applies only to the earlier DD1
hardware which probably won't be in use nearly as long as the DD1.1 chips.

These patches are also available via git from the "version2" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/ppc476.git

Changes since first posting on March 1, 2010:

- Added KERN level to printk's in machine_check_47x and reduced the indent
- fixed PVR values in cputable.c
- replaced re-definition of STACK_FRAME_REGS_MARKER with include of ptrace.h
- removed PPC_44x_46x config option
- Kconfig: ISS4xx shouldn't select 440GP for 47x
- Separate out DD1 workaround from DD1.1 workarounds

-- 
Dave Kleikamp
IBM Linux Technology Center
