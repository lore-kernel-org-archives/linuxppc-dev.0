Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86D8CDDEC0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 17:04:11 +1000 (EST)
In-Reply-To: <9f68fb3023e258ad0fbe314099a9ffbf@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<98DB6E05-1869-47E9-882E-17B4F574581F@freescale.com>
	<9f68fb3023e258ad0fbe314099a9ffbf@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <236CD796-DFDF-41B5-A92B-6C15876327E0@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Tue, 17 Apr 2007 02:04:04 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2007, at 18:25, Segher Boessenkool wrote:

>>> Yep.  The whole reason why any property is wanted here is
>>> to say what type the PHY is, as the enet controller can
>>> be attached to several kinds.  And what type the PHY is
>>> belongs in the PHY node, obviously.  In its "compatible"
>>> property to be exact.
>>
>> It's not saying what type the PHY is, though.  It's describing the  
>> connection.  The PHY is just as flexible wrt connection type as  
>> the ethernet controller.
>
> Huh, I've never seen that.  I'll take your word for it.

Well, mostly this just means that the PHY has pins, and can be told  
which pins have what meaning in the same way that the ethernet  
controller can.

>
>> This is actually a property of the board.  In some cases its a  
>> fixed property of the board.  In some cases it's changeable  
>> through dip switches, or even through software.
>
> In such a case you cannot describe this with a fixed
> flat device tree *at all*.


This is true to the extent that the device tree can't change on the  
fly.  But the device tree could be used to tell the software which  
one was chosen (by setting it manually, or by detecting it at runtime  
in the firmware), or it can be used to tell the software which one to  
choose.  This is really a side point to my argument, though.


>
>> Ethernet controllers need to know what the connection is so they  
>> can establish a data connection with the PHYs
>
> Can't you probe for PHYs?


I'm beginning to suspect you are confusing the PHY management bus  
with the PHY data bus.  PHYs are almost universally controlled  
through an MDIO bus which consists of 2 pins: clock and data.  This  
is not the ethernet packet data, though, it is configuration data.   
The PHYs can all be discovered on this bus, regardless of what  
interface is chosen for the data.


>
>> The reason for choosing the ethernet controller in this case has  
>> to do with the flow of information.
>>
>> 1) The driver tells the PHY what interface to use
>
> The device tree is not structured after how Linux device
> drivers want to use the information; instead, it describes
> the hardware.

My point was merely that the location of the information is  
arbitrary, and so here are three reasons for arbitrarily putting it  
in the ethernet node, rather than the PHY node.

>
>> 2) The ethernet controller is the endpoint of this connection  
>> which is accessible by everyone else.  IE data is not sent through  
>> PHYs by any means but through the ethernet controller, and data is  
>> not received from PHYs by any means but through the ethernet  
>> controller.
>
> So?

Same point as above

>
>> 3) The UCC needs to be told the connection type, because it does  
>> not have logic to detect it on its own.
>
> Just try all possible kinds, see if you can see a PHY
> connected?


To extend on the point above, this is nearly impossible.  As I said,  
the management bus and the data bus are different.  This interface  
property describes the pin configuration for the data bus.  It also  
describes the "rate" at which the data is sent or received (some  
interfaces double-pump, some use echo cancellation).  The result of a  
misconfiguration is that you receive gibberish and you send  
gibberish.  The PHY will happily misunderstand the ethernet  
controller, and visa-versa.

They *both* need to know how they are wired to the other one.


>
>> The truth is, this is a somewhat intractable problem because of  
>> the myriad possibilities for how board designers can hook up  
>> ethernet controllers to PHYs.  One can envision scenarios where  
>> controllers can hook up to multiple PHYs, each of one fixed type.
>
> Yeah, seen that.  Quite a common scenario.
>
>> One can envision scenarios where multiple controllers are hooked  
>> up to one PHY, and each of the controllers can use different  
>> connections.
>
> How would that work at all, except when only one controller
> is active and the rest are shut down?


Right.  It's exactly like the previous example, except the previous  
example has some PHYs sitting around, inactive.


>
>> If we put the information in the PHY node, we allow for the first  
>> scenario, but not the second.  If we put it in the ethernet node,  
>> we reverse that situation.  In either case, we'd currently have to  
>> modify our dts to specify which PHY we want to use.
>
> Which brings me back to, can't you just probe for it?

Again, no.  You would have to convince me that the interface is more  
closely tied to the PHY than to the controller.  I believe it's an  
equal weighting, and have provided three arguments above for why the  
ethernet node is more appropriate.  Feel free to do so for the PHY.   
But you need four or more, or I win.  ;)

Andy
