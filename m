Message-ID: <003a01c03a96$847a8020$0a00010a@airvent.it>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA on M8xx: unresolved symbols _insw & _outsw
Date: Fri, 20 Oct 2000 15:06:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to port the Samsung MagicLan SWL2000 PCMCIA socket client driver
to our MPC8xx, using the magnus damm socket drivers, but when loading our
driver (swld11_cs.o) cardmgr reports that there are unresolved symbols on
the object, that are named _insw & _outsw.

To compile this driver i used the sources given us from Samsung, and i
really dont know how to include that symbols into my object instead looking
for them elsewhere. Aren't them memory mapped i/o instructions? Why the
compiler does not include them?

This is the script the i use to compile my driver:

include ../config.mk
include ../crosscomp.mk

LIB := ../lib

CFLAGS = -O2 -Wall -Wstrict-prototypes -Winline -pipe

CPPFLAGS = $(PCDEBUG) -D__KERNEL__ -DMODULE -I../include \
    -I$(LINUX)/include -I$(LINUX)

OBJS = ../lib/semtxrx_cs.o ../lib/semutil_cs.o ../lib/semwep_cs.o

all: swld11_cs.o

swld11_cs.o: swld11_cs.c semmgmt_cs.o
 $(CC) -MD -c $(CFLAGS) $(CPPFLAGS) $< -o .$@
 @mkdir -p .depfiles ; mv swld11_cs.d .depfiles
 $(LD) -r -o $@ .$@ semmgmt_cs.o $(OBJS)
 rm -f .$@ ; chmod -x $@

Can you help me? There's a virtual-coke waiting for you! 8-)

- may the pinguin b with u -

Have a nice day,
Paolo Scaffardi.
AIRVENT SAM s.p.a. - RIMINI - ITALY


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
