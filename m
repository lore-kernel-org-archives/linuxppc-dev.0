Return-Path: <adrian.bunk@movial.fi>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 19504DDF43
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 06:18:16 +1100 (EST)
Date: Fri, 28 Dec 2007 20:56:49 +0200
From: Adrian Bunk <adrian.bunk@movial.fi>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Randy Dunlap <randy.dunlap@oracle.com>, phil.el@wanadoo.fr,
	paulus@samba.org
Subject: [2.6.24 patch] restore Cell OProfile support
Message-ID: <20071228185649.GC4738@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, oprofile-list@lists.sf.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch restores the Cell OProfile support that was killed by
commit 09cadedbdc01f1a4bea1f427d4fb4642eaa19da9.

Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>

---

 kernel/Kconfig.instrumentation |    8 ++++++++
 1 file changed, 8 insertions(+)

6d1446d35d367fdbdd2a0a29e0d156646ff40630 
diff --git a/kernel/Kconfig.instrumentation b/kernel/Kconfig.instrumentation
index a76635d..9d143e6 100644
--- a/kernel/Kconfig.instrumentation
+++ b/kernel/Kconfig.instrumentation
@@ -53,2 +53,10 @@ config HARDWARE_PM
 
+config OPROFILE_CELL
+	bool "OProfile for Cell Broadband Engine"
+	depends on PPC && (SPU_FS = y && OPROFILE = m) || (SPU_FS = y && OPROFILE = y) 
+	default y
+	help
+	  Profiling of Cell BE SPUs requires special support enabled
+	  by this option.
+
 config KPROBES
