Message-Id: <200012150805.RAA23300@mail.geocities.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 15 Dec 2000 16:43:33 +0900
To: linuxppc-dev@lists.linuxppc.org
From: Takayuki YAMAGUCHI <tyamaguchi@geocities.co.jp>
Subject: Strange behavior of signal stack.
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


How do you do, all.

I'm embarrassed by a strange behavior of signal stack.

When testing the program like below by executing at a
terminal and sending SIGUSR1 from another terminal on
x86-linux and linuxppc, the value represented at
terminal is differnt (1 on x86-linux, 0 on linuxppc).

Moreover, when executing the program by using strace like

term:>strace -f -o /dev/null ./foobar		<-test program's name

returns 1 on linuxppc.

Does anyone know the reason?

Thank you.

----test program----
#include <signal.h>
#include <stdio.h>

main(){
  void func();
  struct sigaltstack ss;
  struct sigaction sa;

  ss.ss_sp = (void *)(((int) &ss)-8192);
  ss.ss_size = 8192;
  ss.ss_flags = 0;
  sigaltstack(&ss, 0);

  sa.sa_handler=func;
  sa.sa_flags=SA_ONSTACK;
  sigaction(SIGUSR1,&sa,NULL);
  while(1);
}

void func(){
  struct sigaltstack ss2;

  sigaltstack (((void *)0), &ss2);
  printf("%d\n", ss2.ss_flags);
}

--------
Takayuki YAMAGUCHI
tyamaguchi@geocities.co.jp
yamaguchi@ppc.linux.or.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
