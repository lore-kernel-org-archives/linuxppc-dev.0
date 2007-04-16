Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62608DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 03:28:33 +1000 (EST)
In-Reply-To: <377816979b46808cd11a12640ceabb14@kernel.crashing.org>
References: <20070410165639.1b619c34.kim.phillips@freescale.com>
	<377816979b46808cd11a12640ceabb14@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C4757AA-5302-4832-91BB-9B102A60FA5C@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/4] powerpc: document max-speed and interface-type
	properties
Date: Mon, 16 Apr 2007 12:28:30 -0500
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


On Apr 12, 2007, at 02:06, Segher Boessenkool wrote:

>> +   - max-speed : The maximum speed supported by the controller (in
>> Mbit/s)
>> +   - interface-type : a string naming the controller/PHY interface
>> type,
>> +     i.e., one of "mii", "gmii", "sgmii", "tbi", "rmii", "rgmii", or
>> "rtbi".
>
> This information should be in the PHY node, instead.
> Both property values would normally be implied by
> "compatible" in that node (and this node, for the
> max speed).


Why should it be in the PHY node?  It's not a property of the PHY.   
It's a property of the connection between the PHY and the ethernet  
controller.  The PHY Lib API has the ethernet provide the connection  
type as an argument in the phy_connect() call, so it makes sense for  
this property to reside in the ethernet node.  I think ethernet  
drivers typically have the most power in this situation, and so it's  
best (IMHO) to let the ethernet node provide this information.

Andy
