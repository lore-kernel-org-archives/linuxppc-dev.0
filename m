To: linuxppc-dev@lists.linuxppc.org
Subject: severe -O -funroll-loops bug / BLAS 
Reply-To: kozioziemski1@llnl.gov
From: Bernard Kozioziemski <kozioziemski1@llnl.gov>
Date: 13 Sep 2000 09:42:26 -0700
Message-ID: <m3ya0wgs5p.fsf@koz1.llnl.gov>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,
I ran into a pretty nasty bug with gcc trying to compile the atlas BLAS
package for use with clapack (atlas is at http://www.netlib.org/atlas). I
didn't find any mention of unroll loops in the archive search, so here goes.

While compiling the code to 'tune' the algorithms, when I use an -O option
with -funroll-loops or -funroll-all-loops, gcc rapidly consumes all memory
on the machine, about 200M real and 200M swap. At this point linux locks
up, no console access, no remote (ssh) access, etc. and I had to power off
(waited about an hour after last response from mouse). So there are two
problems: First gcc hits an infinite loop of sorts, second, it would be
nice for the kernel to die a little more gracefully.

After reboot, I experimented a bit, killing the process before it swaps the
machine to death. If I don't use a -O option, it compiles, or I can use a
-O? but no loop unrolling. I'll enclose the code as well as the options I
used to compile. The same options did not cause problems using an intel
version of gcc, so it seems to be specific to linuxppc.

Thanks,

Bernard Kozioziemski

Offending code: muladd.c


#include <stdio.h>
#include<assert.h>
double time00();

static double macase(long nreps, int PRINT)
{
   long i = nreps;
   double t0, tim, mf;
   register double c0;

   if (nreps > 0) c0 = 0.0;
   else c0 = 2.2*nreps;
   t0 = time00();
   do
   {
      c0 += c0 * c0;
   }
   while(--i);
   tim = time00() - t0;
   c0 = c0;
   if (tim < 0.0) mf = tim = 0.0;
   else mf = (nreps*2.000000) / (1000000.0 * tim);
   if (PRINT) printf("%.1f:   Combined MULADD, lat=1, time=%f, mflop=%f\n", (float) c0, tim, mf);
   else printf("      %.0f: NFLOP=%.0f, tim=%f\n", (float) c0, nreps*2.000000, tim);
   return(tim);
}

main(int nargs, char **args[])
{
   long nreps = 16000000/2;
   int i, k;
   double t0, tim, mf;
   FILE *fp;
   fp = fopen("res/dmuladd1_1", "w");
   assert(fp != NULL);
   fprintf(stdout, "Finding granularity of timer:\n");   while(macase(nreps, 0) < 0.75) nreps *= 4;
   fprintf(stdout, "Done.\n");   for(k=0; k < 3; k++)
   {
   tim = macase(nreps, 1);
   if (tim < 0.0) mf = tim = 0.0;
   else mf = (nreps*2.000000) / (1000000.0 * tim);
   if (fp) fprintf(fp, "%f\n", mf);
   }
   fclose(fp);
   exit(0);
}


Compiling with any of the following causes gcc to eat all memory:

gcc -DL2SIZE=1048576 -fomit-frame-pointer -O3 -funroll-all-loops -c muladd.c
gcc -DL2SIZE=1048576 -fomit-frame-pointer -O2 -funroll-all-loops -c muladd.c
gcc -DL2SIZE=1048576 -fomit-frame-pointer -O -funroll-all-loops -c muladd.c
gcc -DL2SIZE=1048576 -fomit-frame-pointer -O2 -funroll-loops -c muladd.c

Compiling with any of the following works:
gcc -DL2SIZE=1048576 -fomit-frame-pointer -funroll-all-loops -c muladd.c
gcc -DL2SIZE=1048576 -fomit-frame-pointer -O2 -c muladd.c

The -DL2SIZE specifies the L2 cache size, 1M in my case (PowerLogix
PowerForce G3 upgrade in 9500).


rpm -qf /usr/bin/gcc returns gcc-2.95.2-1i

gcc --verbose -DL2SIZE=1048576 -fomit-frame-pointer -O2 -funroll-all-loops
-c muladd.c

gives:

Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release/franzo)
 /usr/lib/gcc-lib/ppc-redhat-linux/2.95.2/cpp -lang-c -v -D__GNUC__=2 -D__GNUC_MINOR__=95 -DPPC -D__ELF__ -Dpowerpc -D__PPC__ -D__ELF__ -D__powerpc__ -D__PPC -D__powerpc -Acpu(powerpc) -Amachine(powerpc) -D__CHAR_UNSIGNED__ -D__OPTIMIZE__ -D_CALL_SYSV -D_BIG_ENDIAN -D__BIG_ENDIAN__ -Amachine(bigendian) -D_ARCH_PPC -D__unix__ -D__linux__ -Dunix -Dlinux -Asystem(unix) -Asystem(posix) -DL2SIZE=1048576 muladd.c /tmp/ccs2ixnt.i
GNU CPP version 2.95.2 19991024 (release/franzo) (PowerPC GNU/Linux)
#include "..." search starts here:
#include <...> search starts here:
 /usr/local/include
 /usr/lib/gcc-lib/ppc-redhat-linux/2.95.2/../../../../ppc-redhat-linux/include
 /usr/lib/gcc-lib/ppc-redhat-linux/2.95.2/include
 /usr/include
End of search list.
The following default directories have been omitted from the search path:
 /usr/lib/gcc-lib/ppc-redhat-linux/2.95.2/../../../../include/g++-3
End of omitted list.
 /usr/lib/gcc-lib/ppc-redhat-linux/2.95.2/cc1 /tmp/ccs2ixnt.i -quiet -dumpbase muladd.c -O2 -version -fomit-frame-pointer -funroll-all-loops -o /tmp/ccugpn6O.s
GNU C version 2.95.2 19991024 (release/franzo) (ppc-redhat-linux) compiled by GNU C version 2.95.2 19991024 (release/franzo).

I'm using the 2.2.16 kernel, compiled from source on kernel.org in June.

--
kozioziemski1@llnl.gov
(925)424-6317

Sent at -- Wed Sep 13 09:42:26 2000

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
