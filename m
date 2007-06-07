Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9594EDDF62
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 06:03:36 +1000 (EST)
In-Reply-To: <63ff9dee6b212cc7908c8e1b73920ea6@kernel.crashing.org>
References: <1181147415.5674.108.camel@rhino>
	<200706070039.51541.arnd@arndb.de>
	<1181232276.5674.146.camel@rhino>
	<63ff9dee6b212cc7908c8e1b73920ea6@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FF15186D-1D92-422E-AC6C-3127F6116C79@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Thu, 7 Jun 2007 15:01:24 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 7, 2007, at 11:35, Segher Boessenkool wrote:

>>> Hardcoded I/O port numbers always worry me a little. I know that  
>>> this
>>> is
>>> supposed to work in general, but can't you read the I/O port range
>>> from
>>> a device tree property?
>>
>> I suppose I could create a device node for the Super I/O config
>> registers and use those instead of hardcoding it here.
>
> I'd just hide it all, do this setup in the firmware,
> where it belongs, and don't expose the superio config
> in the device tree.


No more.  No more firmware-only initializations.  It sounds great, in  
principle, until you actually have to figure out why someone's setup  
isn't working.  I'm tired of having to see if the dts, u-boot, and  
Linux are in sync.  If Linux wants to use a device, I think it's not  
unreasonable to have it setup the device itself.  That way, Linux can  
do whatever it wants with the device, and not have to rely on U-Boot  
(or some other firmware) setting up the appropriate bits.


>
>> superio_cfg@4e {
>> 	reg = <1 4e 2>;
>> 	compatible = "smsc-lpc47m192-cfg";
>> };
>>
>> I'm not sure if the name and compatible properties are appropriate
>> though.  Any recommendations?
>
> "superio" and "smsc,lpc47m192" I'd say.  You also
> then should link the logical devices on the superio
> to the device nodes that represent those.  I'm not
> sure this is all worth it, this is low-level setup
> the firmware should do and everything else can treat
> it as a black box.


Please...no.  What happens next is that we find a small bug that  
requires we modify U-Boot to do the initialization slightly  
differently, and then requires Linux to act slightly differently.   
And then I get emails every day from people wondering why their  
boards don't work.

Andy
