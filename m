Message-ID: <3DE2ACE4.7070209@embeddededge.com>
Date: Mon, 25 Nov 2002 18:06:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: "Montgomery, Tim" <timm@artesyncp.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC RTC on I2C
References: <F9102D41F595D311ACA7009027DE2C84033FFE27@c3po.heurikon.com> <20021125161239.A20831@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> I always thought that one would implement some low-level ppc-specific
> i2c master access functions.

It depends upon the board implementation.  If you have devices other
than the RTC on the I2C bus it becomes a big mess.  I've had a couple
of boards with I2C RTCs, but it was the only device connected to
a couple of special purpose GPIOs, so I just used a minimal software
toggle function to do the job.  You have to keep in mind the RTC is
usually updated during the timer interrupt, not a place you want to
be calling the heavyweight I2C layer, especially if there are other
devices you may get queued behind on the bus. :-)

The timer RTC functions are written assuming you only need a
few, low latency, register accesses to read or update the RTC.  This
is also done to ensure hardware clock synchronization.  Placing an
access like this on an I2C queue, if it can be made to work, will
certainly break this synchronization.

> ...  These would be available via a few
> ppc_mds and one could have a generic i2c 'adapter' to call the
> functions.

There are already ppc_mds to read/write the RTC time from the kernel
timer functions.  You just need to install something that Does The
Right Thing. :-)

> ....rather than using the generic PPC RTC
> device.

The problem with the "generic" RTC functions is they assume one of
a few possible parts connected in one of a few possible memory mapped
methods.  I can't use CONFIG_PPC_RTC on many embedded boards, I just
let the board configuration select the RTC support functions.  Yes, it
may be I2C but I don't configure I2C to make it work.

> .... When the full driver is
> initialized then accesses would occur in the normal manner.

I don't think this would ever work for the kernel RTC access.  Check
into it very carefully before you commit to this path.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
