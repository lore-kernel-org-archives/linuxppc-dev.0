Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
	by ozlabs.org (Postfix) with ESMTP id 88A2CDDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 22:41:33 +1000 (EST)
Date: Wed, 25 Jul 2007 15:17:43 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: linuxppc-dev@ozlabs.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix ppc kernels after build-id addition
Message-ID: <Pine.SOC.4.64.0707251301200.21641@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch fixes arch/ppc kernels, at least for prep subarch, after 
build-id addition. Without the patch, kernels were 3 times the size and 
bootloader refused to load them. Now they are back to normal again.
The patch is very similar to David Millers sparc patch, just applied to 
ppc architecture.

Tested only with Roland McGrath's "Use LDFLAGS_MODULE only for .ko 
links" patch applied - boots and works fine.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/arch/ppc/kernel/vmlinux.lds.S b/arch/ppc/kernel/vmlinux.lds.S
index c0aac3f..98c1212 100644
--- a/arch/ppc/kernel/vmlinux.lds.S
+++ b/arch/ppc/kernel/vmlinux.lds.S
@@ -91,6 +91,8 @@ SECTIONS
   . = ALIGN(8192);
   .data.init_task : { *(.data.init_task) }
 
+  NOTES
+
   . = ALIGN(4096);
   __init_begin = .;
   .init.text : {

-- 
Meelis Roos (mroos@linux.ee)
