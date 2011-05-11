Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 25115B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:32 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <a8b749a3d0ac4e4da123c6abe344d2283a1ee637.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:41 -0500
Subject: [PATCH 03/37] powerpc/kdump64: Don't reference freed memory as pacas
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Starting with 1426d5a3bd07589534286375998c0c8c6fdc5260 (powerpc:
Dynamically allocate pacas) the space for pacas beyond cpu_possible
is freed, but we failed to update the loop in crash.c.

Since c1854e00727f50f7ac99e98d26ece04c087ef785 (powerpc: Set nr_cpu_ids
early and use it to free PACAs) the number of pacas allocated is
always nr_cpu_ids.

Signed-off-by: Milton Miller <miltonm@bga.com>
Cc: <stable@kernel.org> # .34.x
---
This is the simplest fix, and quite sutiable for stable.

We can merge the crash waits with the normal kexec waits later,
and fix the hole described in the other version.
---
 arch/powerpc/kernel/crash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 21f2c78..4e6ee94 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -236,7 +236,7 @@ static void crash_kexec_wait_realmode(int cpu)
 	int i;
 
 	msecs = 10000;
-	for (i=0; i < NR_CPUS && msecs > 0; i++) {
+	for (i=0; i < nr_cpu_ids && msecs > 0; i++) {
 		if (i == cpu)
 			continue;
 
-- 
1.7.0.4
