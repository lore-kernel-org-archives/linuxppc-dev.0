Subject: Re: 405 I2C
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
To: andrew may <acmay@acmay.homeip.net>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	Armin Kuster <akuster@mvista.com>
In-Reply-To: <20020521110050.B20012@ecam.san.rr.com>
References: <1021995053.7265.22.camel@swb11>
	<20020521085924.F9190@ecam.san.rr.com> <1021997793.7265.36.camel@swb11>
	<20020521110050.B20012@ecam.san.rr.com>
Content-Type: text/plain
Date: 22 May 2002 12:36:36 +0200
Message-Id: <1022063796.7265.74.camel@swb11>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-05-21 at 20:00, andrew may wrote:

> well i2c...read_byte_data is really a write of 1 byte followed by a read
> of 1 byte. The scan is just a read of 1 byte.

Yepp thats the difference.

>
> So you should be going through the combined xfer function.

Yes your right I missed that. It dose look like it's the first write
that never get an ack. This is the debug output from a one byte read
from address 0 from a non existing device.

kernel: iic_xfer: iic_xfer: Clearing status register
kernel: iic_xfer: Waiting for any pending transfers to complete
kernel: iic_xfer: Clearing master data buffer
kernel: iic_xfer: Loading slave address
kernel: iic_xfer: Call combined transaction
kernel: Beginning combined transaction
kernel: This one is a write
kernel: iic_sendbytes: Waiting for interrupt
kernel: iic_ibmocp_handler: in interrupt handler
kernel: iic_ibmocp_handler: status = 26
kernel: i2c-algo-ppc405.o: fail: only wrote -1 bytes.

It dose look like I actually have to learn how this is supposed to work
we seem to have more than one problem with the current code :(





--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
