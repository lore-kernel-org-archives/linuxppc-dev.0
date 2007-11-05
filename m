Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 1C2E2DDE2D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 08:03:08 +1100 (EST)
Message-ID: <472F8503.2080705@harris.com>
Date: Mon, 05 Nov 2007 16:02:59 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: mmap question on ppc440
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am attempting to access the CPLD on the AMCC Sequoia board from 
user-land.  I open /dev/mem, and mmap it, then try to access the 
resulting pointer.  That works fine when accessing physical addresses 
that correspond to RAM, but as soon as I try to access the CPLD at 
physical address 0xc0000000, I get an infinite machine check.

I've done this successfully on the ARM architecture, and I've found 
examples where people do this on PPC, so I would expect this to work.

Here are a few successful reads:

bash-3.00# ./mm -r -a 0
paddr 00000000, map_base 0x30018000
00000000: c0348200

bash-3.00# ./mm -r -a 100
paddr 00000000, map_base 0x30018100
00000100: 7c0004ac

And here is the machine check:

bash-3.00# ./mm -r -a c0000000
paddr c0000000, Machine check in kernel mode.
Machine check in kernel mode.
Machine check in kernel mode.
Machine check in kernel mode.

My code looks like this (I'll post the whole program if anybody wants to 
see it:

        if((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
                fprintf(stderr, "cannot open\n");
                exit(1);
        }
        offset = addr & MAP_MASK;
        paddr = addr & ~MAP_MASK;
        map_base = (unsigned long *)mmap(NULL, MAP_SIZE,
                        PROT_READ | PROT_WRITE, MAP_SHARED, fd, paddr);

Is it possible to access devices like this from user-land?  If so, what 
am I doing wrong?

    Thanks,
    Steve
