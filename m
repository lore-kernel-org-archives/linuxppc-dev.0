Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 18F6DDE164
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 04:16:23 +1000 (EST)
Subject: Signal backtrace function
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 20:16:20 +0200
Message-Id: <1207764980.5826.77.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I made my own backtrace function for printing
a trace from within a signal handler. Maybe it
can be useful for the kernel too? General
comments welcome.


   Jocke

#include <stdio.h>
#include <signal.h>
#include <execinfo.h>
#include <unistd.h>

#define __USE_GNU
#include <ucontext.h>

/* This is the stack layout we see with every stack frame.
   Note that every routine is required by the ABI to lay out the stack
   like this.

            +----------------+        +-----------------+
    %r1  -> | %r1 last frame--------> | %r1 last frame--->...  --> NULL
            |                |        |                 |
            | (unused)       |        | return address  |
            +----------------+        +-----------------+
*/


/* Prints a backtrace when invoked from a signal handler */
int
sigbacktrace (void **array, int size, void *sp,
	     void *lr, void *exec_addr)
{
	int count=1, loop;
	void *ret_addr;
	struct layout {
		struct layout * next;
		void * return_address;
	} *current;
	
	if (!size)
		return size;
	current = sp;
	array[0] = exec_addr;

	for (loop = 0;
	     current != NULL && count < size;
	     current = current->next, loop++) {
		ret_addr = current->return_address;
#if DEBUG
		printf("next:%p, ret:%p, LR:%p\n", current->next, ret_addr, lr);
#endif
		if (lr == ret_addr) /* false frame ? */
			continue;
		if (!loop)
			if (lr != ret_addr) /*  Leaf function ? */
				ret_addr = lr;
			else
				continue;
		array[count++] = ret_addr;
	}

	/* It's possible the second-last stack frame can't return in which
	   case the CRT startup code will have set its LR to 'NULL'.  */
	if (count > 0 && array[count-1] == NULL)
		count--;

	return count;
}

#define EXEC_ADDR (*regs)[32]
#define STK_PTR (*regs)[1]
#define LINK (*regs)[36]
void bt_sighandler(int sig, siginfo_t *info,
		   void *secret)
{

  void *trace[16];
  char **messages = (char **)NULL;
  int i, trace_size = 0;
  ucontext_t *uc = (ucontext_t *)secret;
  gregset_t *regs = &uc->uc_mcontext.uc_regs->gregs;

  /* Do something useful with siginfo_t */
  if (sig == SIGSEGV || sig == SIGBUS)
	printf("Got signal %d, faulty address is %p, "
		   "from %p\n", sig, info->si_addr,
	       EXEC_ADDR);
  else
	printf("Got signal %d\n", sig);
  trace_size = sigbacktrace(trace, 16, (void*) STK_PTR,
			    (void*) LINK, (void*) EXEC_ADDR);
  messages = backtrace_symbols(trace, trace_size);
  printf("[bt] Execution path:\n");
  for (i=0; i<trace_size; ++i)
	printf("[bt] %s\n", messages[i]);

  if (sig != SIGUSR1)
	  exit(0);
}

void dummy(void)
{
  unsigned long *current;
  asm volatile ("" : "=l"(current));
}

int func_a(int a, char b) {

  char *p = (char *)0xdeadbeef;
  //dummy(); /* Test with and without this call */
  a = a + b;
  *p = 10;	/* CRASH here!! */
  dummy(); /* Test with and without this call */

  return 2*a;
}


int func_b() {
  
  int res, a = 5;

  res = 5 + func_a(a, 't');

  return res;
}


int main() {

  /* Install our signal handler */
  struct sigaction sa;

  sa.sa_sigaction = (void *)bt_sighandler;
  sigemptyset (&sa.sa_mask);
  sa.sa_flags = SA_RESTART | SA_SIGINFO;

  sigaction(SIGSEGV, &sa, NULL);
  sigaction(SIGBUS, &sa, NULL);
  sigaction(SIGUSR1, &sa, NULL);
  /* ... add any other signal here */

  /* Do something */
  printf("%d\n", func_b());

}

 
