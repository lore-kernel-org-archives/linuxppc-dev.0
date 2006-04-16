Return-Path: <kernel@andred.net>
Received: from andred.net (sushi.andred.net [217.160.180.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE1CB67A5C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 15:33:51 +1000 (EST)
Message-ID: <4441D739.6040107@andred.net>
Date: Sun, 16 Apr 2006 07:33:45 +0200
From: Andre Draszik <kernel@andred.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: IIC troubles w/ ppc4xx (STB04)
References: <4441A0C8.8090708@andred.net>
	<20060416030944.GA20416@gate.ebshome.net>
In-Reply-To: <20060416030944.GA20416@gate.ebshome.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Eugene Surovegin wrote:
> On Sun, Apr 16, 2006 at 03:41:28AM +0200, Andre Draszik wrote:
>> [...]
>> Basically, I get a Data Machine Check as soon as iic->directcntl is
>> accessed. Actually, this register is not described in the (old)
>> documentation I have.
> 
> Does everything else work? I mean ordinary I2C access like read/write.

Well, i2c-dev is working fine, so i2c in general is working (w/
2.6.17-rc1). And also the initialization of the ibm i2c driver works
fine, i.e. all other registers can be accessed. It's only the directcntl
which throws the exception.

> If everything else is fine, just comment out that iic_smbus_quick() 
> call or just don't use i2c_probe(). It's a hack anyway, because I2C 
> spec has no provision for "probing". I wrote this bit-banging 
> implementation just to get some people off my back :).

I see :) So if that doesn't work, what is the preferred way of testing
for existence of a device in a kernel module? Should I just
unconditionally i2c_client_register() a static struct and then
i2c_master_send() to see if it works?

> BTW, I never tested my driver on STB4, maybe ocp_defs are wrong (in 
> this case i2c will not work at all).

Nope, this is correct, I already checked. :)


Thanks!
Andre'
