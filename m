Subject: Re: 405 I2C
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
To: andrew may <acmay@acmay.homeip.net>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	Armin Kuster <akuster@mvista.com>
In-Reply-To: <20020521085924.F9190@ecam.san.rr.com>
References: <1021995053.7265.22.camel@swb11>
	<20020521085924.F9190@ecam.san.rr.com>
Content-Type: text/plain
Date: 21 May 2002 18:16:33 +0200
Message-Id: <1021997793.7265.36.camel@swb11>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-05-21 at 17:59, andrew may wrote:
> > Also I have a problem when accessing a device that is not present. The
> > bus ends up in busy state an no other action can be taken. I solved the
> > problem for me here by simply removing the test in iix_xfer but a proper
> > solution has to be discussed. I have not tried Andrew's new iic_xfer is
> > it going to be merged ??
>
> Does the scan bus work for you? It should go through and read from all
> possible locations and report if a device is there. It works with my
> iic_xfer but I don't rember if I tried the old one. It should have the
> same effect as "accessing a device that is not present".

No it's not the same the scan work ok. I have not looked into exactly
why it works but my test program that reads 1 byte from userspace with
i2c_smbus_read_byte_data() dose not. I hoped I did not have to dig thru
too much into this as I don't know much about it.


>
> Which test in iix_xffer that?

Good question I get a bit unsure of what is going on when I read it
again but here is the test I removed. Everything works as I want when I
remove it.

/* When the bus is free, the BCS bits in the EXTSTS register are 0b100
*/
	if (ret != 0x40){
		return IIC_ERR_LOST_ARB;
	}


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
