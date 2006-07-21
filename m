Return-Path: <bergner@vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C9FB679F0
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 08:21:57 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6LMLoVP025563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 18:21:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6LMLo4Y278710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 16:21:50 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6LMLocg006373
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 16:21:50 -0600
Subject: Re: AltiVec in the kernel
From: Peter Bergner <bergner@vnet.ibm.com>
To: "Brian D. Carlstrom" <bdc@carlstrom.com>
In-Reply-To: <lezmf4j5ym.wl%bdc@carlstrom.com>
References: <20060719181047.GL5905@austin.ibm.com>
	<001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
	<20060720174255.GP5905@austin.ibm.com>
	<le8xmoktav.wl%bdc@carlstrom.com>
	<20060720190523.GA27775@pb15.lixom.net>
	<lezmf4j5ym.wl%bdc@carlstrom.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 17:21:48 -0500
Message-Id: <1153520508.17144.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-07-20 at 14:56 -0700, Brian D. Carlstrom wrote:
> At Thu, 20 Jul 2006 14:05:23 -0500, Olof Johansson wrote:
> > http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
> 
> Very interesting. According to that page, the memcpy optimizations seem
> to be using 64-bit operations and that 128-bit AltiVec operations are
> still being solicited. 
> 
> I was encouraged to see the following: 
> 
>     If you need to build generic distributions (supporting several
>     <cpu_types>) you can leverage the dl_procinfo support built into
>     glibc. This mechanism allows for multiple versions of the core
>     libraries (libc, libm, librt, libpthread, libpthread_db) to be
>     stored in hardware/platform specific subdirectories under /lib[64].

Actually, this support is not limited to the core glibc routines or
the system lib directors /lib/ and /usr/lib/.  This works just as well
for third party shipped libraries in their own library trees as the
following example (on a power5 box) shows:

bergner@vervainp1:~/cpu-tuned-libs> pwd
/home/bergner/cpu-tuned-libs

bergner@vervainp1:~/cpu-tuned-libs> ls lib/ lib/power5/
lib/:
libfoo.so  power5/

lib/power5/:
libfoo.so

bergner@vervainp1:~/cpu-tuned-libs> gcc
-L/home/bergner/cpu-tuned-libs/lib -R/home/bergner/cpu-tuned-libs/lib
main.c -lfoo

bergner@vervainp1:~/cpu-tuned-libs> ldd a.out
        linux-vdso32.so.1 =>  (0x00100000)
        libfoo.so => /home/bergner/cpu-tuned-libs/lib/power5/libfoo.so
(0x0ffde000)
        libc.so.6 => /lib/power5/libc.so.6 (0x0fe69000)
        /lib/ld.so.1 (0xf7fe1000)

bergner@vervainp1:~/cpu-tuned-libs> ./a.out
Loaded the optimzed lib

bergner@vervainp1:~/cpu-tuned-libs> rm lib/power5/libfoo.so

bergner@vervainp1:~/cpu-tuned-libs> ldd a.out
        linux-vdso32.so.1 =>  (0x00100000)
        libfoo.so => /home/bergner/cpu-tuned-libs/lib/libfoo.so
(0x0ffde000)
        libc.so.6 => /lib/power5/libc.so.6 (0x0fe69000)
        /lib/ld.so.1 (0xf7fe1000)

bergner@vervainp1:~/cpu-tuned-libs> ./a.out
Loaded the unoptimzed lib


The runtime loader magic uses the AT_PLATFORM string value as
the subdirectory to search in under the .../lib/ or .../lib64/
library directory.  To find out what your AT_PLATFORM value is
on your current box, you can do:

bergner@vervainp1:~/cpu-tuned-libs> LD_SHOW_AUXV=1 /bin/true
AT_DCACHEBSIZE:  0x80
AT_ICACHEBSIZE:  0x80
AT_UCACHEBSIZE:  0x0
AT_SYSINFO_EHDR: 0x100000
AT_HWCAP:        power5 mmu fpu ppc64 ppc32
AT_PAGESZ:       4096
AT_CLKTCK:       100
AT_PHDR:         0x10000034
AT_PHENT:        32
AT_PHNUM:        9
AT_BASE:         0xf7fe1000
AT_FLAGS:        0x0
AT_ENTRY:        0x10000980
AT_UID:          1001
AT_EUID:         1001
AT_GID:          100
AT_EGID:         100
AT_SECURE:       0
AT_PLATFORM:     power5


> However, I'm guessing this addon is not something found in common
> distributions for PowerPC like Debian, Fedora, Gentoo, Ubuntu, ...

At last years GCC Developers Summit, one of the Ubuntu guys mentioned
he was interested in adding it to Ubuntu.  I haven't heard whether that
has shown up yet though.  It will be available in upcoming SUSE and
Red Hat enterprise distros.  I don't know about the others.  As Olof
mentioned, it can take some lead time for this to get picked up.
There's also the question of how many and which processors a distro
will ship cpu optimized libraries for.  Given all of the PowerPC
variants, they obviously can ship optimized libs for everything.

Peter
