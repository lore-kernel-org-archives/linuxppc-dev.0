Message-ID: <3C640532.5000708@embeddededge.com>
Date: Fri, 08 Feb 2002 12:04:50 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: bart@ardistech.com
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: Re: MPC823: i2c-algo-8xx read interrupt?
References: <3C63EC39.ACEECA08@ardistech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bart@ardistech.com wrote:


> When testing with i2c reading an eeprom on a MPC823e I get the message "IIC
> read; complete but rbuf empty".

What speed processor and what kernel?

> .... IMHO this is because the interrupt in the TX
> buffer is enabled intead of the the interrupt of the RX buffer. Is this a bug
> or is there a reason behind this?

The transmit and receive run concurrently on the I2C controller.  This is why
the transmit interrupt is always used.  Basically, on a read the transmit
buffer contains the device information to be written, and when the bus is
turned around the received data ends up in the receive buffer.  The transmit
provides all of the timing for the bus, which is why you need a "dummy"
transmit buffer that includes the length you want to receive.

A couple of things could be happening.  One is that the latency of clearing
the receive BD ready flag is longer than the interrupt processing overhead, but
I don't believe this is the case except that you say when you wait for the
receive interrupt it works OK.  Another is that the device isn't properly
terminating the I2C transfer (you tell it to transfer more bytes that the
dummy transmit clocks out), so you have to wait for a recieve time out to
close the BD.  If you wait for the receive interrupt, are there any errors
posted in the BD?  Does the receive buffer contain the proper data even when
the transmit complete occurs?

One of the reasons for using the transmit interrupt is when there are receive
errors, you still get an interrupt to go looking at the receive BD.  Maybe
the newer parts work differently and we need to accomodate this.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
