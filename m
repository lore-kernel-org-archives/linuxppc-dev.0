In-Reply-To: <13981.45420.95483.559227@lassi.cygnus.co.uk>
Date: Thu, 14 Jan 1999 14:27:52 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Cort Dougan <cort@persephone.cs.nmt.edu>, Jesper Skov <jskov@cygnus.co.uk>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
Message-Id: <19990114142752.015604@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 14, 1999, Jesper Skov <jskov@cygnus.co.uk> wrote:

>We would want to use eieio for drivers and such accessing their
>controller in a strict serialized manner. We would want to use sync
>for SMP related stuff since it ensures, well, synchronization between
>multiple CPUs wrt memory access.

And I'll add the usual warning: If the device is a PCI device and you
need to make sure that the write actually reached the device (for example
making sure the interrupt enable bits are set before re-enabling the
interrupts on the CPU), you should add a read from the same device (from
the same bus should be enough) to make sure tall the bridges in the path
to the device completed their write.
Remember that a write to PCI is usually a "posted write" and so is
asynchronous, regardless of eieio or sync's done on the CPU.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
