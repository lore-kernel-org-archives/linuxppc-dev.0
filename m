Date: Tue, 23 Dec 2003 09:46:19 -0500
Subject: NULL-pointer dereference in ELF core dump, and proposed fix
From: John Whitney <john.whitney@timesys.com>
To: "Mailing List: linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Message-ID: <BC0DBF6B.3126%john.whitney@timesys.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

As stated in the subject, I've found a NULL-pointer dereference in the ELF
core dump code path, and wanted comments on my proposed solution.

In fs/binfmt_elf.c, elf_core_dump() calls elf_dump_thread_status().
elf_dump_thread_status calls elf_core_copy_task_fpregs() (elfcore.h), with a
second parameter (struct pt_regs *regs) of NULL.

This inlined routine in turn calls dump_fpu() (arch/ppc/kernel/process.c),
again with a NULL "regs" parameter.

dump_fpu immediately dereferences the regs parameter with the line:

if (regs->msr & MSR_FP)
    giveup_fpu (current);

This, obviously, causes a kernel oops.  My proposed solution to this problem
is to change the above line of code to

if (last_task_used_math == current)
    giveup_fpu (current);

Anyone see any problems with this change?

Thanks,
John Whitney


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
