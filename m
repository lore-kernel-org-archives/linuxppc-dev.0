Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 7141EB6FAB
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2012 04:35:11 +1000 (EST)
Message-Id: <20120426183116.857877522@goodmis.org>
Date: Thu, 26 Apr 2012 14:31:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3][RFC] powerpc/ftrace: Removal of stop machine (and other
 goodies)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Benjamin,

You once told me on IRC that powerpc has no problem with modifying
code on one CPU that may be executing on another CPU. With the tests I
made on my PPC64 (2 CPUs) box, it seems to be the case.

The first patch removes stop_machine from powerpc. The other patches
add some error handling if ftrace detects an update didn't occur
with 'patch_instruction'.

This is just an RFC, but if it's fine, feel free to pull them into
your tree.

-- Steve

Steven Rostedt (3):
      ftrace/ppc: Have PPC skip updating with stop_machine()
      powerpc: Have patch_instruction detect faults
      ftrace/ppc: Use patch_instruction instead of probe_kernel_write()

----
 arch/powerpc/include/asm/code-patching.h |    4 +-
 arch/powerpc/kernel/ftrace.c             |   69 ++++++++++++++++++++++++------
 arch/powerpc/lib/code-patching.c         |   14 ++++--
 3 files changed, 68 insertions(+), 19 deletions(-)
