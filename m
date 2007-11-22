Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 602E3DE493
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:56 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:54 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/10] powerpc: Make crashkernels ignore crashkernel
	reservations
Message-ID: <20071122154654.GA26570@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If a user requests a crash kernel to reserve crashkernel memory,
the kernel fails to boot.  While the user shouldn't do that, it
is easy to check for and makes it possible to use the same command
line for crash kernels as for the initial kernel.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/kernel/machine_kexec.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 38c1c1a..733726a 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -94,6 +94,14 @@ void __init reserve_crashkernel(void)
 		printk("Crash kernel location must be 0x%x\n",
 				KDUMP_KERNELBASE);
 
+	if (PHYSICAL_START == KDUMP_KERNELBASE) {
+		printk("Already running a crashkernel, "
+			"ignoring crashkernel reservation\n");
+		crashk_res.start = 0;
+		crashk_res.end = 0;
+		return;
+	}
+
 	crashk_res.start = KDUMP_KERNELBASE;
 	crash_size = PAGE_ALIGN(crash_size);
 	crashk_res.end = crashk_res.start + crash_size - 1;
-- 
1.5.3.4
