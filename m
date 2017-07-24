Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGNYp47p2zDqx9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 00:10:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/udbg: Reduce the footgun potential of
 EARLY_DEBUG_LPAR(_HVSI)
Date: Tue, 25 Jul 2017 00:10:15 +1000
Message-Id: <1500905415-32225-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For debugging very early boot problems we have CONFIG_PPC_EARLY_DEBUG,
which allows configuring the kernel such that it unconditionally writes
to a particular type of console, regardless of whether that console
exists or not. This is useful sometimes when the kernel crashes before
it can even determine what platform it's on, and therefore what consoles
exist.

However if you boot a kernel built this way on a different platform, it
will generally crash because it writes to a console that doesn't exist.

A particularly nasty instance of this is if you enable the hypervisor
console early debug, and then boot that kernel on bare metal. The result
is that the kernel calls "the hypervisor" very early in boot, but the
kernel *is* the hypervisor, so we jump to the system call handler and
start executing all sorts of code that isn't ready to be run. This may
lead to a machine check or check stop depending on how lucky you are.

Luckily there is an easy way to avoid this particular case. We simply
read the MSR before installing the hooks, and if we see MSR_HV is set
then we are the hypervisor and we definitely should not use the
hypervisor console.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/tty/hvc/hvc_vio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index b05dc5086627..6ffbdd8d50c5 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -442,6 +442,14 @@ void __init hvc_vio_init_early(void)
 #ifdef CONFIG_PPC_EARLY_DEBUG_LPAR
 void __init udbg_init_debug_lpar(void)
 {
+	/*
+	 * If we're running as a hypervisor then we definitely can't call the
+	 * hypervisor to print debug output (we *are* the hypervisor), so don't
+	 * register if we detect that MSR_HV=1.
+	 */
+	if (mfmsr() & MSR_HV)
+		return;
+
 	hvterm_privs[0] = &hvterm_priv0;
 	hvterm_priv0.termno = 0;
 	hvterm_priv0.proto = HV_PROTOCOL_RAW;
@@ -455,6 +463,10 @@ void __init udbg_init_debug_lpar(void)
 #ifdef CONFIG_PPC_EARLY_DEBUG_LPAR_HVSI
 void __init udbg_init_debug_lpar_hvsi(void)
 {
+	/* See comment above in udbg_init_debug_lpar() */
+	if (mfmsr() & MSR_HV)
+		return;
+
 	hvterm_privs[0] = &hvterm_priv0;
 	hvterm_priv0.termno = CONFIG_PPC_EARLY_DEBUG_HVSI_VTERMNO;
 	hvterm_priv0.proto = HV_PROTOCOL_HVSI;
-- 
2.7.4
