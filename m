Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <44DDFF94.3090402@ru.mvista.com>
Date: Sat, 12 Aug 2006 20:19:32 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Adding MTD to device tree
References: <20060614213643.137680b8@vitb.ru.mvista.com>	<20060709001435.7a94294e@localhost.localdomain>	<44DCA2BF.1030002@ru.mvista.com>
	<200608112310.41110.arnd@arndb.de>	<1155347601.3108.7.camel@vader.jdub.homelinux.org>
	<001C3287-87E7-4DF9-AB4E-E1448EC20518@kernel.crashing.org>
In-Reply-To: <001C3287-87E7-4DF9-AB4E-E1448EC20518@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Segher Boessenkool wrote:

>>>   Required properties:
>>>    - device_type : one of "nand-flash", "nor-flash", or "rom".

    I thought about having the separate device types initially, then I decided 
that all the differences can be handled on the driver level...

>>There are more than just those kinds of MTDs.  There's dataflash,
>>AG-AND, NVRAM, ioremappable DRAM, etc.  I'd prefer it to just be  
>>called "flash".  See more below.

> Existing firmwares call it "rom", "nvram", "flash".  All of those
> are easy; and I have really no opinion how all the weirdo nand-flash
> etc. interfaces should be handled.

> device_type communicates to the device-tree consumer what other
> properties to expect in this node -- it does not indicate the exact
> programming model of the device itself.

    Erm, IIUC the exact set of properties is defined by the node name (or the 
"compatible" property). The device type defines some mandatory set of 
properties/methods but there may be some specific...

> I suspect for most nand-flash you can get away with a device_type
> of "nand-flash"; for some you might have to specify something more
> detailed.

    Hm, not sure that you need to be so much detailed with the device type.
The original OF spec. had device type "block" signifying any kind of blocked 
storage device.

>>>    - model : an identifier for the actual controller chip used.

>>Meaning what exactly?  Lots of NOR flash doesn't have a "controller".

> Lots of those chips from different vendors are pin-compatible as well,
> so you cannot really hardcode one specific model number.  I don't see
> this information being very useful anyway.  Instead, in most cases, the
> information you're really after is the programming interface for the
> device.  And that goes...

    This property might be marked optional still.

>>>    - compatible : Should be the name of the MTD driver. For
>>>      type "rom", this is most likely "physmap".

>>This I agree with, but Sergei already had this.  And since you're
>>specifying the name of the MTD driver, that typically already knows  
>>what
>>type of chip it's talking to.

> "compatible" contains a list, most specific first.  So for example
> for a NOR-flash it could be "jedec-flash,nor-flash,flash" or whatnot.
> (Btw: no comma's, but 0-chars in the actual properties!)

    The "compatible" prop (as well as "name") should define which driver to 
select according to spec. (the Generic Names spec. delegates this role solely 
to the "compatible" prop). While specifying the flash interface (JEDEC in this 
case) is indeed useful (however, the current 'platform_device' based 'physmap' 
implementation doesn't allow to pass the probe type to the driver), the prop 
in the form suggested doesn't really help with selecting the MTD map driver 
(without which you can't support a NOR flash). A reference to 'physmap' should 
still be present in the node in one or another form...

WBR, Sergei
