Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C9191A1748
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 23:15:19 +1100 (EST)
Message-ID: <1412684116.1268.0.camel@concordia>
Subject: Re: [PATCH] powerpc: fix sys_call_table declaration
From: Michael Ellerman <mpe@ellerman.id.au>
To: Romeo Cane <romeo.cane.ext@coriant.com>
Date: Tue, 07 Oct 2014 23:15:16 +1100
In-Reply-To: <20141003100046.GB2144@rcane-VirtualBox>
References: <20141002144131.GA3855@rcane-VirtualBox>
 <1412285674.28143.35.camel@pasglop>
 <20141003100046.GB2144@rcane-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-03 at 11:00 +0100, Romeo Cane wrote:
> On Fri, Oct 03, 2014 at 07:34:34AM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2014-10-02 at 15:41 +0100, Romeo Cane wrote:
> > > Declaring sys_call_table as a pointer causes the compiler to generate the wrong lookup code in arch_syscall_addr
> > 
> > Care to elaborate ?
> > 
> > > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > > index b54b2ad..528ba9d 100644
> > > --- a/arch/powerpc/include/asm/syscall.h
> > > +++ b/arch/powerpc/include/asm/syscall.h
> > > @@ -17,7 +17,7 @@
> > >  
> > >  /* ftrace syscalls requires exporting the sys_call_table */
> > >  #ifdef CONFIG_FTRACE_SYSCALLS
> > > -extern const unsigned long *sys_call_table;
> > > +extern const unsigned long sys_call_table[];
> > >  #endif /* CONFIG_FTRACE_SYSCALLS */
> > >  
> > >  static inline long syscall_get_nr(struct task_struct *task,
> 
> Hi Ben,
> 
> this is the arch_syscall_addr function from kernel/trace/trace_syscalls.c:
> 
> unsigned long __init __weak arch_syscall_addr(int nr)
> {
>     return (unsigned long)sys_call_table[nr];
> }
> 
> on my platform (E500MC) the generated assembly code is as follows:
> 
> without the patch:
>   <arch_syscall_addr>:
>      lis     r9,-16384
>      rlwinm  r3,r3,2,0,29
>      lwz     r11,30640(r9)
>      lwzx    r3,r11,r3
>      blr
> 
> with the patch:
>   <arch_syscall_addr>:
>      lis     r9,-16384
>      rlwinm  r3,r3,2,0,29
>      addi    r9,r9,30640
>      lwzx    r3,r9,r3
>      blr
> 
> 
> the goal of the function is to retrieve the n-th element of the table (i.e.
> the address of a syscall)
> Without the patch, the returned value is in fact the memory content pointed
> by the address of the first syscall plus an offset, that is not what we want.
> The consequence is that ftrace of syscalls doesn't work.
> 
> That table has always been declared as a pointer since the support for
> syscalls tracing has been introduced for powerpc years ago, so I'm wondering
> why nobody else had this problem before.
> Other architectures are not affected since in their includes the table is
> already declared as an array.

Yeah looks like you're right.

I've only ever used the raw_syscall tracing, which does work.

Worringly we also use sys_call_table as extern unsigned long * in vdso.c, so I
wonder if that is also broken.

cheers
