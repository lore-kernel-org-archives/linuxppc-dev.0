Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <44DE1357.5010703@ru.mvista.com>
Date: Sat, 12 Aug 2006 21:43:51 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] Adding MTD to device tree
References: <311553550076b8b45674.846930886.miltonm@bga.com>
In-Reply-To: <311553550076b8b45674.846930886.miltonm@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, arnd@arndb.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Milton Miller wrote:

>>>+   h) MTD nodes
>>>+
>>>+   Memory Technology Devices are flash, ROM, and similar chips, often used
>>>+   for solid state file systems on embedded devices.
>>>+
>>>+   Required properties:
>>>+
>>>+    - device_type : has to be "mtd"
>>>+    - compatible : Should be the name of the MTD driver. Currently, this is
>>>+      most likely to be "physmap".
>>>+    - reg : Offset and length of the register set for the device.

>>I would prefer to call them something different in the device tree.
>>The name 'mtd' is very specific to Linux, but the device tree
>>is a more generic concept.

    "Memory type devices" are specific to Linux? Doubt it. :-)
    In fact, device type "flash" sounds too restrictive.

>>I understand that the booting-without-of.txt file is by definition
>>Linux specific as well, but we should be prepared for making parts
>>of it a OS independent binding at the point where we put the same
>>device nodes into actual OF implementations that able to boot
>>different operating systems.

>>I would prefer a naming that has 

>>   Required properties:
>>    - device_type : one of "nand-flash", "nor-flash", or "rom".
>>    - model : an identifier for the actual controller chip used.
>>    - compatible : Should be the name of the MTD driver. For
>>      type "rom", this is most likely "physmap".

> I'm with your suggestion for device_type and model, but not 
> compatable.   "physmap"?  What kind of device is that?  A 

    Directly mapped NOR flash or ROM I think.

> command set name, maybe with a width, would be 

    That'd be pretty useless if you don't let Linux know which MTD *map* 
driver to use. And I have specified the "bank-width" prop.

> appropriate.   Physmap is the name of another linux driver.   

    And the role of the "compatible" prop is exactly to help OS in selecting 
the driver.

> Something like direct or linear might be appropriate for a rom, 
> where just address and length appear.

    I agree that "linear" or "direct" may be better variants.

>  Even rom would be better than physmap.

    Doubt it since the ROM is the only one thing (and even the least probable) 
that we're going to support.

> milton

WBR, Sergei
