Message-Id: <200107042222.SAA21410@makai.watson.ibm.com>
To: Jean-Jacques.Levy@inria.fr
Cc: k_fukui@highway.ne.jp, linuxppc-dev@lists.linuxppc.org
Subject: Re: __divdi3 unresolved + X pointer blocks 
In-Reply-To: Message from Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
   of "Wed, 04 Jul 2001 21:06:10 EDT." <200107050106.VAA01006@macaron.inria.fr>
Date: Wed, 04 Jul 2001 18:22:45 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Jean-Jacques Levy writes:

Jean-Jacques> I installed gcc-3.0 release, and remained with my undefined
Jean-Jacques> __divdi3. Then I patched inode.c in fs/fat and replaced two divisions
Jean-Jacques> by 512 by >> 9. The error disapeared.

Jean-Jacques> Either gcc-3.0 has a bug, either there is a missing module to
Jean-Jacques> implement long divisions (by 512!) in fs/fat.o

	It might be that GCC is not optimizing this division as strongly
as it should.  __divdi3 is a 64-bit signed divide.  A signed divide is not
the same as a shift.  Maybe the 64-bit variable is not declared as
unsigned when it should be?

	The Linux kernel does not link against libgcc.a, so any GCC
support routines (such as __divdi3) need to be provided explicitly.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
