Message-ID: <3C8FD13B.12D70F97@mvista.com>
Date: Wed, 13 Mar 2002 14:22:51 -0800
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Leiying Du <ldu@solectek.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Debug kernel ELF using SDS single-step debugger
References: <005701c1cad8$d397eb60$6649a8c0@LEIYINGDU>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Leiying Du wrote:
>
> When I run the kernel ELF, I always get this error message "Couldn't find
> 4096 bytes at 4096 alignment". It's printed out in  __initfunc(void *
> find_mem_piece(unsigned size, unsigned align)).   ( The kernel runs Ok from
> the flash memory.) Does anyone know the reason? Should I initialize the MMU
> with the debugger? Thanks.

My guess is that you haven't setup a board info struct so the
bi_memsize is uninitialized.  This can cause the system to think that
no memory is available so anything that tries to get memory fails.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
