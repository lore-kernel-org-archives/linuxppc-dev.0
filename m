Date: Fri, 15 Jan 1999 09:50:05 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
Message-Id: <19990115095005.011809@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 15, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>I put a sync in for mb, rmb and wmb, which may be overkill.  Certainly
>I think the eieio that Cort added after the sync for these things is
>unnecessary.

The sync may still be useful for subtle situations where the driver may
require the access to be physically done before doing something else,
like turning on interrupts on the CPU or setting a shared flag which can
be used by another CPU. Usually, those drivers are broken anyway because
of the PCI posting which is rarely handled (it was apparently also the
cause of the bogus interrupts, see the fix I posted previously).

I suggest keeping sync() in mb's for max. compatibility, and
batch-changing mb() and eieio() in current PPC drivers to iobarrier()
which, in turns, does eieio()

>> x86 and most other processors dont have the notion of a store barrier and
>> an i/o barrier beign different
>
>On x86, i/o accesses are strongly ordered already.  On PPC the eieio
>instruction provides this sort of ordering (if you do it after each
>access).  So I think eieio is right for iobarrier_*.  Whether eieio
>would be sufficient for *mb(), or whether sync is needed, I'm not
>sure.  Certainly sync should be sufficient.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
