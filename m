Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 6F20FDDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 15:17:29 +1000 (EST)
Date: Wed, 20 Jun 2007 15:17:29 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2.6.22] Fix powermac late initcall to only run when required.
Message-ID: <20070620051729.GQ9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: sfr@canb.auug.org.au, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Tony Breeds <tony@bakeyournoodle.com>

Fix powermac late initcall to only run when required.

Current ppc64_defconfig kernel fail to boo on iSeries dieing with:
---
NET: Registered protocol family 17
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc00000000071b258
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=32 iSeries
<snip>
NIP [c00000000071b258] .iSeries_src_init+0x34/0x64
LR [c000000000701bb4] .kernel_init+0x1fc/0x3bc
Call Trace:
[c000000007d0be30] [0000000000008000] 0x8000 (unreliable)
[c000000007d0bea0] [c000000000701bb4] .kernel_init+0x1fc/0x3bc
[c000000007d0bf90] [c0000000000262d4] .kernel_thread+0x4c/0x68
Instruction dump:
e922cba8 3880ffff 78840420 f8010010 f821ff91 60000000 e8090000 78095fe3 
4182002c e922cb58 e862cbb0 e9290140 <e8090000> f8410028 7c0903a6 e9690010 
Kernel panic - not syncing: Attempted to kill init!
---

This is because powermac is unconditionally sets ppc_md.progress to NULL.
This patch makes sure the powermac late initcall is only run on powermac
machines.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 arch/powerpc/platforms/powermac/setup.c |    3 +++
 1 file changed, 3 insertions(+)

Index: working/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- working.orig/arch/powerpc/platforms/powermac/setup.c	2007-06-20 14:55:27.000000000 +1000
+++ working/arch/powerpc/platforms/powermac/setup.c	2007-06-20 14:59:48.000000000 +1000
@@ -454,6 +454,9 @@ static int initializing = 1;
 
 static int pmac_late_init(void)
 {
+	if (!machine_is(powermac))
+		return -ENODEV;
+
 	initializing = 0;
 	/* this is udbg (which is __init) and we can later use it during
 	 * cpu hotplug (in smp_core99_kick_cpu) */
