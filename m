Message-ID: <37B46883.9EAFF03@cable.a2000.nl>
Date: Fri, 13 Aug 1999 20:48:36 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
Reply-To: otto@cable.a2000.nl
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Design issues Keyspan serial PCI driver
References: <199908130501.AAA18955@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi to you all,

after some struggling I now have a very first working version of the
Keyspan SX
serial card driver, but I do not think the code I wrote is ready for
publishing. To make a neat driver I have some design issues I want to
share with you. Hopefully this will help me making the right decisions
for the real driver.

The Keyspan SX cards use a PLX9050 as PCI bridge to connect to an
ST16C654 UART. I found some patches for char/serial.c that support the
UART directly. So this part of the problem was solved easily.

But Keyspan choose to map the UART to PCI memory space using the 9050,
not PCI I/O space. Furthermore, for some unknown reason, the registers
of the UART are separated 0x80 apart. Since char/serial.c uses I/O
instructions to access the UART, I had to hack the driver to use readb()
and friends. I am also multiplying the offset to compensate for the
strange offsets.

I would really like to use the char/serial.c driver and keep it
compatible with existing cards, because I do not want to write a
complete driver myself for a UART that is supported by standard code.
But then I have to decide runtime to use inb() and outb() or readb() and
writeb(), since the driver also may be used for other cards that use I/O
based access. Do you think that this would cause too much overhead in
the interrupt handlers? It means that every I/O access will be slowed
down by some extra memory references and a test.

Another point is that the serial structs use an int as the type for the
port field. Since cannot change the struct in include/linux/serial.h to
use u8 * as a type for compatibility reasons, I have to find some way to
use the port as an offset added to some memory mapped base pointer of
type u8 *, instead of using port as an absolute (I/O or mem) address.
Just using the int port as a memory address value is dangerous, since it
 won't work on 64 bits architectures. Do you think this is the way to
go: keeping compatibility with applications that expect port to be an
int, while still be able to do memory mapped PCI access?

The good news of course is, if I can resolve the above issues, I have a
driver that can access both I/O based and memory based PCI cards. The
start of proper PCI serial card support in the standard serial driver?

You can find some more background info on my home page, <http://people.a2000.nl/omoerbe/>

Sorry for the long winding story, but I really would like some feedback,

Otto
-- 
Otto Moerbeek
otto@cable.a2000.nl

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
