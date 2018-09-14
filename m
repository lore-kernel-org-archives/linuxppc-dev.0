Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BZkF0q1ZzF326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 22:35:48 +1000 (AEST)
Message-Id: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net,
 stable@vger.kernel.org
Date: Fri, 14 Sep 2018 12:35:44 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a powerpc 8xx, 'btc' fails as follows:

Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
kdb> btc
btc: cpu status: Currently on cpu 0
Available cpus: 0
kdb_getarea: Bad address 0x0

when booting the kernel with 'debug_boot_weak_hash', it fails as well

Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
kdb> btc
btc: cpu status: Currently on cpu 0
Available cpus: 0
kdb_getarea: Bad address 0xba99ad80

On other platforms, Oopses have been observed too, see
https://github.com/linuxppc/linux/issues/139

This is due to btc calling 'btt' with %p pointer as an argument.

This patch replaces %p by %px to get the real pointer value as
expected by 'btt'

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: <stable@vger.kernel.org> # 4.15+
---
 kernel/debug/kdb/kdb_bt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 6ad4a9fcbd6f..7921ae4fca8d 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
 				kdb_printf("no process for cpu %ld\n", cpu);
 				return 0;
 			}
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			return 0;
 		}
 		kdb_printf("btc: cpu status: ");
 		kdb_parse("cpu\n");
 		for_each_online_cpu(cpu) {
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			touch_nmi_watchdog();
 		}
-- 
2.13.3
