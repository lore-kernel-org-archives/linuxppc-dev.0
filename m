Return-Path: <a.woellert@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 3288967C18
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jul 2005 02:02:00 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i24so564859wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 03 Jul 2005 09:01:58 -0700 (PDT)
Message-ID: <42C80BF6.6030508@gmail.com>
Date: Sun, 03 Jul 2005 18:01:58 +0200
From: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linuxppc-embedded@ozlabs.org
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
In-Reply-To: <20050701094438.GA11121@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Hi Anton,
> 
> 
> (moving to ppc-embedded since it might be of interesting for other 
> 8xx users)
> 
> On Thu, Jun 30, 2005 at 04:13:30PM +0200, Anton Wöllert wrote:
> 
> 
> Can you please examine in more detail what is going on here? 
> 
> What are the contents of the r0 and r6 registers, where exactly is the
> task stopped.

with backtrace in gdb i found out, that memset() (which is exactly the 
routine at sysdeps/powerpc/powerpc32/memset.S) called by 
_dl_allocate_tls_storage (sysdeps/generic/dl-tls.c). btw. memset is 
called 3 times before and there it works fine.
well, _dl_allocate_tls_storage invokes __libc_memalign 
(elf/dl-minimal.c). __libc_memalign should return an aligned area of 
memory for the tls-stuff (which later then will be memset'd with zero).
__libc_memalign now allocates an aligned memory block, but first looks 
if there is unused space in the previous page of its data-segment. if 
there is some, it will use that. if more than this is needed, it will 
call mmap with MAP_ANON|MAP_PRIVATE and PROT_READ|PROT_WRITE. it then 
looks, if the returned address lies at the end of the old page, if not, 
the old one will not be used (because then it wouldn't return an 
continuegous area of memory). will gdb, i saw, that mmap returns a 
address right after the previous page and so the block continuegous.
this block is now returned and given to memset.
memset now zeros out a part of the returned block. as long, as dcbz 
zeros out the memory, that lies in the old page (before 0x30001000) it 
works, but when it steps over that address (the page boundary), stepi in 
gdb just hangs and doesn't return anything ( except i press ctrl-c ).
i think, dcbz should cause a page fault, because the new page was 
allocated with PROT_READ|PROT_WRITE. i expect, that there is no handling 
for dcbz's in the page fault handler (which should be do_page_fault in 
arch/ppc/kernel/fault.c if i'm right).
other possibilities, like false cache_line_size etc should explain that, 
  because they are all set right (with gdb i inspected nearly 
everything, and memset should work as expected, and it does so in other 
scenarios).

sorry for not delivering the registers and so on, but actually i have no 
access to the board for one week :). i will post them later, if really 
needed, but throug my gdb-sessions, they seemed all to be right.

> 
> I _guess_ it might be some form of "dcbz" misbehaviour, in such case I 
> imagine that either the task would loop forever or execute an invalid
> exception/instruction.
> 

so what should be the real solution, deleting memset.S because the use 
of dcbz is not allowed or eventually fix the page-fault handler, because 
he didn't recognize dcbz's (if i'm right).

thanks for your help, anton
