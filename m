Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 451F567A6D
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 11:06:50 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4251CEA4.6070604@nortel.com>
References: <4251CEA4.6070604@nortel.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 11:03:25 +1000
Message-Id: <1112663005.26086.134.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: somewhat OT -- trying to build code on the fly then run it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-04-04 at 17:32 -0600, Chris Friesen wrote:
> I'm writing a testcase to test some code we wrote to allow userspace to 
> flush the whole dcache and invalidate the whole icache.  This requires 
> me to write self-modifying code.  For the first stage I'm just trying to 
> build a routine (that just increments r3 and returns) on the heap and 
> then call it.
> 
> Everything seems to be fine right up until I jump to the code that I've 
> written, then I get a segfault.  The debugger shows my registers and 
> data values are as expected, and the page of memory has xwr permissions.
> 
> Can anyone tell me what I'm missing?  I'm sure its something simple.
> 
> Thanks,
> 
> Chris.
> 
> 
> PS.  Here's my current test code.
> 
> #include <errno.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdio.h>
> #include <sys/mman.h>
> 
> /* these next two lines are the hex equivalents of the instructions:
>   * addi r3,r3,1
>   * blr
>   */
> unsigned int incr_code[] = {
> 	0x38630001,
> 	0x4e800020
> };
> 
> int dotest(unsigned long *addr)
> {
>          int i=0;
>          asm volatile (" \n\
>                  mr 3,%1 \n\
>                  bla %2  \n\
>                  mr %0,3 \n"
>                  : "=r" (i)
>                  : "r" (i), "r" (addr));
>          return i;
> }

bla can only be used for small addresses (or very high addresses), and
it doesn't take a register argument but an absolute address. You want
something different, more like

	mtctr %2
	bctrl

Though you also need to add proper "clobber" constraints to indicate to
the compiler what will be clobbered by the routine you are calling (look
at the syscall macros of the kernel for an example of rather standard
clobber lists).

> void alter_opcode(unsigned long *addr, unsigned long opcode)
> {
> 	unsigned long offset = 0;
> 	
> 	asm volatile(
>                  "stw    %1,0(%0)  \n\t"
>                  "dcbf   %0,%2     \n\t"
>                  "sync             \n\t"
>                  "icbi   %0,%2     \n\t"
>                  "sync             \n\t"
>                  "isync            \n\t"
>                      :: "r" (addr), "r" (opcode), "r" (offset));
> }
> 
> int main()
> {
> 	unsigned long *addr;
> 	void *p = mmap(0, 4096, PROT_EXEC|PROT_WRITE|PROT_READ,
> 		MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> 	if (p == MAP_FAILED) {
> 		perror("mmap");
> 		goto error;
> 	}
> 	
> 	addr = (unsigned long *)p;
> 	
> 	alter_opcode(addr, incr_code[0]);
> 	alter_opcode(addr+1, incr_code[1]);
> 	
> 	printf("%d\n", dotest(addr));
> 	return 0;
> 	
> error:
> 	return -1;
> }
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
