Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DE1E6679EF
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 13:09:48 +1000 (EST)
Date: Sat, 15 Apr 2006 20:09:44 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andre Draszik <kernel@andred.net>
Subject: Re: IIC troubles w/ ppc4xx (STB04)
Message-ID: <20060416030944.GA20416@gate.ebshome.net>
References: <4441A0C8.8090708@andred.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4441A0C8.8090708@andred.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Apr 16, 2006 at 03:41:28AM +0200, Andre Draszik wrote:
> Hi,
> 
> I am having trouble using iic_smbus_quick() of i2c/busses/i2c-ibm-iic.c
> I am trying to i2c_probe() to probe for some devices, which at the end
> calls iic_smbus_quick().
> 
> Basically, I get a Data Machine Check as soon as iic->directcntl is
> accessed. Actually, this register is not described in the (old)
> documentation I have.

Does everything else work? I mean ordinary I2C access like read/write.
If everything else is fine, just comment out that iic_smbus_quick() 
call or just don't use i2c_probe(). It's a hack anyway, because I2C 
spec has no provision for "probing". I wrote this bit-banging 
implementation just to get some people off my back :).

BTW, I never tested my driver on STB4, maybe ocp_defs are wrong (in 
this case i2c will not work at all).

-- 
Eugene
