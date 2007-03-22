Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17922.1718.441879.244422@cargo.ozlabs.ibm.com>
Date: Thu, 22 Mar 2007 15:31:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

I have three more powerpc bug fixes to go in for 2.6.21, so please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

The full commit messages are below.

Thanks,
Paul.

 arch/powerpc/kernel/process.c                   |    9 ++++-
 arch/powerpc/platforms/pseries/hvCall.S         |   41 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/lpar.c           |    2 +
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   16 +++++++++
 include/asm-powerpc/hvcall.h                    |   14 ++++++++
 5 files changed, 78 insertions(+), 4 deletions(-)

commit 4f5fa2fb1259f506d20e8af447117ec3ec426a53
Author: Anton Blanchard <anton@samba.org>
Date:   Tue Mar 20 14:29:54 2007 -0500

    [POWERPC] Bypass hcall stats until cpu features have run
    
    I noticed that we execute hcalls before cpu feature code has run (eg
    for setting up the bolted kernel region).  This means that we may be
    executing code that is not appropriate for the processor we have.
    Create an unconditional branch that we nop out all the time to fix this.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit b4aea36b7956eeebfc56314ce0944db1441255ce
Author: Mohan Kumar M <mohan@in.ibm.com>
Date:   Wed Mar 21 11:21:32 2007 +0530

    [POWERPC] Avoid hypervisor statistics calculation in real mode
    
    kexec invokes plpar_hcall hypervisor call in real mode.  plpar_hcall
    refers to per cpu variables for accounting hypervisor statistics.
    These variables may not be in the RMO region, so accesses to them
    in real mode may result in a data storage exception.
    
    This fixes this problem by using a new plpar_hcall_raw function which
    does not update the hypervisor call statistics.  Thanks to Anton for
    suggesting this idea.
    
    Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit f144e7c7272bf527c380bffaa5e789dc28a09d8d
Author: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date:   Sat Mar 10 03:23:03 2007 -0500

    [POWERPC] Fix atomicity of TIF update in flush_thread()
    
    Fix atomicity of TIF update in flush_thread() for powerpc
    
    Fixes it correctly with *_ti_thread_flag.
    
    Race :
    
    parent process executing :
    sys_ptrace()
     (lock_kernel())
     (ptrace_get_task_struct(pid))
     arch_ptrace()
       ptrace_detach()
         ptrace_disable(child);
           clear_singlestep(child);
             clear_tsk_thread_flag(child, TIF_SINGLESTEP);
             (which clears the TIF_SINGLESTEP flag atomically from a different
              process)
     (put_task_struct(child))
     (unlock_kernel())
    
    And at the same time, in the child process :
    sys_execve()
     do_execve()
       search_binary_handler()
         load_elf_binary()
           flush_old_exec()
             flush_thread()
               doing a non-atomic thread flag update
    
    Applies on 2.6.20.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
