Message-ID: <3893851A.EF2A66A8@wetware.com>
Date: Sat, 29 Jan 2000 16:26:02 -0800
From: james woodyatt <jhw@wetware.com>
MIME-Version: 1.0
To: bug-glibc@gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: bug-glibc,linuxppc-dev: semctl on linux/ppc
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


gospoda--

I have found what appears to be a minor problem with the System V IPC
code for Linux as implemented in the GNU C Library, version 2.1.2 and
previous versions.

Observe that the 'semctl' function is declared in sysvipc/sys/sem.h as
follows:

/* Semaphore control operation.  */
extern int semctl __P ((int __semid, int __semnum, int __cmd, ...));

This is a sorta-kinda reasonable prototype for an interface that was
defined before ANSI C introduced such modern conveniences; the fourth
argument is only needed when the 'cmd' argument has certain values.  But
consider the definition of the function in
sysdeps/unix/sysv/linux/semctl.c:

int
semctl (int semid, int semnum, int cmd, ...)
{
  union semun *arg;
  va_list ap;

  va_start (ap, cmd);

  /* Get a pointer the argument.  */
  arg = &va_arg (ap, union semun);

  va_end (ap);

  return INLINE_SYSCALL (ipc, 5, IPCOP_semctl, semid, semnum, cmd, arg);
}

This function requires the fourth argument no matter what the value of
the 'cmd' argument.  For example, consider the following perfectly
reasonable use of 'semctl' taken from a piece of old software I have
that has compiled and run on every version of Solaris 2.x I've ever had
the displeasure to encounter:

if (semctl(semid, 0, IPC_RMID) == -1)) {
    /* throw up horribly */
}

This will compile fine on my Powerbook G3 running Linux/PPC 1999, but it
won't work.  I have to work around the problem by providing a 'union
semun' type parameter (not a pointer, the actual union passed by value),
even for the IPC_RMID command (which doesn't use it), because otherwise
the GNU C Library will exhibit what the ANSI C standard euphemistically
refers to as 'undefined behavior'-- in my case, a lovely core dump.

Good thing I have the source code to my application and I can work
around problems like this, but I thought someone maintaining the GNU C
Library might want to have a look at this.

(And don't *anyone* hassle me about using System V IPC in the first
place.  If it were *my* choice, I'd be using
_POSIX_THREAD_PROCESS_SHARED.  Besides, *that* isn't
supported/supportable on Linux anyway <*bitch* *moan* *complain*>.)


--jhw@wetware.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
