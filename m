Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <f4219729e8da75f5176347d176430d4b8b0fcb8a.1211287582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Add kernstart_addr to list of allowed symbols in prom_init
Date: Tue, 20 May 2008 22:48:03 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	kamalesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since commit "85xx: Add support for relocatable kernel (and
booting at non-zero)" (37dd2badcfcec35f5e21a0926968d77a404f03c3),
PHYSICAL_START is #defined as kernstart_addr if RELOCATABLE
and FLATMEM is enabled.

PHYSICAL_START is used in prom_init.c and so kernstart_addr
needs to be added to the list of allowed symbols that
prom_init.c can access.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

Not sure if anyone is building this config in practice, but it
is broken in 26 without this patch.

 arch/powerpc/kernel/prom_init_check.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 8e24fc1..31729a9 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -20,7 +20,7 @@ WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
-reloc_got2"
+reloc_got2 kernstart_addr"
 
 NM="$1"
 OBJ="$2"
-- 
1.5.5
