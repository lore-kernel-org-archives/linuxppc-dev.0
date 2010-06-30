Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0EEC1B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 16:04:23 +1000 (EST)
Date: Wed, 30 Jun 2010 16:04:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix compile errors in prom_init_check for gcc 4.5
Message-Id: <20100630160422.3087bdf0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just whitelist these extra compiler generated symbols.
Fixes these errors:

Error: External symbol '_restgpr0_14' referenced from prom_init.c
Error: External symbol '_restgpr0_20' referenced from prom_init.c
Error: External symbol '_restgpr0_22' referenced from prom_init.c
Error: External symbol '_restgpr0_24' referenced from prom_init.c
Error: External symbol '_restgpr0_25' referenced from prom_init.c
Error: External symbol '_restgpr0_26' referenced from prom_init.c
Error: External symbol '_restgpr0_27' referenced from prom_init.c
Error: External symbol '_restgpr0_28' referenced from prom_init.c
Error: External symbol '_restgpr0_29' referenced from prom_init.c
Error: External symbol '_restgpr0_31' referenced from prom_init.c
Error: External symbol '_savegpr0_14' referenced from prom_init.c
Error: External symbol '_savegpr0_20' referenced from prom_init.c
Error: External symbol '_savegpr0_22' referenced from prom_init.c
Error: External symbol '_savegpr0_24' referenced from prom_init.c
Error: External symbol '_savegpr0_25' referenced from prom_init.c
Error: External symbol '_savegpr0_26' referenced from prom_init.c
Error: External symbol '_savegpr0_27' referenced from prom_init.c
Error: External symbol '_savegpr0_28' referenced from prom_init.c
Error: External symbol '_savegpr0_29' referenced from prom_init.c
Error: External symbol '_savegpr0_31' referenced from prom_init.c

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom_init_check.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 1ac136b..9f82f49 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -52,12 +52,18 @@ do
 	if [ "${UNDEF:0:9}" = "_restgpr_" ]; then
 		OK=1
 	fi
+	if [ "${UNDEF:0:10}" = "_restgpr0_" ]; then
+		OK=1
+	fi
 	if [ "${UNDEF:0:11}" = "_rest32gpr_" ]; then
 		OK=1
 	fi
 	if [ "${UNDEF:0:9}" = "_savegpr_" ]; then
 		OK=1
 	fi
+	if [ "${UNDEF:0:10}" = "_savegpr0_" ]; then
+		OK=1
+	fi
 	if [ "${UNDEF:0:11}" = "_save32gpr_" ]; then
 		OK=1
 	fi
-- 
1.7.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
