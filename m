Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AA2DDDEED
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:13:22 +1000 (EST)
In-Reply-To: <200704041903.46629.arnd@arndb.de>
References: <20070404110916.GA9910@localhost.localdomain>
	<acd2a5930704040451u55ae7619wfa1aaa84aebdf72@mail.gmail.com>
	<4850DC60-A560-4A38-8416-ADA776B69509@kernel.crashing.org>
	<200704041903.46629.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5199678E-7A42-4B91-BBB8-81DF33E92F2A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: SPI devices and OF
Date: Wed, 4 Apr 2007 12:12:37 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2007, at 12:03 PM, Arnd Bergmann wrote:

> On Wednesday 04 April 2007, Kumar Gala wrote:
>> I don't think this is a good idea for SPI devices.  The effort vs
>> reward isn't worth it.  The simple fact that the 'chip select'
>> mechanism ends up being board specific is too much of a pain to
>> figure out how to deal with in the device tree.  I think its ok if we
>> put information about the controller in the tree, but trying to do
>> the devices as well at this point doesn't seem like its much of a  
>> win.
>>
>
> I'm not following your argumentation. If the chip select is board  
> specific,
> isn't the device tree for that board _exactly_ the place where that
> information should be? Where else would you get it from?

 From explicitly board code like we do today.  I mean the mechanism  
can very so greatly that trying to decided and come up with all  
possible cases and somehow encoding that in the device tree isn't  
worth the effort.  Additionally you'll still need code to handle the  
actual chip select and I don't see how you make that generic at all.

A board designer could use I2C, GPIO, or something off an FPGA.  I  
just dont see trying to 'encode' this in the device tree as providing  
any real value.

- k
