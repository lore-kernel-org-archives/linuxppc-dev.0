Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 1FA0347506
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 15:49:34 +1100 (EST)
Date: Tue, 6 Jan 2009 23:49:17 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: enable dynamic ftrace
Message-ID: <alpine.DEB.1.10.0901062346360.16964@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The PowerPC changes are now in mainline, you can now enable
dynamic ftrace on PowerPC.

The following patch is in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: ppc/ftrace-enable


Steven Rostedt (1):
      powerpc: enable dynamic ftrace

----
 arch/powerpc/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
---------------------------
commit 6a3c90c30ff47ca69e6315ca8968470a628585f5
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Thu Nov 20 07:55:57 2008 -0800

    powerpc: enable dynamic ftrace
    
    Impact: let PowerPC compile with dynamic ftrace
    
    This patch enables dynamic ftrace. The PowerPC port was dependent on
    other code not yet in mainline. Now that the code is, we can now
    let PowerPC compile with dynamic ftrace.
    
    Signed-off-by: Steven Rostedt <srostedt@redhat.com>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 79f25ce..6d4ae3f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -108,6 +108,8 @@ config ARCH_NO_VIRT_TO_BUS
 config PPC
 	bool
 	default y
+	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select HAVE_IDE
