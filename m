Message-ID: <3868EB01.236121F4@netx4.com>
Date: Tue, 28 Dec 1999 11:53:21 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: kd@flaga.is
CC: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help about device driver in Linux
References: <OF9209481E.5CD82FF1-ON00256855.00326F88@flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is wrote:
> 
> Hi,
> 
> There is an IIC driver now in kernel 2.2.13. I have not tested it yet so I
> can't comment on how well it works.


I put it there as a way to test some of the CPM microcode patches.
It is one of the devices that is relocated, and I was testing on
an Embedded Planet board which has an I2C serial EEPROM.

It works, and is basically the same code that exists in the 
mbxboot directory to read I2C EEPROMs when booting.  There isn't
a write function, but since the read includes a write operation
it shouldn't be too difficult to create one.  It isn't semantically
correct, there is no EOF on read condition (but I am not sure how
to make this happen given the I2C protocol).  The minor device ID
is used for the I2C device address.

The I2C on the 8xx is troublesome, especially because of all of
the silicon errata in early parts.  Later silicon seems to work
fine.

I have only used I2C in master mode.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
