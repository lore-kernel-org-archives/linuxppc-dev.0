Return-Path: <anton@ozlabs.org>
Date: Tue, 27 Oct 2009 15:51:57 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 5/6] powerpc: Disable HCALL_STATS by default
Message-ID: <20091027045157.GF3085@kryten>
References: <20091027044742.GB3085@kryten> <20091027044914.GC3085@kryten>
	<20091027045029.GD3085@kryten> <20091027045109.GE3085@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091027045109.GE3085@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The overhead of HCALL_STATS is quite high and the functionality is very
rarely used. Key statistics are also missing (eg min/max).

With the new hcall tracepoints much more powerful tracing can be done in
a kernel module. Lets disable this by default.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/pseries_defconfig	2009-10-27 14:56:58.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/pseries_defconfig	2009-10-27 14:57:11.000000000 +1100
@@ -1683,7 +1683,7 @@ CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
-CONFIG_HCALL_STATS=y
+# CONFIG_HCALL_STATS is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
