Date: Mon, 19 Nov 2001 00:13:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: powerpc wmb()
Message-ID: <20011119001305.E3896@krispykreme>
References: <8766885j7w.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8766885j7w.fsf@fadata.bg>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

[ yes this is a better place than debian-powerpc for this sort of
  conversation :) ]

> wmb is defined as
>
> #define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
>
> however, ``eieio'' has no effect on memory, that is
> Write Through Not Required, thus I think it should be
>
> #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")

While the original ppc spec did not guarantee eieio ordered writes
to caching allowed, write through not required, memory coherence
required storage, there have been modifications since:

http://www.rs6000.ibm.com/tech/ppc-chg2.html

Look for the change "Book II, Section 3.3, page 350"

My understanding is that the earlier chips completed stores in order
which allowed the above change to be made safely, but I am not 100%
on this.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
