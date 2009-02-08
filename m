Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 4778EDDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Feb 2009 17:22:43 +1100 (EST)
Date: Sun, 8 Feb 2009 01:22:40 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] ftrace, powerpc64: fix math to calculate offset in TOC
Message-ID: <alpine.DEB.1.10.0902080118480.30802@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
	Remis Lima Baima <remis.developer@googlemail.com>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

I found the bug that was causing large modules to fail in setting
up dynamic ftrace. It wound up being a simple math error. To calculate
the offset in the TOC, I had used an OR, but the bottom half was
a signed extended short, and it should have been an addition.
The fix is in my tree below, as well as posted here.

-- Steve


The following patch is in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: ppc/ftrace


Steven Rostedt (1):
      ftrace, powerpc64: fix math to calculate offset in TOC

----
 arch/powerpc/kernel/ftrace.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
---------------------------
commit 60e611577d908119bb515ead908a46b025a4c9f9
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Sat Feb 7 22:00:26 2009 -0800

    ftrace, powerpc64: fix math to calculate offset in TOC
    
    Impact: fix dynamic ftrace with large modules in PPC64
    
    The math to calculate the offset into the TOC that is taken from reading
    the trampoline is incorrect. The bottom half of the offset is a signed
    extended short. The current code was using an OR to create the offset
    when it should have been using an addition.
    
    Signed-off-by: Steven Rostedt <srostedt@redhat.com>

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 88c641d..4112175 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -191,8 +191,9 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
-	offset = (unsigned)((unsigned short)jmp[0]) << 16 |
-		(unsigned)((unsigned short)jmp[1]);
+	/* The bottom half is signed extended */
+	offset = ((unsigned)((unsigned short)jmp[0]) << 16) +
+		(int)((short)jmp[1]);
 
 	pr_debug(" %x ", offset);
 
