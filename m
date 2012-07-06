Return-Path: <aik@ozlabs.ru>
Message-ID: <4FF69404.6090408@ozlabs.ru>
Date: Fri, 06 Jul 2012 17:30:12 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Linuxppc-dev@lists.ozlabs.org
Subject: ptrace and emulated mfspr/mtspr on DSCR
Content-Type: text/plain; charset=KOI8-R
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

I am trying to change DSCR's value of a specific process with pid=XXX. For this, I attach by ptrace() to XXX, inject a piece of code which does mfspr/mtspr, "continue" XXX and see how it is changing. So far so good.

The problem is with "continue". The XXX process does not wake up until I press a key (if XXX is waiting on something like scanf() or gets()) OR it exits from sleep() if I change it to run sleep() in a loop.

Not sure if it matters but mfspr/mtspr are privileged instructions and are emulated by the kernel.

How to wake XXX up?



#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <unistd.h>
#include <sys/user.h>
#include <stdio.h>
#include <stdlib.h>

void getdata(pid_t child, long addr, void *str)
{
	unsigned long *ptr = (unsigned long *) str;
	ptr[0] = ptrace(PTRACE_PEEKDATA, child, addr, NULL);
}

void putdata(pid_t child, long addr, void *str)
{
	unsigned long *ptr = (unsigned long *) str;
	ptrace(PTRACE_POKEDATA, child, addr, ptr[0]);
}

int main(int argc, char *argv[])
{
	pid_t traced_process;
	struct pt_regs regs, backup_regs;
	unsigned long dscr = -1;
/*.set_dscr:
* 7f d1 03 a6     mtspr   17,r30
  7d 82 10 08     twge    r2,r2     <- set breakpoint */
	unsigned int insert_set[] = { 0x7fd103a6, 0x7d821008 };
/*.get_dscr:
  7f d1 02 a6     mfspr   r30,17
  7d 82 10 08     twge    r2,r2     <- set breakpoint */
	unsigned int insert_get[] = { 0x7fd102a6, 0x7d821008 };
	char backup[8];
	int len = 8;

	if((argc < 2)||(sizeof(unsigned int)!=4)) {
		printf("Usage: %s <pid to be traced> [dscr value]\n", argv[0], argv[1]);
		exit(1);
	}
	if (argc > 2) {
		dscr = atoi(argv[2]);
	}

	traced_process = atoi(argv[1]);
	ptrace(PTRACE_ATTACH, traced_process, NULL, NULL);
	wait(NULL);

	printf("Attached to pid=%u\n", traced_process);
	ptrace(PTRACE_GETREGS, traced_process, NULL, &regs);
	backup_regs = regs;
	getdata(traced_process, regs.nip, backup);

	if (dscr != -1) {
		regs.gpr[30] = dscr;
		putdata(traced_process, regs.nip, insert_set);
		ptrace(PTRACE_SETREGS, traced_process, NULL, &regs);
		printf("Setting DSCR = %x to gpr0\n", regs.gpr[30]);
	} else {
		putdata(traced_process, regs.nip, insert_get);
		printf("Reading DSCR\n");
	}

	printf("Continued pid=%u\n", traced_process);
	ptrace(PTRACE_CONT, traced_process, NULL, SIGCONT);

	printf("waiting...\n");
	wait(NULL);      // <---------------- HERE IS THE PROBLEM

	if (dscr == -1) {
		printf("DSCR has been read\n");
		ptrace(PTRACE_GETREGS, traced_process, NULL, &regs);
		printf("Reading DSCR from gpr30 = %x\n", regs.gpr[30]);
	}

	printf("The process stopped, Putting back the original instructions\n");
	putdata(traced_process, backup_regs.nip, backup);
	ptrace(PTRACE_SETREGS, traced_process, NULL, &backup_regs);
	printf("Letting it continue with original flow\n");
	ptrace(PTRACE_DETACH, traced_process, NULL, NULL);

	return 0;
}

-- 
Alexey
