Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FA4CDDFF0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 11:38:51 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9C1co9b027825
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 11:38:50 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9C1gOxU248926
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 11:42:24 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9C1cYoY032022
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 11:38:34 +1000
Message-ID: <470ECFF7.9040008@au1.ibm.com>
Date: Fri, 12 Oct 2007 11:37:59 +1000
From: Mark Nelson <markn@au1.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 1/2] Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE #define
References: <20071011071558.676463639@au1.ibm.com>
	<20071011072208.075979098@au1.ibm.com>
	<DFC6881D-E917-4EC5-B19C-8CE04E040B06@kernel.crashing.org>
In-Reply-To: <DFC6881D-E917-4EC5-B19C-8CE04E040B06@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Oct 11, 2007, at 2:15 AM, markn@au1.ibm.com wrote:
> 
>> Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE in the coredump code which
>> allows for more flexibility in the note type for the state of 'extended
>> floating point' implementations in coredumps. New note types can now be
>> added with an appropriate #define.
>>
>> #define ELF_CORE_XFPREG_TYPE to be NT_PRXFPREG in all current users so
>> there's are no change in behaviour.
> 
> Can we make this ELF_CORE_VECREG_TYPE or something that is so coupled to
> the x86 specific name?
> 
>>
>> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
>> ---
>>  arch/ia64/ia32/elfcore32.h     |    1 +
>>  arch/x86_64/ia32/ia32_binfmt.c |    1 +
>>  fs/binfmt_elf.c                |    4 ++--
>>  include/asm-i386/elf.h         |    1 +
>>  4 files changed, 5 insertions(+), 2 deletions(-)
>>
>> Index: linux/arch/ia64/ia32/elfcore32.h
>> ===================================================================
>> --- linux.orig/arch/ia64/ia32/elfcore32.h
>> +++ linux/arch/ia64/ia32/elfcore32.h
>> @@ -117,6 +117,7 @@ elf_core_copy_task_fpregs(struct task_st
>>  }
>>
>>  #define ELF_CORE_COPY_XFPREGS 1
>> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>>  static inline int
>>  elf_core_copy_task_xfpregs(struct task_struct *tsk, elf_fpxregset_t
>> *xfpu)
>>  {
>> Index: linux/arch/x86_64/ia32/ia32_binfmt.c
>> ===================================================================
>> --- linux.orig/arch/x86_64/ia32/ia32_binfmt.c
>> +++ linux/arch/x86_64/ia32/ia32_binfmt.c
>> @@ -188,6 +188,7 @@ elf_core_copy_task_fpregs(struct task_st
>>  }
>>
>>  #define ELF_CORE_COPY_XFPREGS 1
>> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>>  static inline int
>>  elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
>>  {
>> Index: linux/fs/binfmt_elf.c
>> ===================================================================
>> --- linux.orig/fs/binfmt_elf.c
>> +++ linux/fs/binfmt_elf.c
>> @@ -1446,8 +1446,8 @@ static int elf_dump_thread_status(long s
>>
>>  #ifdef ELF_CORE_COPY_XFPREGS
>>      if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
>> -        fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
>> -              &t->xfpu);
>> +        fill_note(&t->notes[2], "LINUX", ELF_CORE_XFPREG_TYPE,
>> +              sizeof(t->xfpu), &t->xfpu);
>>          t->num_notes++;
>>          sz += notesize(&t->notes[2]);
>>      }
> 
> You've only fixed up one of 4 NT_PRXFPREG uses in the kernel.

Ooops... Right you are - very good pickup :) Fixed in a new version (will send promptly).


Thanks!

Mark.

> 
> Also, I'm not a fan of your proposed mechanism to "overload" the
> elf_fpxregset_t.  I'd rather see us introduce a new elf_vecregset_t and
> have it typedef'd to be elf_fpxregset_t on i386, x86_64, ia64
> 
>> Index: linux/include/asm-i386/elf.h
>> ===================================================================
>> --- linux.orig/include/asm-i386/elf.h
>> +++ linux/include/asm-i386/elf.h
>> @@ -129,6 +129,7 @@ extern int dump_task_extended_fpu (struc
>>  #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk,
>> elf_regs)
>>  #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk,
>> elf_fpregs)
>>  #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs)
>> dump_task_extended_fpu(tsk, elf_xfpregs)
>> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>>
>>  #define VDSO_HIGH_BASE        (__fix_to_virt(FIX_VDSO))
>>  #define VDSO_CURRENT_BASE    ((unsigned long)current->mm->context.vdso)
>>
>> -- 
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
