In-Reply-To: <Pine.HPP.3.96.990216174706.1977L-100000@gra-ux1.iram.es>
Date: Tue, 16 Feb 1999 19:11:48 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootstrap stuffs
Message-Id: <19990216191148.002398@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 16, 1999, Gabriel Paubert <paubert@iram.es> wrote:

>So, if I'm not mistaken, a read from the same location is the only
>operation that guarantees that the register has actually been updated, but
>it's even slower than a sync :-(

On a side note, there is an interesting implementation of interrupts in
MkLinux mach kernel. Since they consider the controller as a really slow
device (and this seems to be confirmed by the bogus interrupt we had on
PowerMacs), they actually do it differently:

Mach maintains the current interrupt mask locally in RAM. When it
disables an interrupt, it does so only in the mask, the controller gets
updated only if this interrupt actually occurs. The enable code will
enable it in the mask only if it has been disabled by the interrupt.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
