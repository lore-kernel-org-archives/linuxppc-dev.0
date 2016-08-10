Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8MKJ70JszDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 16:52:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: ptrace: tm_reclaim_current() in
 flush_tmregs_to_thread()
In-Reply-To: <20160810054446.5624-1-cyrilbur@gmail.com>
References: <20160810054446.5624-1-cyrilbur@gmail.com>
Date: Wed, 10 Aug 2016 16:52:36 +1000
Message-ID: <87a8glt8sr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cyril Bur <cyrilbur@gmail.com> writes:

> There was an assumption that flush_tmregs_to_thread() would only be
> called for a task which is not current. And a warning could be shown
> to indicate that current is being ptraced.
>
> In the event of a core dump the current threads state is needed. This
> means that flush_tmregs_to_thread() must do its best to flush even for
> current.
>
> This patch also moves flush_tmregs_to_thread() into ptrace.c as it is
> only called from that file.
>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

I munged the change log a bunch:

  powerpc/ptrace: Fix coredump since ptrace TM changes
  
  Commit 8d460f6156cd ("powerpc/process: Add the function
  flush_tmregs_to_thread") added flush_tmregs_to_thread() and included
  the assumption that it would only be called for a task which is not
  current.
  
  Although this is correct for ptrace, when generating a core dump, some
  of the routines which call flush_tmregs_to_thread() are called. This
  leads to a WARNing such as:
  
    Not expecting ptrace on self: TM regs may be incorrect
    ------------[ cut here ]------------
    WARNING: CPU: 123 PID: 7727 at arch/powerpc/kernel/process.c:1088 flush_tmregs_to_thread+0x78/0x80
    CPU: 123 PID: 7727 Comm: libvirtd Not tainted 4.8.0-rc1-gcc6x-g61e8a0d #1
    task: c000000fe631b600 task.stack: c000000fe63b0000
    NIP: c00000000001a1a8 LR: c00000000001a1a4 CTR: c000000000717780
    REGS: c000000fe63b3420 TRAP: 0700   Not tainted  (4.8.0-rc1-gcc6x-g61e8a0d)
    MSR: 900000010282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 28004222  XER: 20000000
    ...
    NIP [c00000000001a1a8] flush_tmregs_to_thread+0x78/0x80
    LR [c00000000001a1a4] flush_tmregs_to_thread+0x74/0x80
    Call Trace:
     flush_tmregs_to_thread+0x74/0x80 (unreliable)
     vsr_get+0x64/0x1a0
     elf_core_dump+0x604/0x1430
     do_coredump+0x5fc/0x1200
     get_signal+0x398/0x740
     do_signal+0x54/0x2b0
     do_notify_resume+0x98/0xb0
     ret_from_except_lite+0x70/0x74
  
  So fix flush_tmregs_to_thread() to detect the case where it is called on
  current, and a transaction is active, and in that case flush the TM regs
  to the thread_struct.
  
  This patch also moves flush_tmregs_to_thread() into ptrace.c as it is
  only called from that file.
  
  Fixes: 8d460f6156cd ("powerpc/process: Add the function flush_tmregs_to_thread")
  Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
  [mpe: Flesh out change log]
  Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
