Return-Path: <ashwin.tanugula@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 0916A67A6C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 11:07:52 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so750110wra
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 17:07:46 -0800 (PST)
Message-ID: <838f7c50050329170146631318@mail.gmail.com>
Date: Tue, 29 Mar 2005 20:01:06 -0500
From: ashwin tanugula <ashwin.tanugula@gmail.com>
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: ptrace and ORIG_EAX on ppc
Reply-To: ashwin tanugula <ashwin.tanugula@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!
Can somebody tell me how to set references to ORIG_EAX in ppc kernel.
We know ORIG_EAX is defined in unistd.h of i386. How do i make the
following program print two same pids in ppc?

#include <stdio.h>

#include <signal.h>

#include <sys/wait.h>

#include <sys/ptrace.h>

#include <asm/ptrace.h>

#include <asm/unistd.h>



static char stack[65536];



int child(void *arg)

{

if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){

perror("ptrace");

exit(1);

}

kill(getpid(), SIGSTOP);

while(1){

printf("getpid() returned %d\n", getpid());

sleep(3);

}

return(0);

}



int main(int argc, char **argv)

{

int pid, status, syscall;



printf("Parent pid = %d\n", getpid());

if((pid = clone(child, &stack[65532], SIGCHLD, NULL)) < 0){

perror("clone");

exit(1);

}

if((pid = waitpid(pid, &status, WUNTRACED)) < 0){

perror("Waiting for stop");

exit(1);

}

if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0){

perror("continuing");

exit(1);

}

while(1){

if((pid = waitpid(-1, &status, WUNTRACED)) <= 0){

perror("wait");

exit(1);

}

if(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP)){

syscall = ptrace(PTRACE_PEEKUSER, pid, 4 * ORIG_EAX, 0);

if(syscall == __NR_getpid){

if(ptrace(PTRACE_POKEUSER, pid, 4 * ORIG_EAX, __NR_getppid) < 0){

perror("ptrace");

exit(1);

}

}

if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0){

perror("continuing");

exit(1);

}

}

else printf("wait failed - pid = %d, status = %d\n", pid, status);

}

}



Note: References to ORIG_EAX have to be set here.
Thanks,
Ashwin.
