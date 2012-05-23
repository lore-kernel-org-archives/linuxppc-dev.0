Return-Path: <anton@samba.org>
Date: Wed, 23 May 2012 13:58:41 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH] powerpc: Enable jump label support
Message-ID: <20120523135841.22e9dac4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When looking through some instruction traces I noticed our tracepoint
checks were inline. It turns out we don't have CONFIG_JUMP_LABEL
enabled.

By enabling CONFIG_JUMP_LABEL we replace a load/compare/branch with
a nop at every tracepoint call. For example in do_IRQ:

CONFIG_JUMP_LABEL disabled:
        stdx 3,11,9
        lwz 0,8(29)
        cmpwi 7,0,0
        bne- 7,.L124
        bl .irq_enter

CONFIG_JUMP_LABEL enabled:
        stdx 3,11,9     
        nop
        bl .irq_enter  

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-build.orig/arch/powerpc/configs/ppc64_defconfig	2012-04-05 13:47:45.691857096 +1000
+++ linux-build/arch/powerpc/configs/ppc64_defconfig	2012-05-23 13:14:04.254270594 +1000
@@ -16,6 +16,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_KPROBES=y
+CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
Index: linux-build/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-build.orig/arch/powerpc/configs/pseries_defconfig	2012-04-05 13:47:45.691857096 +1000
+++ linux-build/arch/powerpc/configs/pseries_defconfig	2012-05-23 13:14:59.783222304 +1000
@@ -24,6 +24,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_KPROBES=y
+CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
