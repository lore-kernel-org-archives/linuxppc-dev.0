Message-ID: <3C67E38C.2020304@embeddededge.com>
Date: Mon, 11 Feb 2002 10:30:20 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: bart@ardistech.com
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: Re: MPC823: i2c-algo-8xx read interrupt?
References: <3C63EC39.ACEECA08@ardistech.com> <3C640532.5000708@embeddededge.com> <3C640C11.4080407@cambridgebroadband.com> <3C6776CC.634AB65D@ardistech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bart@ardistech.com wrote:


> The way I interpret the data sheet (I assume the 823 and 860 are similar) is that I get the TX
> interrupt when the I2C address is sent plus the two character times. The rest of the TX buffer
> is just a place holder and will not be sent.

Not correct.  The data isn't sent on the data lines, but the CPM decrements the
counter and uses it to time the receive transfer.  The I2C thinks it is sending
something, but the bits just fall off the sand into a bucket.  It is used to generate
the timing of the clock and count how many receive bytes you wish to acquire.

> .... The RX interrupt is fired when all the RX bytes are
> received and written to mem.

How do you know when you have received the proper number of bytes?  Are we
always changing the value of mrblr (I don't remember the code anymore)?

> So I assume waiting for two char times would not help.

You could just poll the receive buffer for about two plus a little character
times.  If you don't get the empty flag cleared in this time report some error.

The interesting thing about any I2C controller is the overhead of trying to
manage this thing is higher than just clocking bits in software.  I seldom
use the I2C controller, just a few lines of C code to do the job.  Think about it.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
