Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxKL13WX6zF1nt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 03:46:49 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27GjBj9147155
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 11:46:46 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gjjmrkph4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 11:46:46 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 16:46:42 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from 
Date: Wed,  7 Mar 2018 22:16:19 +0530
In-Reply-To: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't take a trap in most parts of real mode code. Instead of adding
the 'notrace' annotation to all C functions that can be invoked from
real mode, detect that we are in real mode on ftrace entry and return
back.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
This RFC only handles -mprofile-kernel to demonstrate the approach being 
considered. We will need to handle other ftrace entry if we decide to 
continue down this path.

- Naveen


 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..ecc0e8e38ead 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -56,6 +56,21 @@ _GLOBAL(ftrace_caller)
 
 	/* Load special regs for save below */
 	mfmsr   r8
+
+	/* Only proceed if we are not in real mode and can take interrupts */
+	andi.	r9, r8, MSR_IR|MSR_DR|MSR_RI
+	cmpdi	r9, MSR_IR|MSR_DR|MSR_RI
+	beq	1f
+	mflr	r8
+	mtctr	r8
+	REST_GPR(9, r1)
+	REST_GPR(8, r1)
+	addi	r1, r1, SWITCH_FRAME_SIZE
+	ld	r0, LRSAVE(r1)
+	mtlr	r0
+	bctr
+
+1:
 	mfctr   r9
 	mfxer   r10
 	mfcr	r11
-- 
2.16.1
