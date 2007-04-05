Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id E6110DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:00:30 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1175758338.30879.123.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9cceb498d8a04450a84ca99cde917a3b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: SPI devices and OF
Date: Thu, 5 Apr 2007 10:00:23 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Herrenschmidt wrote:
> Kumar Gala wrote:
>>  From explicitly board code like we do today.  I mean the mechanism
>> can very so greatly that trying to decided and come up with all
>> possible cases and somehow encoding that in the device tree isn't
>> worth the effort.  Additionally you'll still need code to handle the
>> actual chip select and I don't see how you make that generic at all.

At this point I don't think we are trying to make a generic master.  At
most we are trying to expose the spi device in a manner that can be
reused by board-specific master drivers.

>> A board designer could use I2C, GPIO, or something off an FPGA.  I
>> just dont see trying to 'encode' this in the device tree as providing
>> any real value.
>
> Or board designers can use board specific device-tree bits and board
> specific code to udnerstand them :-) That works too and can be handy if
> you have for example several versions of a board with small differences
> that you want to expose that way in the device-tree.
>
> That is, the devive-tree -can- be used to put proprietary stuff, though
> if you do so, you should try to use prefixes on your properties, like
> mycompany,xxxx

I agree with Ben here.

Asserting the chip select is the responsibility of the master driver,
and that is selected by the compatable property in the device tree
to a specific driver.

The reg property in the device node can be useful to the master driver
wihtout expressing how to assert it in the master node.

milton
