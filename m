Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 59EF3679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 05:19:03 +1000 (EST)
In-Reply-To: <44C59875.4000309@dlasys.net>
References: <44BFC2EF.5020305@dlasys.net>
	<20060720220136.29326857@vitb.ru.mvista.com>
	<44C59875.4000309@dlasys.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87E4236F-9684-4509-8085-F59369136DB1@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: PHY Howto ?
Date: Tue, 25 Jul 2006 14:19:39 -0500
To: dhlii@comcast.net
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


On Jul 24, 2006, at 23:05, David H. Lynch Jr. wrote:

> Vitaly Bordug wrote:
>> On Thu, 20 Jul 2006 13:52:47 -0400 "David H. Lynch Jr."  
>> <dhlii@dlasys.net> wrote:
>>> If I am writing a network MAC driver, for hardware that has a phy  
>>> that is already supported, if I provide the appropriate mdio_read 
>>> () and mdio_write() calls to access the phy registers, and setup  
>>> my config to include phylib and drivers for my specific phy, what  
>>> else do I have to take care of with respect to the phy within my  
>>> driver ? Are there some resources, howto's, examples, ...  
>>> demonstrating how to use phylib ?
>> There is pretty good writeup in Documentation about your concern,  
>> find it at Documentation/networking/phy.txt . Live example is  
>> obviously drivers/net/gianfar*
>     Thanks that proved useful. I am already using gianfar as a  
> reference - but it is not a NIC I am familiar with.
>     And I still have some questions:
>
>           What is the distinction/interaction between phylib and  
> MII support ?
>
>           Are they independent ways of doing something similar ? Or  
> do they work together.
>


The MII code is an older interface to PHYs which provided some, but  
not all of the PHY layer's capabilities.  I don't anticipate its  
going away anytime soon, but the PHY layer was designed to replace  
it.  I don't currently know of any reason for a driver to support the  
MII interface, other than legacy reasons (that's not to say there are  
none, but I don't know of them).  The mii_if_info structure is only  
needed if you invoke one of the mii_* functions, the functionalities  
of which are provided by the PHY library.  So I guess my answer is  
that they are independent ways of doing something similar.

There are functions in phy.c to replace the generic mii functions for  
getting and setting speed/duplex values:
phy_ethtool_sset
phy_ethtool_gset

And a function to perform the mii_ioctl commands, which is highly  
discouraged.  It messes around with the PHY behind the scenes,  
leaving the PHY layer out of the loop.


>
>           To get MII working I need to provide/populate  an  
> mii_if_info structure and supply register read/write routines.
>
>           Since communicating with the PHY is MAC dependent  
> shouldn't I need to do the same for PHYLIB ?


Look at drivers/net/gianfar_mii.c.  You need to provide an mii_bus  
structure, which has pointers to read, write, and reset functions.   
It also has power/suspend functions.  Basically, the MDIO hardware on  
your NIC gets treated as a separate device.  It's fairly  
straightforward for your NIC to treat it as part of itself, though.


>
>           As I understand it although PHY's are similar, and the  
> same PHY may be used on different NIC's
>           Communications to the PHY typically go through the NIC.
>           So my Network driver has to provide routines to read/ 
> write the registers of the PHY, which phylib and the phy driver  
> then use.


That's pretty much it.  The same PHY type will be used on different  
NICs.  Hopefully, you don't want to share a PHY between two NICs.   
That's not currently supported.  And I'm not really sure how it would  
work, in truth.  But the driver can be shared for each PHY device.   
And the NIC exposes the MDIO bus as a full bus device.


Andy
