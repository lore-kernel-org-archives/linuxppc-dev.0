Message-ID: <E1836A7F3557D311A14000805F9F36FC01518835@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'Dan Malek'" <dan@embeddededge.com>, bart@ardistech.com
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: RE: MPC823: i2c-algo-8xx read interrupt?
Date: Mon, 11 Feb 2002 16:49:36 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	>> The way I interpret the data sheet (I assume the 823 and 860 are
similar) is that I get the TX
	>> interrupt when the I2C address is sent plus the two character
times. The rest of the TX buffer
	>> is just a place holder and will not be sent.

	>Not correct.  The data isn't sent on the data lines, but the CPM
decrements the
	>counter and uses it to time the receive transfer.  The I2C thinks
it is sending
	>something, but the bits just fall off the sand into a bucket.  It
is used to generate
	>the timing of the clock and count how many receive bytes you wish
to acquire.

According to the MPC823e User's Manual:

"The I2C receiver and transmitter are double-buffered, which corresponds to
an effective
FIFO size of 2 characters. The MPC823e I2C bit 0 (MSB) is shifted out
first." pg. 16-456

I interpret this to account for the additional two character clock times
you'll need to do.

Just my $.02,
     Michael Pergola
     Software Engineer
     Baltimore, MD  21236     (410) 931-6778 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
