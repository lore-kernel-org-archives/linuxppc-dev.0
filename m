Message-Id: <200001211732.MAA24780@mal-ach.watson.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
cc: khendricks@ivey.uwo.ca
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Date: Fri, 21 Jan 2000 12:32:39 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


asm volatile ("stwbrx %1,%2,%3; eieio"
	: "=m" (*(volatile unsigned *)(base_addr+regindex))
	: "r" (regdata), "b" (regindex), "r" (base_addr));

asm volatile ("lwbrx %0,%1,%2; eieio"
	: "=r"(val)
	: "b"(regindex), "r"(base_addr),
	  "m" (*(volatile unsigned *)(base_addr+regindex)));

BTW, one of the main stylistic points which confused me yesterday is that
the inlined assembly statement associates variable "regindex" with the
second parameter of the instruction and varable "base_addr" with the third
parameter of the instruction.  As long as the second parameter is not
assigned to register r0, the two are commucative in their function, so
this is not an error.

	In the instruction architecture, the second parameter is intended
to be the base and the third as the index, so it is confusing for someone
familiar with the POWER and PowerPC instruction set to read the order in
which the parameters are assigned.  Instructions loading from addresses
with displacements, e.g.,

	lwz %0,%1(%2)

specify the displacement second and the base register last, so the
ordering can get confused.  That was what threw me off yesterday in my
haste.

David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
