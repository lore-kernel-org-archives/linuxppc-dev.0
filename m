In-Reply-To: <Pine.LNX.3.96.981231144829.14374A-100000@persephone.cs.nmt.edu>
Date: Thu, 31 Dec 1998 23:24:53 +0100
To: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@persephone.cs.nmt.edu>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: grackle, patches, MMU, ...
Message-Id: <19981231232453.013798@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 31, 1998, Cort Dougan <cort@persephone.cs.nmt.edu> wrote:


>The # of free bats depends on the machine.  We'd only have all the bats
>free if we map without the BATS entirely.  We don't to switch between
>mapping with and without BATS on the kernel depending on the process.

Ok. I knew for the variable number of BATs. So currently, the BATs are
set once
for all for the kernel, and stay this way in user mode. Getting them
beeing switched on a per-process basis would require changes still beyond
my current knowledge about the kernel. I'll try to understand all this
and I'll eventually code some test stuffs. Once BATs are switched, we can
use them for large ioremaps.

>PCI is a lot bigger than one bat.  On prep we map all the pci space we use
>with a bat.

Yep, of course, I was thinking about what is currently allocated, and
this is usually fine for one BAT.

For the curious, MacOS uses BATs too, but it can only use BATs for PCI,
no pages :-( This makes things quite funny when trying to use several
cacheable regions on a board.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
