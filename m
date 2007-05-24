Return-Path: <dzu@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 13E3DDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 23:18:47 +1000 (EST)
To: linuxppc-dev@ozlabs.org
Subject: Problems in 2.6 memory management on 8xx
From: Detlev Zundel <dzu@denx.de>
Date: Thu, 24 May 2007 15:07:22 +0200
Message-ID: <m2fy5mcqut.fsf@sowhat.denx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=NSA-Uzi-CIA-Soviet-bomb-KGB-Clinton"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=NSA-Uzi-CIA-Soviet-bomb-KGB-Clinton

Hi,

working on a 2.6.16 kernel on a 870 CPU, I ran into this strange
behaviour exemplified by the simple attached demo program.  An icbi
from userspace on an address that is mapped only lazily gets into an -
though interruptible - loop. Locking the icbi target in question with
mlock circumvents this problem.

I tested this code on 2.6.21 on 4xx and 82xx only to prove that those
combinations, as expected, don't have this problem.  Vitaly Bordug was
kind enough to test the code on an 8xx hw supported by a recent kernel
and acknowledged it still being present.

As I don't have time to investigate this any further, I at least want
to document this problem with this post.  Maybe someone else can help
out here.

Thanks
  Detlev

-- 
-- Question authority!
-- Yeah, says who?
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de

--=NSA-Uzi-CIA-Soviet-bomb-KGB-Clinton
Content-Type: text/x-csrc
Content-Disposition: inline; filename=icbi.c

/* Test code to show problem with handling of icbi in userspace on
   PowerPC in Linux 2.6 */
#include <stdio.h>
#include <unistd.h>

extern void test();

int main(int argc, char *argv[])
{
#if 0
	/* Lock the text segment of the test routine so that the pages will
	   be present in RAM - otherwise the ICBI will not work */
	mlock((void *)&test, 3*4096);
#endif
	test();
	printf("move on - there's nothing to see here\n");
	return 0;
}

--=NSA-Uzi-CIA-Soviet-bomb-KGB-Clinton
Content-Type: text/x-csrc
Content-Disposition: inline; filename=icbi_trigger.S

	.globl	test

/* Align to MMU page size, i.e. 2^12 = 4k */
	.align 12
page0:	
test:
	mflr	%r20	

	/* invalidate first cache line at page1 */
	lis	%r24, page0@h
	ori	%r24, %r24, page0@l
	li	%r23, 0x1000
	icbi	%r24, %r23

	b	test_return

	.org	page0+4096
/*
 page1 is on a new 4k page - only fill it with "mtmq r0" (sigill)
*/
page1:

/* Ensure that page2 again is on a new 4k page */
        .org	page1+4096
page2:

test_return:
	mtlr	%r20			/* restore lr */
	blr

--=NSA-Uzi-CIA-Soviet-bomb-KGB-Clinton
Content-Disposition: inline; filename=Makefile

CC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)as
CFLAGS=-g

%.o:	%.S
	$(CC) -c -o $@ $<	

all:	icbi

icbi:	icbi.o icbi_trigger.o

clean:
	rm -f *.o *~ icbi
--=NSA-Uzi-CIA-Soviet-bomb-KGB-Clinton--
