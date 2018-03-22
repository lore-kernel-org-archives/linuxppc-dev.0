Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406N9Y732VzF1tP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 21:25:53 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MAOvxj004128
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:25:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gv5r34dt9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:25:51 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 10:25:49 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: [PATCH v3 3/6] powerpc/kexec: Disable ftrace before switching to the
 new kernel
Date: Thu, 22 Mar 2018 15:55:23 +0530
In-Reply-To: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5589149f6dd1b627f5eadafa086fb5e716bc0622.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If function_graph tracer is enabled during kexec, we see the below
exception in the simulator:
	root@(none):/# kexec -e
	kvm: exiting hardware virtualization
	kexec_core: Starting new kernel
	[   19.262020070,5] OPAL: Switch to big-endian OS
	kexec: Starting switchover sequence.
	Interrupt to 0xC000000000004380 from 0xC000000000004380
	** Execution stopped: Continuous Interrupt, Instruction caused exception,  **

Now that we have a more effective way to disable ftrace, let's use that
before switching to a new kernel during kexec.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 2694d078741d..4a1b24a9dd61 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -95,16 +95,14 @@ void arch_crash_save_vmcoreinfo(void)
  */
 void machine_kexec(struct kimage *image)
 {
-	int save_ftrace_enabled;
-
-	save_ftrace_enabled = __ftrace_enabled_save();
+	get_paca()->ftrace_disabled = 1;
 
 	if (ppc_md.machine_kexec)
 		ppc_md.machine_kexec(image);
 	else
 		default_machine_kexec(image);
 
-	__ftrace_enabled_restore(save_ftrace_enabled);
+	get_paca()->ftrace_disabled = 0;
 
 	/* Fall back to normal restart if we're still alive. */
 	machine_restart(NULL);
-- 
2.16.2
