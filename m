Date: Thu, 16 Aug 2001 14:00:14 -0500 (CDT)
Message-Id: <200108161900.f7GJ0EM05271@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: fabrizio@cisco.com
Cc: linuxppc-dev@lists.linuxppc.org
Reply-To: Ed.Swarthout@motorola.com
In-reply-to: <3B7C0B57.4EBE47FF@cisco.com> (message from Fabrizio
	Dellabernarda on Thu, 16 Aug 2001 11:05:12 -0700)
Subject: Re: still problems with kgdb
References: <3B7C0B57.4EBE47FF@cisco.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> sorry to bother anybody again with same subject but I'm debugging some
> drivers under Hard Hat Linux for PPC and I can't enable the kgdb to use
> it. I tryed to compile the kernel (for K2 750 PPC) after enabling the
> kgdb option (using make xconfig) but I have compilation errors:

In order to use kgdb which is in ppc-stubs, you need to have a special
serial port driver which implements getDebugChar, putDebugChar, and
kgdb_interruptible (Although you could probably comment-out this last one).

Based on a grep of 2.4 it doesn't look like there are many non-macintosh options:

[linuxppc_2_4_devel]$ find . -type f | xargs grep kgdb_interruptible
./arch/ppc/8xx_io/uart.c:void kgdb_interruptible(int yes)
./arch/ppc/kernel/ppc-stub.c:   kgdb_interruptible(0);
./arch/ppc/kernel/ppc-stub.c:                   kgdb_interruptible(1);
./drivers/macintosh/macserial.c:                        kgdb_interruptible(1);
./drivers/macintosh/macserial.c:void kgdb_interruptible(int yes)
./drivers/tc/zs.c:void kgdb_interruptible(int yes)
./include/asm-ppc/kgdb.h:extern void kgdb_interruptible(int); /* control interrupts from serial */

-Ed

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
