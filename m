Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 50455B7BBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 05:43:59 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 0/4] powerpc: wii: mem2 as ram support
Date: Tue,  8 Dec 2009 19:43:49 +0100
Message-Id: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patches add a series of workarounds to allow the use of
the second 64MB RAM block (MEM2) as normal memory on the Nintendo Wii
video game console.
Without these workarounds that portion of memory can't be used as it
is non-contiguous to the first memory block, and this is currently
unsupported on the PowerPC architecture for 32-bit systems.

This series complement the "powerpc: nintendo wii support" series.

Albert Herranz (4):
  wii: bootwrapper: add fixup to calc useable mem2
  wii: use both mem1 and mem2 as ram
  powerpc: allow ioremap within reserved memory regions
  powerpc: wii: allow ioremap within the memory hole

 arch/powerpc/boot/wii.c                  |  118 +++++++++++++++++++++++++++++-
 arch/powerpc/mm/init_32.c                |    9 ++
 arch/powerpc/mm/mmu_decl.h               |   11 +++-
 arch/powerpc/mm/pgtable_32.c             |   36 ++++++++-
 arch/powerpc/mm/ppc_mmu_32.c             |    4 +-
 arch/powerpc/platforms/embedded6xx/wii.c |   66 +++++++++++++++++
 include/linux/lmb.h                      |    1 +
 lib/lmb.c                                |    7 ++-
 8 files changed, 240 insertions(+), 12 deletions(-)
