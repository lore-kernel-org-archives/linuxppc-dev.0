Message-ID: <20000110120653.16499.qmail@web1901.mail.yahoo.com>
Date: Mon, 10 Jan 2000 04:06:53 -0800 (PST)
From: jc duyrat <jcduyrat@yahoo.com>
Subject: help on copy_thread
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hy everybody, <br>
 <br>
I have a question about copy_thread in <br>
arch/ppc/kernel/process.c (linux ver 2.2.13, 2.3.34
and others..): <br>

why don't we want to execute <br>
     childregs->gpr[2] = (unsigned long) p; <br>
when we are forking a process user ? <br>
What is the purpose of keeping the father's tss in
childregs->gpr[2] ?<br><br>
thank you for your help. <br>
<br>
	JC <br> 
<br>
copy_thread(int nr, unsigned long clone_flags,
unsigned long usp, <br>struct task_struct * p, struct
pt_regs *regs)<br>
{<br>
	struct pt_regs * childregs, *kregs;<br>
#ifdef __SMP__<br>
	extern void ret_from_smpfork(void);<br>
#else<br>
	extern void ret_from_syscall(void);<br>
#endif<br>
	/* Copy registers */<br>
	childregs = ((struct pt_regs *)<br>
		     ((unsigned long)p + sizeof(union
task_union)<br>
		      - STACK_FRAME_OVERHEAD)) - 2;<br>
	*childregs = *regs;<br>
	if ((childregs->msr & MSR_PR) == 0) <br>
		childregs->gpr[2] = (unsigned long) p;<br>	
....

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
