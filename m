Message-ID: <42AB6BE23C29D511831E0002B32024881999FF@messenger.radlan.co.il>
From: Ofer Rashuk <OferR@Radlan.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: virtual memory issue
Date: Sun, 4 Nov 2001 10:42:58 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.
on my custom board with PPC8240 I'm trying to run some small user space
program.
the program tries to read a device (Galileo device) that on the PCI bus.
i configured the access to the device using mmap and got a pointer with a
virtual address.

my question is who can i translate the virtual address to a physical one.
i tried it use several functions such as virt_to_phys and virt_to_bus but i
keep getting a compilation error
target/user/include/asm-ppc/io.h:214:undefined reference to 'iopa'

what am i doing wrong, is there any lib that I'm forgetting.

my compile line is as follows:
.c.o:
	$(CC) $(CFLAGS) -c $*.c

CFLAGS	= -g -Wall -O2 -I. -D_GNU_SOURCE -D_REENTRANT

#---------------------------------------------------------------------------
-
# Make the program...
#---------------------------------------------------------------------------
-
OBJS =  \
	task.o queue.o vqueue.o event.o memblk.o timer.o sema4.o demo2.o

PROG = demo

all:	$(PROG)

$(PROG): $(OBJS) Makefile
	$(CC) $(CFLAGS) $(OBJS) -o $(PROG) -lpthread



Ofer Rashuk-Rosenthal.
Software team leader.
mailto:oferr@radlan.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
