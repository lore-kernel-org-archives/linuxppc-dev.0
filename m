Return-Path: <romeo.cane.ext@coriant.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0088.outbound.protection.outlook.com [157.55.234.88])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 821E41A0A5E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 20:01:21 +1000 (EST)
Date: Fri, 3 Oct 2014 11:00:46 +0100
From: Romeo Cane <romeo.cane.ext@coriant.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix sys_call_table declaration
Message-ID: <20141003100046.GB2144@rcane-VirtualBox>
References: <20141002144131.GA3855@rcane-VirtualBox>
 <1412285674.28143.35.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1412285674.28143.35.camel@pasglop>
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

On Fri, Oct 03, 2014 at 07:34:34AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2014-10-02 at 15:41 +0100, Romeo Cane wrote:
> > Declaring sys_call_table as a pointer causes the compiler to generate the wrong lookup code in arch_syscall_addr
> 
> Care to elaborate ?
> 
> Ben.
> 
> > Signed-off-by: Romeo Cane <romeo.cane.ext@coriant.com>
> > ---
> >  arch/powerpc/include/asm/syscall.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > index b54b2ad..528ba9d 100644
> > --- a/arch/powerpc/include/asm/syscall.h
> > +++ b/arch/powerpc/include/asm/syscall.h
> > @@ -17,7 +17,7 @@
> >  
> >  /* ftrace syscalls requires exporting the sys_call_table */
> >  #ifdef CONFIG_FTRACE_SYSCALLS
> > -extern const unsigned long *sys_call_table;
> > +extern const unsigned long sys_call_table[];
> >  #endif /* CONFIG_FTRACE_SYSCALLS */
> >  
> >  static inline long syscall_get_nr(struct task_struct *task,
> 
>

Hi Ben,

this is the arch_syscall_addr function from kernel/trace/trace_syscalls.c:

unsigned long __init __weak arch_syscall_addr(int nr)
{
    return (unsigned long)sys_call_table[nr];
}

on my platform (E500MC) the generated assembly code is as follows:

without the patch:
  <arch_syscall_addr>:
     lis     r9,-16384
     rlwinm  r3,r3,2,0,29
     lwz     r11,30640(r9)
     lwzx    r3,r11,r3
     blr

with the patch:
  <arch_syscall_addr>:
     lis     r9,-16384
     rlwinm  r3,r3,2,0,29
     addi    r9,r9,30640
     lwzx    r3,r9,r3
     blr


the goal of the function is to retrieve the n-th element of the table (i.e. the address of a syscall)
Without the patch, the returned value is in fact the memory content pointed by the address of the first syscall plus an offset, that is not what we want.
The consequence is that ftrace of syscalls doesn't work.

That table has always been declared as a pointer since the support for syscalls tracing has been introduced for powerpc years ago, so I'm wondering why nobody else had this problem before.
Other architectures are not affected since in their includes the table is already declared as an array.


Romeo
 
