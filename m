Message-ID: <20020411031445.29017.qmail@kunk.jriver.com>
Subject: YAM kernel driver IRQ question
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 10 Apr 2002 22:14:45 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to make the YAM kernel driver work with a 16550 PCI
board. I've got kernel 2.4.19-pre4-ben0. Haven't had any luck
with replies from the author so I thought I'd ask here.

The YAM is a HAM device. It works fine in intel linux AND on
an PPC rs6k PREP linux box so it doesn't appear to have endian
problems.

The YAM uses the serial hardware DIRECTLY without using the
kernel serial driver. It uses some of the hardware status
lines for purposes other than what a normal serial port does.

On the PREP machine, the serial ports are just like a PC, COM1 on
3F8 irq 4 and COM2 on 2F8 irq 3.

On my 7500 the board shows up on 0x890 and 0x880 on IRQ 24.
The YAM driver handles the port ok but chokes on the IRQ. In the
code it was checking the specified IRQ against a maximum of 15
(PeeCee mindset). I changed it to 31 and the driver tries to
run but I get an error that appears to indicate the interrupts are
not working.

I know the board is working OK because I can use setserial on port
0x890 and irq 24, throw a modem on it and all is well..

What I'm wondering is if anyone who knows about the enabling,
etc of IRQS on pmacs can tell me if there anything I might have
to look out for when enabling interrupt 24 as against interrupt 3
(for example)...

Thanks,
Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
