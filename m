Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 51DB767A2F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 09:32:58 +1000 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id j34NWsf12197
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Apr 2005 19:32:54 -0400 (EDT)
Message-ID: <4251CEA4.6070604@nortel.com>
Date: Mon, 04 Apr 2005 17:32:52 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: somewhat OT -- trying to build code on the fly then run it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I'm writing a testcase to test some code we wrote to allow userspace to 
flush the whole dcache and invalidate the whole icache.  This requires 
me to write self-modifying code.  For the first stage I'm just trying to 
build a routine (that just increments r3 and returns) on the heap and 
then call it.

Everything seems to be fine right up until I jump to the code that I've 
written, then I get a segfault.  The debugger shows my registers and 
data values are as expected, and the page of memory has xwr permissions.

Can anyone tell me what I'm missing?  I'm sure its something simple.

Thanks,

Chris.


PS.  Here's my current test code.

#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdio.h>
#include <sys/mman.h>

/* these next two lines are the hex equivalents of the instructions:
  * addi r3,r3,1
  * blr
  */
unsigned int incr_code[] = {
	0x38630001,
	0x4e800020
};

int dotest(unsigned long *addr)
{
         int i=0;
         asm volatile (" \n\
                 mr 3,%1 \n\
                 bla %2  \n\
                 mr %0,3 \n"
                 : "=r" (i)
                 : "r" (i), "r" (addr));
         return i;
}

void alter_opcode(unsigned long *addr, unsigned long opcode)
{
	unsigned long offset = 0;
	
	asm volatile(
                 "stw    %1,0(%0)  \n\t"
                 "dcbf   %0,%2     \n\t"
                 "sync             \n\t"
                 "icbi   %0,%2     \n\t"
                 "sync             \n\t"
                 "isync            \n\t"
                     :: "r" (addr), "r" (opcode), "r" (offset));
}

int main()
{
	unsigned long *addr;
	void *p = mmap(0, 4096, PROT_EXEC|PROT_WRITE|PROT_READ,
		MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
	if (p == MAP_FAILED) {
		perror("mmap");
		goto error;
	}
	
	addr = (unsigned long *)p;
	
	alter_opcode(addr, incr_code[0]);
	alter_opcode(addr+1, incr_code[1]);
	
	printf("%d\n", dotest(addr));
	return 0;
	
error:
	return -1;
}
