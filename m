Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0df71JczF29P
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:13:10 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KAdjQ131496
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:13:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h4fun9te9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:13:08 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:13:07 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 07/10] powerpc64/kexec: Hard disable ftrace before
 switching to the new kernel
Date: Wed,  4 Apr 2018 01:42:22 +0530
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <d7b2a1c5f6a57822b604363615c885d294305f63.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
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

Now that we have a more effective way to completely disable ftrace on
ppc64, let's also use that before switching to a new kernel during
kexec.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 2694d078741d..936c7e2d421e 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -98,12 +98,14 @@ void machine_kexec(struct kimage *image)
 	int save_ftrace_enabled;
 
 	save_ftrace_enabled = __ftrace_enabled_save();
+	this_cpu_disable_ftrace();
 
 	if (ppc_md.machine_kexec)
 		ppc_md.machine_kexec(image);
 	else
 		default_machine_kexec(image);
 
+	this_cpu_enable_ftrace();
 	__ftrace_enabled_restore(save_ftrace_enabled);
 
 	/* Fall back to normal restart if we're still alive. */
-- 
2.16.2
