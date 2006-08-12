Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1155347601.3108.7.camel@vader.jdub.homelinux.org>
References: <20060614213643.137680b8@vitb.ru.mvista.com>
	<20060709001435.7a94294e@localhost.localdomain>
	<44DCA2BF.1030002@ru.mvista.com> <200608112310.41110.arnd@arndb.de>
	<1155347601.3108.7.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <001C3287-87E7-4DF9-AB4E-E1448EC20518@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Adding MTD to device tree
Date: Sat, 12 Aug 2006 11:58:01 +0200
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>    Required properties:
>>     - device_type : one of "nand-flash", "nor-flash", or "rom".
>
> There are more than just those kinds of MTDs.  There's dataflash,
> AG-AND, NVRAM, ioremappable DRAM, etc.  I'd prefer it to just be  
> called
> "flash".  See more below.

Existing firmwares call it "rom", "nvram", "flash".  All of those
are easy; and I have really no opinion how all the weirdo nand-flash
etc. interfaces should be handled.

device_type communicates to the device-tree consumer what other
properties to expect in this node -- it does not indicate the exact
programming model of the device itself.

I suspect for most nand-flash you can get away with a device_type
of "nand-flash"; for some you might have to specify something more
detailed.

>>     - model : an identifier for the actual controller chip used.
>
> Meaning what exactly?  Lots of NOR flash doesn't have a "controller".

Lots of those chips from different vendors are pin-compatible as well,
so you cannot really hardcode one specific model number.  I don't see
this information being very useful anyway.  Instead, in most cases, the
information you're really after is the programming interface for the
device.  And that goes...

>>     - compatible : Should be the name of the MTD driver. For
>>       type "rom", this is most likely "physmap".
>
> This I agree with, but Sergei already had this.  And since you're
> specifying the name of the MTD driver, that typically already knows  
> what
> type of chip it's talking to.

"compatible" contains a list, most specific first.  So for example
for a NOR-flash it could be "jedec-flash,nor-flash,flash" or whatnot.
(Btw: no comma's, but 0-chars in the actual properties!)


Segher
