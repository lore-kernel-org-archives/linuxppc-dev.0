From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Roman Zippel <zippel@fh-brandenburg.de>, jekacur@ca.ibm.com
Subject: Re:sigcontext on Linux-ppc in user space, another hack.
Date: Thu, 25 Jan 2001 20:05:51 -0500
Content-Type: text/plain;
  charset="US-ASCII"
Cc: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
References: <Pine.GSO.4.10.10101252352100.1508-100000@zeus.fh-brandenburg.de>
In-Reply-To: <Pine.GSO.4.10.10101252352100.1508-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Message-Id: <01012520055100.11290@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Please ignore the last patch!
> Anyway, in the code example the last argument is not a sigcontext
> structure but an ucontext_t structure, which is defined in <ucontext.h>.

Yes.

Here is the revised sample program and it works:

[root@localhost kbhend]# ./junk
SIGUSR1 = 10
uc = 7ffff794
uc->uc_mcontext.signal = 10
[root@localhost kbhend]# cat junk.c
#include <stdio.h>
#include <signal.h>
#include <ucontext.h>

/* Function Prototypes */
void install_sigusr1_handler(void);
void sigusr_handler(int , siginfo_t *, struct ucontext * uc);

int main(void)
{
  install_sigusr1_handler();
  printf("SIGUSR1 = %d\n", SIGUSR1);
  raise(SIGUSR1);
  exit(0);
}

void install_sigusr1_handler(void)
{
  struct sigaction newAct;

  if (sigemptyset(&newAct.sa_mask) != 0) {
    fprintf(stderr, "Warning, sigemptyset failed.\n");
  }

  newAct.sa_flags = 0;
  newAct.sa_flags |= SA_SIGINFO | SA_RESTART;

  newAct.sa_sigaction = (void
			 (*)(int,siginfo_t*,void*))sigusr_handler;

  if (sigaction(SIGUSR1, &newAct, NULL) != 0) {
    fprintf(stderr, "Couldn't install SIGUSR1 handler.\n");
    fprintf(stderr, "Exiting.\n");
    exit(1);
  }
}

void sigusr_handler(int signo, siginfo_t *siginfp, struct ucontext * uc)
{
  printf("uc = %08x\n", uc);
  printf("uc->uc_mcontext.signal = %d\n", uc->uc_mcontext.signal);
}

[[root@localhost kbhend]# cat junk.c
#include <stdio.h>
#include <signal.h>
#include <ucontext.h>

/* Function Prototypes */
void install_sigusr1_handler(void);
void sigusr_handler(int , siginfo_t *, struct ucontext * uc);

int main(void)
{
  install_sigusr1_handler();
  printf("SIGUSR1 = %d\n", SIGUSR1);
  raise(SIGUSR1);
  exit(0);
}

void install_sigusr1_handler(void)
{
  struct sigaction newAct;

  if (sigemptyset(&newAct.sa_mask) != 0) {
    fprintf(stderr, "Warning, sigemptyset failed.\n");
  }

  newAct.sa_flags = 0;
  newAct.sa_flags |= SA_SIGINFO | SA_RESTART;

  newAct.sa_sigaction = (void
			 (*)(int,siginfo_t*,void*))sigusr_handler;

  if (sigaction(SIGUSR1, &newAct, NULL) != 0) {
    fprintf(stderr, "Couldn't install SIGUSR1 handler.\n");
    fprintf(stderr, "Exiting.\n");
    exit(1);
  }
}

void sigusr_handler(int signo, siginfo_t *siginfp, struct ucontext * uc)
{
  printf("uc = %08x\n", uc);
  printf("uc->uc_mcontext.signal = %d\n", uc->uc_mcontext.signal);
}



[root@localhost kbhend]# ./junk
SIGUSR1 = 10
uc = 7ffff794
uc->uc_mcontext.signal = 10

So no patch needed.

Thanks for finding that.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
