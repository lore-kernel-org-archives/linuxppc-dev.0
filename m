Return-Path: <markn@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5242DE110
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 12:36:35 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9C2aV8J017893
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 12:36:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9C2e68T163484
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 12:40:06 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9C2aFGD025196
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 12:36:15 +1000
Message-ID: <470EDD7D.8010509@au1.ibm.com>
Date: Fri, 12 Oct 2007 12:35:41 +1000
From: Mark Nelson <markn@au1.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [V2] Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE
	#define
References: <20071011071558.676463639@au1.ibm.com>	<20071011072208.075979098@au1.ibm.com>	<DFC6881D-E917-4EC5-B19C-8CE04E040B06@kernel.crashing.org>	<470ECFF7.9040008@au1.ibm.com>
	<470ED8BA.4010503@au1.ibm.com>
In-Reply-To: <470ED8BA.4010503@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry for the patch noise but please disregard this patch - a line is longer than 80 characters and I'd hate to be brought up on that...

V3 will be the perfect version then :)


Thanks and apologies again!

Mark.

Mark Nelson wrote:
> Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE in the coredump code which
> allows for more flexibility in the note type for the state of 'extended
> floating point' implementations in coredumps.  New note types can now be
> added with an appropriate #define.
> 
> This does #define ELF_CORE_XFPREG_TYPE to be NT_PRXFPREG in all
> current users so there's are no change in behaviour.
> 
> This will let us use different note types on powerpc for the
> Altivec/VMX state that some PowerPC cpus have (G4, PPC970, POWER6) and
> for the SPE (signal processing extension) state that some embedded
> PowerPC cpus from Freescale have.
> 
> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> ---
>  arch/ia64/ia32/elfcore32.h     |    1 +
>  arch/x86_64/ia32/ia32_binfmt.c |    1 +
>  fs/binfmt_elf.c                |    8 ++++----
>  fs/binfmt_elf_fdpic.c          |    6 +++---
>  include/asm-i386/elf.h         |    1 +
>  5 files changed, 10 insertions(+), 7 deletions(-)
> 
> Index: linux/arch/ia64/ia32/elfcore32.h
> ===================================================================
> --- linux.orig/arch/ia64/ia32/elfcore32.h
> +++ linux/arch/ia64/ia32/elfcore32.h
> @@ -117,6 +117,7 @@ elf_core_copy_task_fpregs(struct task_st
>  }
>  
>  #define ELF_CORE_COPY_XFPREGS 1
> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>  static inline int
>  elf_core_copy_task_xfpregs(struct task_struct *tsk, elf_fpxregset_t *xfpu)
>  {
> Index: linux/arch/x86_64/ia32/ia32_binfmt.c
> ===================================================================
> --- linux.orig/arch/x86_64/ia32/ia32_binfmt.c
> +++ linux/arch/x86_64/ia32/ia32_binfmt.c
> @@ -188,6 +188,7 @@ elf_core_copy_task_fpregs(struct task_st
>  }
>  
>  #define ELF_CORE_COPY_XFPREGS 1
> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>  static inline int 
>  elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
>  {
> Index: linux/fs/binfmt_elf.c
> ===================================================================
> --- linux.orig/fs/binfmt_elf.c
> +++ linux/fs/binfmt_elf.c
> @@ -1411,7 +1411,7 @@ struct elf_thread_status
>  	elf_fpregset_t fpu;		/* NT_PRFPREG */
>  	struct task_struct *thread;
>  #ifdef ELF_CORE_COPY_XFPREGS
> -	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
> +	elf_fpxregset_t xfpu;		/* ELF_CORE_XFPREG_TYPE */
>  #endif
>  	struct memelfnote notes[3];
>  	int num_notes;
> @@ -1446,8 +1446,8 @@ static int elf_dump_thread_status(long s
>  
>  #ifdef ELF_CORE_COPY_XFPREGS
>  	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
> -		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
> -			  &t->xfpu);
> +		fill_note(&t->notes[2], "LINUX", ELF_CORE_XFPREG_TYPE,
> +			  sizeof(t->xfpu), &t->xfpu);
>  		t->num_notes++;
>  		sz += notesize(&t->notes[2]);
>  	}
> @@ -1624,7 +1624,7 @@ static int elf_core_dump(long signr, str
>  #ifdef ELF_CORE_COPY_XFPREGS
>  	if (elf_core_copy_task_xfpregs(current, xfpu))
>  		fill_note(notes + numnote++,
> -			  "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
> +			  "LINUX", ELF_CORE_XFPREG_TYPE, sizeof(*xfpu), xfpu);
>  #endif	
>    
>  	fs = get_fs();
> Index: linux/fs/binfmt_elf_fdpic.c
> ===================================================================
> --- linux.orig/fs/binfmt_elf_fdpic.c
> +++ linux/fs/binfmt_elf_fdpic.c
> @@ -1417,7 +1417,7 @@ struct elf_thread_status
>  	elf_fpregset_t fpu;		/* NT_PRFPREG */
>  	struct task_struct *thread;
>  #ifdef ELF_CORE_COPY_XFPREGS
> -	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
> +	elf_fpxregset_t xfpu;		/* ELF_CORE_XFPREG_TYPE */
>  #endif
>  	struct memelfnote notes[3];
>  	int num_notes;
> @@ -1453,7 +1453,7 @@ static int elf_dump_thread_status(long s
>  
>  #ifdef ELF_CORE_COPY_XFPREGS
>  	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
> -		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
> +		fill_note(&t->notes[2], "LINUX", ELF_CORE_XFPREG_TYPE, sizeof(t->xfpu),

the line above is the offender...

>  			  &t->xfpu);
>  		t->num_notes++;
>  		sz += notesize(&t->notes[2]);
> @@ -1690,7 +1690,7 @@ static int elf_fdpic_core_dump(long sign
>  #ifdef ELF_CORE_COPY_XFPREGS
>  	if (elf_core_copy_task_xfpregs(current, xfpu))
>  		fill_note(notes + numnote++,
> -			  "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
> +			  "LINUX", ELF_CORE_XFPREG_TYPE, sizeof(*xfpu), xfpu);
>  #endif
>  
>  	fs = get_fs();
> Index: linux/include/asm-i386/elf.h
> ===================================================================
> --- linux.orig/include/asm-i386/elf.h
> +++ linux/include/asm-i386/elf.h
> @@ -129,6 +129,7 @@ extern int dump_task_extended_fpu (struc
>  #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
>  #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
>  #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>  
>  #define VDSO_HIGH_BASE		(__fix_to_virt(FIX_VDSO))
>  #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
