To: Paul.Mackerras@cs.anu.edu.au
Cc: alan@cymru.net, jskov@cygnus.co.uk, cort@persephone.cs.nmt.edu,
        linuxppc-dev@lists.linuxppc.org, linux-apus@sunsite.auc.dk
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
References: <199901142052.UAA24588@snowcrash.cymru.net> <199901150157.MAA01789@tango.anu.edu.au>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 15 Jan 1999 09:40:13 +0100
In-Reply-To: Paul Mackerras's message of "Fri, 15 Jan 1999 12:57:32 +1100"
Message-ID: <d3hftt7wuq.fsf@valhall.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

Paul> Alan Cox <alan@cymru.net> wrote:
>> > eieio: prevent CPU from reordering/collapsing reads/writes to
>> memory.  > (but otherwise run at full steam!)
>> 
>> Thats what mb() does - its a memory-barrier hence the name - it
>> imposes strong store ordering properties across it.

Paul> My understanding of the original mb() (and correct me if I'm
Paul> wrong) was that it basically said "an interrupt or another
Paul> processor might have changed memory, so don't keep values from
Paul> memory cached in registers".  With wmb() on SMP, this seems to
Paul> be extended to include "make sure other cpus can see the values
Paul> we just wrote".  I don't know exactly how rmb() differs from
Paul> mb().

Hmmm

My understanding is that mb() is also meant to ensure that
instructions are issued in the right order, ie. like cases where we
want to read data out of a register in a device before resetting it or
something:

  data = regs->dat;
  mb();
  regs->reset = 1;

Maybe I am missing something, but at least thats the assumption I work
from when I use mb()'s. I haven't noticed wmb()/rmb() and checking the
code I see that these are not defined for the m68k nor the Sparc
ports.

The question is whether it makes sense to introduce the io_barrier()
macros at all or mb() is sufficient as it is. I think it is and I'd
prefer not to try and convince all the other ports to use a new macro
unless we have a real good reason for doing so.  Most cases where you
would use mb() (sync on the PPC) are slow access anyway so as far as I
can see it really doesn't cost that much to let mb() do the sync.

Jes

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
