Return-Path: <aijazbaig1.new@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C028D2C00A6
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Nov 2013 18:51:35 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <aijazbaig1.new@gmail.com>) id 1VfmHV-0004D5-2o
 for linuxppc-dev@ozlabs.org; Sun, 10 Nov 2013 23:51:33 -0800
Date: Sun, 10 Nov 2013 23:51:33 -0800 (PST)
From: pegasus <aijazbaig1.new@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1384156293077-78004.post@n7.nabble.com>
In-Reply-To: <alpine.LRH.2.00.1311101509570.9815@ra8135-ec1.am.freescale.net>
References: <1383907583944-77960.post@n7.nabble.com>
 <alpine.LRH.2.00.1311101509570.9815@ra8135-ec1.am.freescale.net>
Subject: Re: BookE "branch taken" behavior vis-a-vis updating the NIP register
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks James.

So it means that, the NIP that I am seeing in the printks is indeed correct.
Right? And this is due to the pipelining feature that is inherent in all
processors. So it basically means that after having executed the branch, the
NIP has already progressed to the next instruction it is about to execute
(just after the branch or rather the branch target). The NIP hence basically
contains the address of the branch target. And this is how it is (and
perhaps I have been thinking about this in the wrong way).

But I still have a question about how one would then be able to signal to
the userspace who might be interpreting this information differently? I mean
if SRR0 contains, not the branch instruction address but the address of the
branch target, how would any debugger be able to catch function calls? May
be there is a trick involved here and hence gdb or for that matter the other
debuggers are still in the market. But then I would be immensely obliged if
you could shed some light on how is this accomplished. Lets say I am waiting
at the userspace in my own sigtrap, to watch out for branch instructions.
Lets say I want to profile my code to get to know how many branch
instructions it has generated. How could I ever do that using my own custom
SIGTRAP handler?

Coming on to PTRACE_SINGLESTEP, the sysroot that has been provided to us by
our vendor does not include a PTRACE_SINGLEBLOCK in sys/ptrace.h:

/* Type of the REQUEST argument to `ptrace.'  */
enum __ptrace_request
{
  /* Indicate that the process making this request should be traced.
     All signals received by this process can be intercepted by its
     parent, and its parent can use the other `ptrace' requests.  */
  PTRACE_TRACEME = 0,
#define PT_TRACE_ME PTRACE_TRACEME

  /* Return the word in the process's text space at address ADDR.  */
  PTRACE_PEEKTEXT = 1,
#define PT_READ_I PTRACE_PEEKTEXT

  /* Return the word in the process's data space at address ADDR.  */
  PTRACE_PEEKDATA = 2,
#define PT_READ_D PTRACE_PEEKDATA

  /* Return the word in the process's user area at offset ADDR.  */
  PTRACE_PEEKUSER = 3,
#define PT_READ_U PTRACE_PEEKUSER

  /* Write the word DATA into the process's text space at address ADDR.  */
  PTRACE_POKETEXT = 4,
#define PT_WRITE_I PTRACE_POKETEXT

  /* Write the word DATA into the process's data space at address ADDR.  */
  PTRACE_POKEDATA = 5,
#define PT_WRITE_D PTRACE_POKEDATA

  /* Write the word DATA into the process's user area at offset ADDR.  */
  PTRACE_POKEUSER = 6,
#define PT_WRITE_U PTRACE_POKEUSER

  /* Continue the process.  */
  PTRACE_CONT = 7,
#define PT_CONTINUE PTRACE_CONT

  /* Kill the process.  */
  PTRACE_KILL = 8,
#define PT_KILL PTRACE_KILL

  /* Single step the process.
     This is not supported on all machines.  */
  PTRACE_SINGLESTEP = 9,
#define PT_STEP PTRACE_SINGLESTEP

  /* Attach to a process that is already running. */
  PTRACE_ATTACH = 16,
#define PT_ATTACH PTRACE_ATTACH

  /* Detach from a process attached to with PTRACE_ATTACH.  */
  PTRACE_DETACH = 17,
#define PT_DETACH PTRACE_DETACH

  /* Continue and stop at the next (return from) syscall.  */
  PTRACE_SYSCALL = 24,
#define PT_SYSCALL PTRACE_SYSCALL

  /* Set ptrace filter options.  */
  PTRACE_SETOPTIONS = 0x4200,
#define PT_SETOPTIONS PTRACE_SETOPTIONS

  /* Get last ptrace message.  */
  PTRACE_GETEVENTMSG = 0x4201,
#define PT_GETEVENTMSG PTRACE_GETEVENTMSG

  /* Get siginfo for process.  */
  PTRACE_GETSIGINFO = 0x4202,
#define PT_GETSIGINFO PTRACE_GETSIGINFO

  /* Set new siginfo for process.  */
  PTRACE_SETSIGINFO = 0x4203
#define PT_SETSIGINFO PTRACE_SETSIGINFO
};

Although I can clearly see that PTRACE_SINGLEBLOCK is supported in the
kernel. 

Hence I am not able to compile this simple program in userspace:

#include <stdio.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>


int main() {   
	pid_t childpid;

    childpid = fork();

	if(childpid < 0) {
		perror("error forking:");
		return -1;
	}

    if(childpid == 0) {
		char cwd[512];
		char path[1024];
		int val;
		
        ptrace(PTRACE_TRACEME, 0, NULL, NULL);

		if (getcwd(cwd, sizeof(cwd)) != NULL)
			snprintf(path, sizeof(path), "%s/test", cwd);
		else {
			perror("getcwd() error. Exiting the program");
			exit(1);
		}

		puts("now execle'ing");
		val = execl(path, NULL); //this will not return
		if (val < 0) { //something went wrong
			perror("something went wrong");
			exit(1);
		}		
    }
    else {
		int status,rc;

		ptrace(PTRACE_SINGLEBLOCK, childpid, NULL, NULL);
		rc = waitpid(childpid, &status, 0);
		if (rc == -1) {
			perror("unable to waitpid:");
			exit(1);
		}
		
		if(WIFEXITED(status)) {
			printf("Child exited with status %d.\n", WEXITSTATUS(status));
		}
    }
    return 0;
}

Heres the error I get:
testptrace.c: In function 'int main()':
testptrace.c:47: error: invalid conversion from 'int' to '__ptrace_request'
testptrace.c:47: error:   initializing argument 1 of 'long int
ptrace(__ptrace_request, ...)'
make: *** [testptrace] Error 1

How should I go about using ptrace to test this? 

Keen to hear from you for the above two clarifications.



--
View this message in context: http://linuxppc.10917.n7.nabble.com/BookE-branch-taken-behavior-vis-a-vis-updating-the-NIP-register-tp77960p78004.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
