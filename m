Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 17B08DDF7B
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 05:05:19 +1000 (EST)
Date: Tue, 19 May 2009 12:05:14 -0700 (PDT)
Message-Id: <20090519.120514.26253637.davem@davemloft.net>
To: arnd@arndb.de
Subject: Re: Musings on PCI busses
From: David Miller <davem@davemloft.net>
In-Reply-To: <200905191812.03347.arnd@arndb.de>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<200905191812.03347.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2009 18:12:02 +0200

> On Tuesday 19 May 2009, Grant Likely wrote:
>> 1) Probe the host controller in an of_platform driver. =A0This has t=
he
>> advantage of simplicity. =A0The probe routine will get automatically=

>> called when the PCI host controller device tree node is registered
>> with the of_platform bus. =A0The bus parenthood also gets reflected =
in
>> the device model and sysfs. =A0The disadvantage is that it defers PC=
I
>> bus probing until after the of_platform bus is probed (maybe this is=

>> okay; maybe this already happens anyway).
> =

> This is also what we do on 64-bit systems (well, Cell at this time).
> There are no fundamental problems with this, just some slightly
> unexpected interactions e.g. when you have use a PCI serial port
> as your console before probing PCI.

This is also what sparc64 does :-)

All of the individual sparc64 PCI controller types have a OF driver
and then there is a common layer of OF PCI helper code to do most
of the work.
