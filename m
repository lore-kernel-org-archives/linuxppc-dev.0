Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 0/8] ppc64 little endian bug fixes
Date: Thu, 12 Dec 2013 15:59:33 +1100
Message-Id: <1386824381-14032-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are a number of little endian fixes found during testing of
2.6.13-*. Some of the interesting things:

A patch from Uli that fixes a nasty bug in PTRACE_PEEKUSR, basically
we always get FPR0 no matter which one we ask for.

Also included is a fix for the pseries NVRAM code, without it we
corrupt NVRAM and end up with particular hard to fix issues, since
we don't have easy ways to edit the contents of NVRAM.

Fixed other endian issues in crash dump, lparcfg and MSI code.

Anton Blanchard (7):
  powerpc: Fix endian issue in setup-common.c
  powerpc: Fix topology core_id endian issue on LE builds
  powerpc/pseries: Fix endian issues in /proc/ppc64/lparcfg
  powerpc/pseries: Fix endian issues in nvram code
  powerpc/pseries: Fix PCIE link speed endian issue
  powerpc/pseries: Fix endian issues in MSI code
  powerpc: Fix endian issues in crash dump code

Ulrich Weigand (1):
  powerpc: PTRACE_PEEKUSR always returns FPR0

 arch/powerpc/kernel/crash_dump.c         |  6 ++---
 arch/powerpc/kernel/ptrace.c             |  4 +--
 arch/powerpc/kernel/setup-common.c       |  4 +--
 arch/powerpc/kernel/smp.c                |  4 +--
 arch/powerpc/platforms/pseries/lparcfg.c | 12 ++++-----
 arch/powerpc/platforms/pseries/msi.c     | 28 ++++++++++---------
 arch/powerpc/platforms/pseries/nvram.c   | 46 ++++++++++++++++----------------
 arch/powerpc/platforms/pseries/pci.c     |  8 +++---
 8 files changed, 57 insertions(+), 55 deletions(-)

-- 
1.8.3.2
