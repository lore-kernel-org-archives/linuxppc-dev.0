From: dank@kegel.com
Message-ID: <3D397DEE.61DA4810@kegel.com>
Date: Sat, 20 Jul 2002 08:12:46 -0700
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	Jan Olderdissen <jolderdissen@ixiacom.com>
Subject: HZ, ppc405, interrupts and erratum 77
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to do regression testing for erratum 77, and
want to increase the number of asynchronous interrupts
as high as possible.

I'm running 2.4.17 or so from linuxppc_2_4_devel.

HZ in config/ppc/param.h is 100.
This generates 100 interrupts per second from the PIC on ppc405, right?

Will raising HZ to 1024 do the trick?  How high can I reasonably
raise that?  Is there a better way to generate scads of interrupts?

Also, how do I confirm the rate of interrupts?  cat /proc/interrupts
just shows
           CPU0
 25:          0  405GP UIC Edge      405 DPM Rx
BAD:          0

which makes me think I really don't understand what's going on;
shouldn't the PIC that's driving the jiffies counter be generating
interrupts that show up in /proc/interrupts?

Thanks,
Dan

p.s.
here's the long story:

IBM documented "ppc405 erratum 77" in
  http://www-3.ibm.com/chips/techlib/techlib.nsf/techdocs/89DED00DEBFF54BF87256A8000491BA2/$file/405CR_C_errata_1_2.pdf

In Sept 2001, a fix for erratum 77 was committed to the ppc development linux kernel:
http://ppc.bkbits.net:8080/linuxppc_2_4_devel/cset@1.489
(This fix has not made it into the mainline 2.4 kernel
e.g. http://lxr.linux.no/source/arch/ppc/kernel/bitops.c
but most ppc405 users realize that and act accordingly.)

Mark Hatle <fray@mvista.com> then commented
(see http://lists.linuxppc.org/linuxppc-embedded/200109/msg00227.html ):
> Just as an FYI, we also [use SYNC before STWCX] in glibc to be safe. We have never been
> able to pin down a problem in userspace due to this bug, but we thought
> it would be better safe then sorry until we can get definative proof
> that the bug will not happen in userspace.
>
> The following two files in glibc should be patched:
> linuxthreads/sysdeps/powerpc/pt-machine.h
> sysdeps/powerpc/atomicity.h

I believe this is the patch Mark is referring to (extracted from
Hard Hat Linux 2.0):  http://www.kegel.com/405-atomicity.patch

It looks like those patches have not yet made it into mainline glibc (
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/linuxthreads/sysdeps/powerpc/pt-machine.h?cvsroot=glibc
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/sysdeps/powerpc/atomicity.h?cvsroot=glibc ).

And of course my rough patch http://gcc.gnu.org/ml/libstdc++/2002-07/msg00152.html
has not yet made it into mainline gcc (
http://gcc.gnu.org/cgi-bin/cvsweb.cgi/gcc/libstdc%2b%2b-v3/config/cpu/powerpc/atomicity.h ).

Maybe I'll respin Mark's patch so that it only takes effect
ifdef __PPC405__, like mine, and put together a coordinated patch
for gcc3.1 and glibc2.2.5.  In my copious spare time :-)

I'm still looking for a good regression test for this.
My current thinking is to raise HZ in our kernel to 1024
to increase the chance that an STWCX instruction is interrupted
midthought, then run http://www.kegel.com/atomicity_test.c

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
