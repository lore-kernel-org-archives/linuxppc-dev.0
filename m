In-Reply-To: <199910260457.XAA34718@brahma.ticam.utexas.edu>
Date: Tue, 26 Oct 1999 11:29:03 +0200
To: chris mccraw <chrism@brahma.ticam.utexas.edu>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: IR on lombard?
Message-Id: <19991026112903.024351@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 25, 1999, chris mccraw <chrism@brahma.ticam.utexas.edu> wrote:


>this functionality seems to have been present or at least touched on for
>the wallstreet powerbooks judging from the code in
>	drivers/macintosh/macserial.c
>but my (weak) attempts to force the second serial port into the role of
>wallstreet powerbook_ir seem to have failed.

On my wallstreet, ttyS1 is automatically recognized as an IR port, isn't
this the case on your machine ? In this case, I'm interested in a dump of
the device tree portion that contains the escc nodes on your machine.

Also, the code for enabling the IR led is a big guess from spying MacOS,
I'm not 100% sure it's correct. (I'm sure MacOS will send this PMU
command whenever the port B is opened on my wallstreet) but it is
probably not enough. Most IR tranceiver also need to be configured by
sending a special sequence via the flow control lines to configure it to
the appropriate baudrate. ideally, one should either find out which kind
of tranceiver is in the machine, or with an oscilloscope, spy the
sequence sent by MacOS so we can reproduce  it.

>i did get the kernel to print "(powerbook IR)" next to the serial port init
>by forcing zss->is_pwbk_ir to "1" in macserial.c (around line 2270)
>but with no effect on the actual performance of the port.
>
>turning on serial debugging shows that performing operations on /dev/ttyS1
>seem successful (the port is opened, speed set, etc) but it doesn't answer
>the pilot (as an x86 laptop with serial-IR did), nor show any actual
>traffic over the port when i send it a few bits from the pilot.
>
>i'm also not even sure that the second serial port detected on boot is
>in fact the IR port...that's just a guess i cannot confirm or deny
>after reading all the info i could find on the paddington and the pbg3-1999
>on apple's site.

If you have only two ports and the first on is the internal modem, then
the second one is the IR port. Again, you should have more details in the
device tree node of this port.

>i am working with 2.2.13 from paul's tree synced this afternoon.
>
>so, does anyone know if serial/IR is supposed to work on the lombards, or
>have further suggestions for me to poke at it with?
>
>much in your debt,


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
