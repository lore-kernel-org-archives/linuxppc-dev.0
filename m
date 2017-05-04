Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhZ5gjrzDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:37:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444Xw35093457
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:48 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7u1ad2vt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:48 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:45 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bZPa7930126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:43 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444bASk009548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:11 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] powerpc/livepatch: Clarify location of mcount call site
Date: Thu,  4 May 2017 10:06:20 +0530
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <def36fbe0eb1c6622ff49f56b3f1c9545e5aef3b.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing comment around the location of mcount() call site in a
function is a bit confusing.

Depending on the gcc version, the mcount() call can either be the fourth
(gcc v6 and later) or the fifth instruction (gcc v5 and earlier) into a
function. So, the mcount call is actually within the first _20_ bytes of
a function.

However, ftrace_location_range() does an inclusive search and hence
passing (addr + 16) is still accurate.

Clarify the same by updating comments around this.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/livepatch.h | 4 ++--
 arch/powerpc/kernel/kprobes.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 47a03b9b528b..62f98d977f59 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -37,8 +37,8 @@ static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
 {
 	/*
-	 * Live patch works only with -mprofile-kernel on PPC. In this case,
-	 * the ftrace location is always within the first 16 bytes.
+	 * Live patch only works with -mprofile-kernel on PPC. In this case, the
+	 * ftrace location always starts within the first 16 bytes (inclusive).
 	 */
 	return ftrace_location_range(faddr, faddr + 16);
 }
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 562d18f456d7..4398ea60b4e0 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -62,8 +62,8 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 #ifdef CONFIG_KPROBES_ON_FTRACE
 		unsigned long faddr;
 		/*
-		 * Per livepatch.h, ftrace location is always within the first
-		 * 16 bytes of a function on powerpc with -mprofile-kernel.
+		 * Per livepatch.h, ftrace location always starts within the first
+		 * 16 bytes (inclusive) of a function with -mprofile-kernel.
 		 */
 		faddr = ftrace_location_range((unsigned long)addr,
 					      (unsigned long)addr + 16);
-- 
2.12.2
