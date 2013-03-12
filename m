Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: powerpc/ptrace: Fix brk.len used uninitialised
In-reply-to: <20130308102422.GA25184@frolo.macqel>
References: <20130306060058.GA3106@frolo.macqel>
 <21084.1362607788@ale.ozlabs.ibm.com> <20130306223645.GA15484@frolo.macqel>
 <31862.1362611670@ale.ozlabs.ibm.com> <20130307095907.GA16489@frolo.macqel>
 <22285.1362695571@ale.ozlabs.ibm.com> <11606.1362697414@ale.ozlabs.ibm.com>
 <20130308102422.GA25184@frolo.macqel>
Date: Tue, 12 Mar 2013 13:42:49 +1100
Message-ID: <3606.1363056169@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Philippe De Muyter <phdm@macqel.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With some CONFIGS it's possible that in ppc_set_hwdebug, brk.len is
uninitialised before being used.  It has been reported that GCC 4.2 will
produce the following error in this case:

  arch/powerpc/kernel/ptrace.c:1479: warning: 'brk.len' is used uninitialized in this function
  arch/powerpc/kernel/ptrace.c:1381: note: 'brk.len' was declared here

This patch corrects this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: Philippe De Muyter <phdm@macqel.be>

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 245c1b6..f9b30c6 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1428,6 +1428,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
 
 	brk.address = bp_info->addr & ~7UL;
 	brk.type = HW_BRK_TYPE_TRANSLATE;
+	brk.len = 8;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
 		brk.type |= HW_BRK_TYPE_READ;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
