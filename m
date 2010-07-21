Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id AD01CB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 07:13:45 +1000 (EST)
Received: from mail78-va3 (localhost.localdomain [127.0.0.1])	by
	mail78-va3-R.bigfish.com (Postfix) with ESMTP id 5AF2E7A014A	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2010 21:13:38 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.239])	by
	mail78-va3.bigfish.com (Postfix) with ESMTP id 2B334118004F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2010 21:13:38 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6LLDa9j009039	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 14:13:36 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] kexec/crash support on mpc85xx parts
Date: Wed, 21 Jul 2010 16:14:52 -0500
Message-ID: <1279746894-29529-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch series is meant to fix a few issues with kexec/crash working
on mpc85xx parts

v1: initial version

v2: Fix a typo when decremeting a wait condition twice leading to 
never showing when we fail waiting for extra cpus to shutdown

Moved around code so the crash and kexec shutdown code paths both
work correctly - this was exposed by the above fix

Disable modifying the PAGE_OFFSET and PHYSICAL_START when we build
a crash kernel w/ relocation enabled. We don't need to change these 
values as a default action.

Matthew McClintock (2):
  powerpc/85xx: kexec for SMP 85xx BookE systems
  powerpc/crashdump: Fix issues with kexec and 36bit physical addr

 arch/powerpc/Kconfig                |   10 +++---
 arch/powerpc/kernel/crash_dump.c    |    4 +-
 arch/powerpc/kernel/machine_kexec.c |   10 +++---
 arch/powerpc/platforms/85xx/smp.c   |   63 +++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 12 deletions(-)
