Return-Path: <ananth@in.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76FB42C0093
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 18:17:25 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 6 Sep 2012 02:17:21 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C816019D8039
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 02:17:18 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q868HIGs214184
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2012 02:17:18 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q868HFWT016515
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2012 02:17:18 -0600
Date: Thu, 6 Sep 2012 13:47:04 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Rename opcode_t in probes.h to ppc_opcode_t
Message-ID: <20120906081704.GA362@in.ibm.com>
References: <20120906021929.GA16076@localhost>
 <1346900172.19098.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346900172.19098.17.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Meelis Roos <mroos@linux.ee>,
 Fengguang Wu <fengguang.wu@intel.com>, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2012 at 12:56:12PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2012-09-06 at 10:19 +0800, Fengguang Wu wrote:
> > Hi Ananth,
> > 
> > FYI, kernel build failed on
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
> > head:   8b64a9dfb091f1eca8b7e58da82f1e7d1d5fe0ad
> > commit: 8b7b80b9ebb46dd88fbb94e918297295cf312b59 [24/29] powerpc: Uprobes port to powerpc
> > config: powerpc-allmodconfig (attached as .config)
> > 
> > All related error/warning messages:
> > 
> > In file included from drivers/atm/fore200e.c:70:0:
> > drivers/atm/fore200e.h:263:3: error: redefinition of typedef 'opcode_t' with different type
> > arch/powerpc/include/asm/probes.h:25:13: note: previous declaration of 'opcode_t' was here
> 
> This is a bit more annoying. Ananth, do we need that to be called
> opcode_t for generic reasons or can we make it ppc_opcode_t ? If it has
> to remain, I suppose we can try to change that ATM driver to use a
> different type name...

We can make it ppc_opcode_t. Attached is the patch that fixes this.

Regards,
Ananth
---

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
head:   8b64a9dfb091f1eca8b7e58da82f1e7d1d5fe0ad
commit: 8b7b80b9ebb46dd88fbb94e918297295cf312b59 [24/29] powerpc: Uprobes port to powerpc
config: powerpc-allmodconfig (attached as .config)

All related error/warning messages:

In file included from drivers/atm/fore200e.c:70:0:
drivers/atm/fore200e.h:263:3: error: redefinition of typedef 'opcode_t' with different type
arch/powerpc/include/asm/probes.h:25:13: note: previous declaration of 'opcode_t' was here

Fix the namespace clash by making opcode_t in probes.h to ppc_opcode_t.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
Index: linux-tip-22aug/arch/powerpc/include/asm/probes.h
===================================================================
--- linux-tip-22aug.orig/arch/powerpc/include/asm/probes.h	2012-09-04 20:00:19.747069793 +0530
+++ linux-tip-22aug/arch/powerpc/include/asm/probes.h	2012-09-04 20:42:08.147286718 +0530
@@ -22,7 +22,7 @@
  */
 #include <linux/types.h>
 
-typedef u32 opcode_t;
+typedef u32 ppc_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
 
 /* Trap definitions per ISA */
Index: linux-tip-22aug/arch/powerpc/include/asm/uprobes.h
===================================================================
--- linux-tip-22aug.orig/arch/powerpc/include/asm/uprobes.h	2012-09-04 20:01:30.617071747 +0530
+++ linux-tip-22aug/arch/powerpc/include/asm/uprobes.h	2012-09-04 20:42:26.657287349 +0530
@@ -25,7 +25,7 @@
 #include <linux/notifier.h>
 #include <asm/probes.h>
 
-typedef opcode_t uprobe_opcode_t;
+typedef ppc_opcode_t uprobe_opcode_t;
 
 #define MAX_UINSN_BYTES		4
 #define UPROBE_XOL_SLOT_BYTES	(MAX_UINSN_BYTES)
Index: linux-tip-22aug/arch/powerpc/include/asm/kprobes.h
===================================================================
--- linux-tip-22aug.orig/arch/powerpc/include/asm/kprobes.h	2012-09-04 20:00:19.747069793 +0530
+++ linux-tip-22aug/arch/powerpc/include/asm/kprobes.h	2012-09-04 20:42:15.557286955 +0530
@@ -36,7 +36,7 @@
 struct pt_regs;
 struct kprobe;
 
-typedef opcode_t kprobe_opcode_t;
+typedef ppc_opcode_t kprobe_opcode_t;
 #define MAX_INSN_SIZE 1
 
 #ifdef CONFIG_PPC64
