Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 5EC4FDDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 04:00:02 +1000 (EST)
Message-ID: <464DE99D.1040904@smiths-aerospace.com>
Date: Fri, 18 May 2007 13:59:57 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>
	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>
	<464CA302.9060707@freescale.com>	<20070518005641.GA27350@localhost.localdomain>	<464DB986.20205@freescale.com>
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>
	<464DE2D3.3090805@smiths-aerospace.com>
	<464DE4C7.7030906@freescale.com>
In-Reply-To: <464DE4C7.7030906@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Jerry Van Baren wrote:

[snip]

>> * The above should result in reasonable board-specific code.
>>   * We may want to invent a libfdt move/copy subtree function (I don't
>>       recall one being in there).  Board specific code would want to
>>       move selected subtrees out of /u-boot,hwoptions into the
>>       appropriate final node.  All the pieces are in libfdt, just would
>>       need to be hooked together in a utility subroutine.
> 
> Just being able to delete a given node/property would be enough.  By 
> default, the nodes with conditionals would be present in the device 
> tree.  The boot loader would then also strip out all conditionals from 
> the device tree before passing it to the kernel.  The kernel would then 
> receive a standard device tree like it does today.

Deleting isn't really enough because you would want to copy/move the 
configuration from a subnode of the hwoptions node to the final resting 
place in the standard tree (assuming there is a final resting place in 
the standard tree - I'm picturing SOC configuration choices here). 
Simple deletion isn't adequate in general because
* It would be silly to change linux to look in a new location for things
     that already exist in standard locations (e.g. SOC stuff)
* Deleting a node inherently deletes all of the subnodes.  In order to
     do only delete operations, you would end up with an ugly path like:
/u-boot,hwoptions/J1/on/tree/&usb/phy_type (set to  "ulpi")
     where I suspect the &usb/phy_type portion should be glued into a SOC
     (or other) pre-existing subnode.
* It is possible some choices can be used multiple times - the above
     example specifies a PHY.  There are very often multiple instances of
     only type of PHY and copying one "prototype" selection into multiple
     final destination nodes could save space and effort.

>> * With the above, nothing in the infrastructure (dtc, libfdt) needs to
>>     change.
>>
>> On a related note, would it be better to name the node 
>> "/u-boot/hwoptions" (two levels deep)?  It seems very desirable to me to 
> 
> It's not a u-boot-specific concept.  The idea of representing jumpers 
> (and other hardware options) in the device tree is not something that's 
> unique to u-boot or any boot loader. The conditionals, however, are a 
> bootloader-specific concept.  We don't want Linux to see them.

Well, then we shouldn't name it u-boot,hwoptions.  Ahh, nevermind, Scott 
beat me to that point.

Best regards,
gvb
