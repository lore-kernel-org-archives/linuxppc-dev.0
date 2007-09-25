Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18168.62378.472571.655865@cargo.ozlabs.ibm.com>
Date: Tue, 25 Sep 2007 21:40:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a patch from Roland McGrath that fixes a user-triggerable oops
on 64-bit powerpc.

Thanks,
Paul.

 arch/powerpc/kernel/process.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

commit 474f81967217f3bec2389ae913da72641f2c40e3
Author: Roland McGrath <roland@redhat.com>
Date:   Mon Sep 24 16:52:44 2007 -0700

    [POWERPC] Ensure FULL_REGS on exec
    
    When PTRACE_O_TRACEEXEC is used, a ptrace call to fetch the registers at
    the PTRACE_EVENT_EXEC stop (PTRACE_PEEKUSR) will oops in CHECK_FULL_REGS.
    With recent versions, "gdb --args /bin/sh -c 'exec /bin/true'" and "run" at
    the (gdb) prompt is sufficient to produce this.  I also have written an
    isolated test case, see https://bugzilla.redhat.com/show_bug.cgi?id=301791#c15.
    
    This change fixes the problem by clearing the low bit of pt_regs.trap in
    start_thread so that FULL_REGS is true again.  This is correct since all of
    the GPRs that "full" refers to are cleared in start_thread.
    
    Signed-off-by: Roland McGrath <roland@redhat.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
