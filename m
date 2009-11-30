Return-Path: <albert_herranz@yahoo.es>
Received: from smtp125.mail.ukl.yahoo.com (smtp125.mail.ukl.yahoo.com
	[77.238.184.56]) by ozlabs.org (Postfix) with SMTP id D2F0E1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 10:09:52 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 0/3] rework of usbgecko-based early debug
Date: Tue,  1 Dec 2009 00:09:47 +0100
Message-Id: <cover.1259609263.git.albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is a rework of the previously posted patch:
- [RFC PATCH v2 08/11] powerpc: gamecube/wii: early debugging using usbgecko

It tries to implement the ideas suggested by Benjamin Herrenschmidt
regarding the use of a fixmap entry to provide a valid I/O mapping
immediately after MMU_init runs and MMU is definitively enabled.

Albert Herranz (3):
  powerpc: udbg: add early remap hook
  powerpc: udbg: add fixmap entry for early debug
  powerpc: gamecube/wii: early debugging using usbgecko

 arch/powerpc/Kconfig.debug                         |    8 +++
 arch/powerpc/include/asm/fixmap.h                  |    3 +
 arch/powerpc/include/asm/udbg.h                    |    4 +
 arch/powerpc/kernel/head_32.S                      |   21 +++++++
 arch/powerpc/kernel/udbg.c                         |    5 ++
 arch/powerpc/mm/init_32.c                          |   10 +++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   59 ++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |    2 +
 8 files changed, 112 insertions(+), 0 deletions(-)
