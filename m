Date: Sat, 14 Aug 1999 17:30:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Otto Moerbeek <otto@cable.a2000.nl>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Design issues Keyspan serial PCI driver
In-Reply-To: <37B46883.9EAFF03@cable.a2000.nl>
Message-ID: <Pine.LNX.4.10.9908141606000.575-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 13 Aug 1999, Otto Moerbeek wrote:
> after some struggling I now have a very first working version of the
> Keyspan SX
> serial card driver, but I do not think the code I wrote is ready for
> publishing. To make a neat driver I have some design issues I want to
> share with you. Hopefully this will help me making the right decisions
> for the real driver.
> 
> The Keyspan SX cards use a PLX9050 as PCI bridge to connect to an
> ST16C654 UART. I found some patches for char/serial.c that support the
> UART directly. So this part of the problem was solved easily.
> 
> But Keyspan choose to map the UART to PCI memory space using the 9050,
> not PCI I/O space. Furthermore, for some unknown reason, the registers
> of the UART are separated 0x80 apart. Since char/serial.c uses I/O
> instructions to access the UART, I had to hack the driver to use readb()
> and friends. I am also multiplying the offset to compensate for the
> strange offsets.

Please also post your message on linux-kernel@vger.rutgers.edu, since this is
of interest not only for Linux/PPC development.

> The good news of course is, if I can resolve the above issues, I have a
> driver that can access both I/O based and memory based PCI cards. The
> start of proper PCI serial card support in the standard serial driver?

That would be great!

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
