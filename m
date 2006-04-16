Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 75D3767A63
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 15:57:05 +1000 (EST)
Date: Sat, 15 Apr 2006 22:57:02 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andre Draszik <kernel@andred.net>
Subject: Re: IIC troubles w/ ppc4xx (STB04)
Message-ID: <20060416055702.GB20416@gate.ebshome.net>
References: <4441A0C8.8090708@andred.net>
	<20060416030944.GA20416@gate.ebshome.net>
	<4441D739.6040107@andred.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4441D739.6040107@andred.net>
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

On Sun, Apr 16, 2006 at 07:33:45AM +0200, Andre Draszik wrote:
> I see :) So if that doesn't work, what is the preferred way of testing
> for existence of a device in a kernel module? Should I just
> unconditionally i2c_client_register() a static struct and then
> i2c_master_send() to see if it works?

There is no generic reliable way to detect that some i2c device exists 
on the bus. Even if smbus_quick worked it cannot guarantee that 
device you found is actually device you are expected - same i2c 
address can be used by different devices.

Frankly, I never saw this as a problem in embedded world, because 
most of the time you have a custom built kernel for your particular 
board or family of the boards, and you already know what devices might 
be there, so just trying to access those devices from whatever 
drivers and/or user-space applications you wrote is sufficient. In 
fact, I never needed i2c "probing" in any of almost dozen different 
embedded projects I wrote firmware/Linux board support for.

So, I think unconditional i2c_master_send() should be fine, just be 
prepared to handle errors in case device isn't there or broken.

-- 
Eugene
