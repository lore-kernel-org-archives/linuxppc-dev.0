Message-ID: <3ED7EFB4.2050400@mvista.com>
Date: Fri, 30 May 2003 16:56:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Internal interrupts on the MPC107
References: <1054119003.23151.23.camel@newt>
In-Reply-To: <1054119003.23151.23.camel@newt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian,

I took a look at your code and at the manual.  The description in the
manual that applies to the register that you're using to give you the
intr vector is (from MPC8240 User's Manual, section 12.9.8.3 (p.12-24)
(IIVPRs) which directs us to section 12.9.7.4 (pp. 12-21 - 12-22) (GTVPR):

    Bits 7-0, Reset Value: 0x00:
    Vector - The vector value in this field is returned when the
    interrupt acknowledge register (IACK) is read, and the interrupt
    assoctiated with this vector has been requested.

This is a programmable/writeable register--seemingly, with the 'vector'
field functioning similar to the PCI cfgspc "Interrupt Line"
register--where the fw or early kernel init code sets it up with the
correct IRQ and the driver later reads it to get the IRQ.  My guess is
that your board's fw (or early kernel init code) is setting it up with
the correct value but on the other systems you mentioned, the fw doesn't
(and the reset value of 0x00 is returned).  Basically, if I'm
interpreting the manual correctly, you probably need to do something
other than count on the fw setting up that field in that reg correctly.

The way we do IRQ with openpic has changed.  The "old way" didn't allow
you to specify which vectors you wanted to initialize/use and the vector
# depeneded on the offset of the vector reg.  The board-specific code
had to fill out *_openpic_initsenses[] so that it would initialize the
vectors you wanted initialized (with unfortunate side effect of
initializing/writing locations you may *not* want written).  For the
"old way", the IRQ calculation would go something like (this is back of
the envelope to I may be off a little):

    a) The I2C IIVPR0 reg is at offset 0x51020 from start of EUMB
    b) 0x51020 - 0x50200 (base of the IRQ vectors in the EUMB) == 0xe20
    c) 0xe20 / 0x20 (32 bytes taken by each vector) == 0x71 == 113
decimal is the IRQ.
    d) 113 needs to be translated by any other PIC/IRQs that are in the
system.  For example, if there is an 8259 consuming IRQs 0-15, you need
to add 16 to the 113.  In reality, this probably means that all you need
to do is add in the value in open_pic_irq_offset (you'll have to make it
non-static).  Also, you should modify your openpic_initsenses to
initialize the I2C section.

So, if your kernel uses the "old way", it should be pretty simple to do
generically in your driver.

The "new way" of initializing the openpic uses the openpic_set_sources()
routine which allows you to select just the vectors you want to
initialize and assign them the IRQ values that you want (independent of
their offset).  Much nicer and it doesn't write to vectors/locations
that you don't want written.

The problem for an I2C driver is that the IRQ is now board specific.

So what to do?  Well, the board-specific file needs to initialize the
I2C vector.  Also, there has to be some mechanism for the board-specific
file to tell your driver what the IRQ is.  Maybe the best solution is to
have the board-specific code set up the vector field in the IIVPR0 reg
with the proper IRQ and then your driver won't need to change.  Seems
fairly clean but you'll have to hack the board-specific code of any
boards that will use the I2C driver.

Anyway, its Friday and I'm starting to ramble.  I hope this gives you
something to think about.

Mark
--
Adrian Cox wrote:

>I have an interrupt driven driver for the I2C controller of the MPC107
>and MPC8245:
>
>http://www.humboldt.co.uk/mpc10xi2c.html
>
>In this driver I attempt to find the interrupt vector for I2C by reading
>it directly out of the EPIC hardware in the driver initialisation code:
>
>	i2c_vec = readl(epic_base + 0x11020) & 0xff;
>
>This works fine on my custom board based on the linuxppc_2_4_devel
>kernel, but caused problems for an end user using a 2.4.17 kernel from
>Montavista. On that kernel, the EPIC register at offset 0x11020
>contained 0. Another user with an unknown kernel found 0 in the
>register, but was able to make progress by hardcoding the IRQ number 20.
>
>Does anybody have any suggestions for a generic solution? I'd like to
>get the driver into the kernel at some point, but this part of the code
>seems a bit too ugly for now.
>
>- Adrian Cox
>http://www.humboldt.co.uk/
>
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
