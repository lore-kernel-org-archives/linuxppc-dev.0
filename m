Return-Path: <ananth@in.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D4042C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 22:46:00 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 22 Mar 2013 05:45:57 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2AB241FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:40:56 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MBjkH0059052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:45:49 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MBjkEx004749
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:45:46 -0600
Date: Fri, 22 Mar 2013 17:15:43 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] uprobes/powerpc: teach uprobes to ignore gdb breakpoints
Message-ID: <20130322114543.GH26183@in.ibm.com>
References: <20130322114446.GG26183@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322114446.GG26183@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, oleg@redhat.com,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Powerpc has many trap variants that could be used by entities like gdb.
Currently, running gdb on a program being traced by uprobes causes an
endless loop since uprobes doesn't understand that the trap was inserted
by some other entity and a SIGTRAP needs to be delivered.

Teach uprobes to ignore breakpoints that do not belong to it.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/uprobes.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
===================================================================
--- linux-3.9-rc3.orig/arch/powerpc/kernel/uprobes.c
+++ linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
@@ -31,6 +31,16 @@
 #define UPROBE_TRAP_NR	UINT_MAX
 
 /**
+ * is_trap_insn - check if the instruction is a trap variant
+ * @insn: instruction to be checked.
+ * Returns true if @insn is a trap variant.
+ */
+bool is_trap_insn(uprobe_opcode_t *insn)
+{
+	return (is_trap(*insn));
+}
+
+/**
  * arch_uprobe_analyze_insn
  * @mm: the probed address space.
  * @arch_uprobe: the probepoint information.
