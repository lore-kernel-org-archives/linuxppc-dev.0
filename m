Return-Path: <deepa.ramki@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id 9B7DA67A7F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 20:23:08 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 68so218719wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 01:23:07 -0800 (PST)
Message-ID: <b4048df4050127011648e5d73e@mail.gmail.com>
Date: Thu, 27 Jan 2005 10:16:27 +0100
From: Deepa Ramki <deepa.ramki@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: building linuxppc-2.5 + adeos patch with ELDK-3.0
Reply-To: Deepa Ramki <deepa.ramki@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all, 
    I am trying to build the adeos patched linuxppc-2.5 kernel for an
IBM PPC440 based Ebony board.

The versions are:
linux: linuxppc-2.6.10rc3
adeos patch = adeos-linuxppc-2.6.10rc3-r6c11.patch
The patch went through fine.

I am using the ELDK 3.0 tools for building.

Make menu config was done to select the right board(ebony) and
processor(ppc4xx). Other than enabling the preemptible kernel option,
no other change was made to the default settings.
The make command however reports errors :(
I issued make ARCH=ppc CROSS_COMPILE=ppc_4xx-

Please let me know where I am going wrong. I further intend to use
RTAI Fusion on top of this. I hope I am on the right track. I request
the people with more experience to please help me!

Best Regards
Deepa.

The error received is as follows:

linux:/usr/local/eldk/ppc_4xx/usr/src/linuxppc-2.5 # make ARCH=ppc
CROSS_COMPILE=ppc_4xx-
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/genksyms/genksyms.o
  HOSTCC  scripts/genksyms/lex.o
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      arch/ppc/kernel/asm-offsets.s
In file included from include/linux/time.h:7,
                 from include/linux/resource.h:4,
                 from include/asm-generic/siginfo.h:6,
                 from include/asm/siginfo.h:4,
                 from include/asm/adeos.h:33,
                 from include/linux/preempt.h:30,
                 from include/linux/spinlock.h:9,
                 from include/linux/signal.h:5,
                 from arch/ppc/kernel/asm-offsets.c:12:
include/linux/seqlock.h:35: parse error before "spinlock_t"
include/linux/seqlock.h:35: warning: no semicolon at end of struct or union
include/linux/seqlock.h:36: warning: type defaults to `int' in
declaration of `seqlock_t'
include/linux/seqlock.h:36: warning: data definition has no type or
storage class
include/linux/seqlock.h:50: parse error before '*' token
include/linux/seqlock.h:51: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_seqlock':
include/linux/seqlock.h:52: warning: implicit declaration of function
`spin_lock'
include/linux/seqlock.h:52: `sl' undeclared (first use in this function)
include/linux/seqlock.h:52: (Each undeclared identifier is reported only once
include/linux/seqlock.h:52: for each function it appears in.)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:57: parse error before '*' token
include/linux/seqlock.h:58: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_sequnlock':
include/linux/seqlock.h:60: `sl' undeclared (first use in this function)
include/linux/seqlock.h:61: warning: implicit declaration of function
`spin_unlock'
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:64: parse error before '*' token
include/linux/seqlock.h:65: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_tryseqlock':
include/linux/seqlock.h:66: warning: implicit declaration of function
`spin_trylock'
include/linux/seqlock.h:66: `sl' undeclared (first use in this function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:76: warning: type defaults to `int' in
declaration of `seqlock_t'
include/linux/seqlock.h:76: parse error before '*' token
include/linux/seqlock.h:77: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `read_seqbegin':
include/linux/seqlock.h:78: `sl' undeclared (first use in this function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:91: warning: type defaults to `int' in
declaration of `seqlock_t'
include/linux/seqlock.h:91: parse error before '*' token
include/linux/seqlock.h:92: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `read_seqretry':
include/linux/seqlock.h:94: `iv' undeclared (first use in this function)
include/linux/seqlock.h:94: `sl' undeclared (first use in this function)
In file included from include/linux/resource.h:4,
                 from include/asm-generic/siginfo.h:6,
                 from include/asm/siginfo.h:4,
                 from include/asm/adeos.h:33,
                 from include/linux/preempt.h:30,
                 from include/linux/spinlock.h:9,
                 from include/linux/signal.h:5,
                 from arch/ppc/kernel/asm-offsets.c:12:
include/linux/time.h: At top level:
include/linux/time.h:83: parse error before "xtime_lock"
include/linux/time.h:83: warning: type defaults to `int' in
declaration of `xtime_lock'
include/linux/time.h:83: warning: data definition has no type or storage class
make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
make: *** [arch/ppc/kernel/asm-offsets.s] Error 2
