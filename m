Message-ID: <3EFE8C8A.70508@austin.rr.com>
Date: Sun, 29 Jun 2003 01:51:54 -0500
From: Jeff Hurst <jhurst2@austin.rr.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: testing i2c on mpc8xx
References: <20030627142900.A12BBC592A@atlas.denx.de> <3EFC5D10.9000701@peak.uklinux.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Seb James wrote:

> I am getting no activity on the i2c clock and data lines, and when
> I try to write to the i2c bus, the processor times out waiting for
> an interrupt associated with (I think) acknowledgement bits coming
> from the slave device to which it is trying to transmit. It times out
> at the following bit of code in cpm_iic_read() (and also does so in
> cpm_iic_write()):

<snip>

> I have tried changing the following line in i2c-algo-8xx.c (line 42 I
> think):
>
> int cpm_scan = 0;
>
> to
>
> int cpm_scan = 1;
>
> Which causes i2c_8xx_add_bus() to scan for devices, using this code:
>
>    /* scan bus */
>    if (cpm_scan) {
>        printk(KERN_INFO " i2c-algo-8xx.o: scanning bus %s...\n",
>               adap->name);
>        for (i = 0; i < 128; i++) {
>            if (cpm_iic_tryaddress(cpm_adap, i)) {
>                printk("(%02x)",i<<1);
>            }
>        }
>        printk("\n");
>    }
>
> This causes the processor to hang in the same way as I described above
> for cpm_xfer.

<insert the doctor joke here>

I had a similar experience.  Decided that it is not a good idea to
scan the bus from the device driver startup function.
I am still curious about the real cause.

--
Jeff Hurst

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
