Date: Tue, 21 May 2002 11:00:50 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: andrew may <acmay@acmay.homeip.net>,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	Armin Kuster <akuster@mvista.com>
Subject: Re: 405 I2C
Message-ID: <20020521110050.B20012@ecam.san.rr.com>
References: <1021995053.7265.22.camel@swb11> <20020521085924.F9190@ecam.san.rr.com> <1021997793.7265.36.camel@swb11>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1021997793.7265.36.camel@swb11>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 06:16:33PM +0200, Kenneth Johansson wrote:
> On Tue, 2002-05-21 at 17:59, andrew may wrote:
> > > Also I have a problem when accessing a device that is not present. The
> > > bus ends up in busy state an no other action can be taken. I solved the
> > > problem for me here by simply removing the test in iix_xfer but a proper
> > > solution has to be discussed. I have not tried Andrew's new iic_xfer is
> > > it going to be merged ??
> >
> > Does the scan bus work for you? It should go through and read from all
> > possible locations and report if a device is there. It works with my
> > iic_xfer but I don't rember if I tried the old one. It should have the
> > same effect as "accessing a device that is not present".
>
> No it's not the same the scan work ok. I have not looked into exactly
> why it works but my test program that reads 1 byte from userspace with
> i2c_smbus_read_byte_data() dose not. I hoped I did not have to dig thru
> too much into this as I don't know much about it.

well i2c...read_byte_data is really a write of 1 byte followed by a read
of 1 byte. The scan is just a read of 1 byte.

So you should be going through the combined xfer function.

This is some of the most respulsive cut and paste code I have ever seen.
They first got the function templates from a bit banging driver. They make
no sense for this driver since things like doAddress will never provide
any real status they just load up a register. Then they just copied the
the data transfer code in both read and send, each with  2 copies to handle
4 bytes or less than 4 bytes.

> > Which test in iix_xffer that?
>
> Good question I get a bit unsure of what is going on when I read it
> again but here is the test I removed. Everything works as I want when I
> remove it.
>
> /* When the bus is free, the BCS bits in the EXTSTS register are 0b100
> */
> 	if (ret != 0x40){
> 		return IIC_ERR_LOST_ARB;
> 	}

When I have tried the lm75 driver with this i2c_xfer I get the IIC0_EXTSTS
reg with BCS at 0b111. The manual seems to say that a IIC hardware problem has
occurred. You might try to output what your state is here.

Are things failing on your second read to a bad address? I would think your
first one at least gets past this check and fails somewhere else since at
this point there is really nothing that should have happened on the i2c bus.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
