Message-ID: <000d01bfaddd$eef56320$efc5dba8@sec.samsung.co.kr>
From: "kim sook young" <icekim@sec.samsung.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Error:glibc-2.1.3 :Question about 'struct sigcontext'
Date: Mon, 24 Apr 2000 20:12:04 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi, all

While compiling glibc-2.1.3 with gcc-2.95.2 , I met error like the following
(as you know, I had already posted this error)
---------------------------------------------------------------
../sysdeps/unix/sysv/linux/i386/profil-counter.h: In function `profil_counter':
../sysdeps/unix/sysv/linux/i386/profil-counter.h:26: structure has no member named `regs'
../sysdeps/posix/profil.c:39: warning: inlining failed in call to `profil_count'
../sysdeps/unix/sysv/linux/i386/profil-counter.h:26: warning: called from here
make[2]: *** [/home/icekim/Cross-Compiler/Glibc/glibc-2.1.3/build/gmon/profil.o] Error 1
make[2]: Leaving directory `/home/icekim/Cross-Compiler/Glibc/glibc-2.1.3/gmon'
make[1]: *** [gmon/subdir_lib] Error 2
----------------------------------------------------------------------

I thought header files would probably cause a problem. While tracing header files, I found a problem.

the following is sigcontext.h
-------------------------------------------------------------
struct sigcontext {
        unsigned short gs, __gsh;
        unsigned short fs, __fsh;
        unsigned short es, __esh;
        unsigned short ds, __dsh;
        unsigned long edi;
        unsigned long esi;
        unsigned long ebp;
        unsigned long esp;
        unsigned long ebx;
        unsigned long edx;
        unsigned long ecx;
        unsigned long eax;
        unsigned long trapno;
        unsigned long err;
        unsigned long eip;
        unsigned short cs, __csh;
        unsigned long eflags;
        unsigned long esp_at_signal;
        unsigned short ss, __ssh;
        struct _fpstate * fpstate;
        unsigned long oldmask;
        unsigned long cr2;
};
----------------------------------------------------------------------------

Like the above error message, struct sigcontext in the above sigcontext.h has no 'member named `regs' .
Even though this problem might be solved  in the process of the compilation ( indeed, this error passed with my clumsy trick), it also occurred while compiling segfault.c like the following...
-----------------------------------------------------------------------------
powerpc-linux-gcc ../sysdeps/generic/segfault.c -c -O -Wall -Winline -Wstrict-prototypes -Wwrite-strings -g   -fpic    -I../include -I. -I/home/icekim/glibc-2.1.3/build/debug -I.. -I../libio  -I/home/icekim/glibc-2.1.3/build -I../sysdeps/powerpc/elf -I../crypt/sysdeps/unix -I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/powerpc -I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32 -I../sysdeps/ieee754 -I../sysdeps/libm-ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic  -nostdinc -isystem /usr/local/lib/gcc-lib/powerpc-linux/2.95.2/include -isystem /usr/src/linux/include -D_LIBC_REENTRANT -include ../include/libc-symbols.h  -DPIC   -o /home/icekim/gli!
 bc-2.1.3/build/debug/segfault.os
In file included from ../sysdeps/generic/segfault.c:41:
../sysdeps/powerpc/register-dump.h: In function `register_dump':
../sysdeps/powerpc/register-dump.h:106: structure has no member named `regs'
make[2]: *** [/home/icekim/glibc-2.1.3/build/debug/segfault.os] Error 1
make[2]: Leaving directory `/home/icekim/glibc-2.1.3/debug'
make[1]: *** [debug/others] Error 2
make[1]: Leaving directory `/home/icekim/glibc-2.1.3'
make: *** [all] Error 2
-----------------------------------------------------------------------------
In this case I could avoid this error because function register_dump() in register-dump.h uses 'regs' like the below.
-----------------------------------------------------------------------------
static void
register_dump (int fd, struct sigcontext *ctx)
{
  char buffer[sizeof(dumpform)];
  char *bufferpos;
  unsigned regno;
  unsigned *regs = (unsigned *)(ctx->regs);

  memcpy(buffer, dumpform, sizeof(dumpform));

  /* Generate the output.  */
  while ((bufferpos = memchr (buffer, '%', sizeof(dumpform))))
    {
      regno = xtoi (bufferpos[-1]) | xtoi (bufferpos[-2]) << 4;
      memset (bufferpos-2, '0', 3);
      _itoa_word (regs[regno], bufferpos+1, 16, 0);
    }

  /* Write the output.  */
  write (fd, buffer, sizeof(buffer));
}
-----------------------------------------------------------------------------

In fact, I don't understand what all members of struct sigcontext mean. I don't know how to solve this problem. I hope somebody would help me.


e-mail: icekim@sec.samsung.co.kr

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
