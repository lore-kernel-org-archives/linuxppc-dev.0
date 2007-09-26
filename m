Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18170.17280.381728.905485@cargo.ozlabs.ibm.com>
Date: Wed, 26 Sep 2007 21:33:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Re: Please pull powerpc.git merge branch
In-Reply-To: <18168.62378.472571.655865@cargo.ozlabs.ibm.com>
References: <18168.62378.472571.655865@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> Linus,
> 
> Please do
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> to get a patch from Roland McGrath that fixes a user-triggerable oops
> on 64-bit powerpc.

I have added another commit from Jeremy Kerr fixing a mismerge that
caused a user visible ABI regression from 2.6.22.  The diffstat and
log below include both the patch from Roland and this new patch.

Thanks,
Paul.

 arch/powerpc/kernel/process.c            |    7 +++++++
 arch/powerpc/platforms/cell/spufs/file.c |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

commit 603c461250b223ac42c10b8d1df653af1a361d44
Author: Jeremy Kerr <jk@ozlabs.org>
Date:   Wed Sep 26 10:53:45 2007 +1000

    [POWERPC] spufs: fix mismerge, making context signal{1,2} files readable again
    
    The commit 8b6f50ef1d5cc86b278eb42bc91630fad455fb10 seems to have
    been affected by a mismerge of a duplicate patch
    (d054b36ffd302ec65aabec16a0c60ddd9e6b5a62) - both the
    spufs_dir_contents and spufs_dir_nosched_contents have been given
    write-only signal notification files.
    
    This change reverts the spufs_dir_contents array to use the
    readable signal notification file implementation.
    
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

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
