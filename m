Return-Path: <galak@kernel.crashing.org>
Date: Mon, 11 Feb 2008 09:32:00 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Remove generated files on make clean
Message-ID: <Pine.LNX.4.64.0802110931490.29510@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

vmlinux.lds and dtc-parser.tab.h get created but never cleaned up.

---
 arch/powerpc/boot/Makefile   |    2 ++
 arch/powerpc/kernel/Makefile |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 49797a4..63d07cc 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -147,6 +147,8 @@ HOSTCFLAGS += -I$(src)/dtc-src/ -I$(src)/libfdt/
 targets += dtc-src/dtc-parser.tab.c
 targets += dtc-src/dtc-lexer.lex.c

+clean-files += dtc-src/dtc-parser.tab.h
+
 ifdef DTC_GENPARSER
 BISON = bison
 FLEX = flex
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0662ae4..c1baf9d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -104,3 +104,5 @@ quiet_cmd_systbl_chk = CALL    $<
 PHONY += systbl_chk
 systbl_chk: $(src)/systbl_chk.sh $(obj)/systbl_chk.i
 	$(call cmd,systbl_chk)
+
+clean-files := vmlinux.lds
-- 
1.5.3.8
