Date: Tue, 16 Feb 1999 14:18:04 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs
In-Reply-To: <19990216134514.022163@mail.mipsys.com>
Message-ID: <Pine.HPP.3.96.990216141435.1977G-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 16 Feb 1999, Benjamin Herrenschmidt wrote:

> On Tue, Feb 16, 1999, Gabriel Paubert <paubert@iram.es> wrote:
> 
> >However, I have question about sync: how do the bridges handle a sync
> >bus operation after a posted write ? If they don't flush the write
> >queues, it means that the only solution for the 8259 is to read again the
> >interrupt mask after having written it when masking an interrupt. 
> 
> I beleive the sync is _not_ forwarded to the bridge, at least not on the
> MPC106. I fixed the "bogus interrupts" problem on pmac by adding, after
> the sync, a loop that reads the mask until it's actually the value that
> we wrote. I beleive a single read is enough to flush the bridges, but I
> am a little bit paranoid as far as Apple's interrupt controller is
> concerned so I added the loop.

Please forgive the noise. I just checked that the 603 and 750 do not
perform any bus operation when excuting sync or eieio. So the only
solution when disabling an interrupt is to read again the same register in
the controller (which is guaranteed to be ordered). OTOH 604 perform bus
operations on eieio and sync, but it still has potential problems with
posted writes IMHO. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
