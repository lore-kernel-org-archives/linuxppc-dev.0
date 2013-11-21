Return-Path: <anton@samba.org>
Date: Thu, 21 Nov 2013 16:33:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 fengguang.wu@intel.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 imunsie@au1.ibm.com
Subject: [PATCH] powerpc: allyesconfig should not select
 CONFIG_CPU_LITTLE_ENDIAN
Message-ID: <20131121163355.7b7d42a5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Stephen reported a failure in an allyesconfig build.  
CONFIG_CPU_LITTLE_ENDIAN=y gets set but his toolchain is not
new enough to support little endian. We really want to
default to a big endian build; Ben suggested using a choice
which defaults to CPU_BIG_ENDIAN.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -404,13 +404,27 @@ config PPC_DOORBELL
 
 endmenu
 
-config CPU_LITTLE_ENDIAN
-	bool "Build little endian kernel"
-	default n
+choice
+	prompt "Endianness selection"
+	default CPU_BIG_ENDIAN
 	help
 	  This option selects whether a big endian or little endian kernel will
 	  be built.
 
+config CPU_BIG_ENDIAN
+	bool "Build big endian kernel"
+	help
+	  Build a big endian kernel.
+
+	  If unsure, select this option.
+
+config CPU_LITTLE_ENDIAN
+	bool "Build little endian kernel"
+	help
+	  Build a little endian kernel.
+
 	  Note that if cross compiling a little endian kernel,
 	  CROSS_COMPILE must point to a toolchain capable of targeting
 	  little endian powerpc.
+
+endchoice
