Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4681DDE46
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 07:34:25 +1000 (EST)
In-Reply-To: <B0B16FB3-62D7-434B-9135-E87D2AFFFF07@kernel.crashing.org>
References: <20070420151136.3fdb160f.kim.phillips@freescale.com>
	<B0B16FB3-62D7-434B-9135-E87D2AFFFF07@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <41FB4785-E97E-4E47-A6BD-25E47931C9B8@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/4 v3] powerpc: document interface-type property
Date: Fri, 20 Apr 2007 16:34:21 -0500
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


On Apr 20, 2007, at 15:57, Kumar Gala wrote:

>
> On Apr 20, 2007, at 3:11 PM, Kim Phillips wrote:
>
>> Since ucc_geth is being migrated to use the phylib, the existing
>> (undocumented) 'interface' property is being deprecated in favour
>> of a stringified version, 'interface-type'.
>>
>> interface-type is maintained one-to-one with definitions
>> in include/linux/phy.h.  If not specified, "mii" is assumed.
>>
>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>> ---
>> removed max-speed property, since the name is apparently too generic
>> (it's derived from the interface-type anyway)
>
> Are you sure?  Is not possible to use a gmii phy on a 8323 and limit
> it to 10/100?


Ahem.  Just to maintain this point: It's not a GMII PHY.  It would be  
a PHY that supports the GMII interface.  In this case, we would  
specify that the controller is connecting to its PHY over interface- 
type "mii".  The real issue (right now) would be an RGMII or SGMII  
connection for a non-gigabit controller.

However, the UCC doesn't currently support SGMII, and there aren't  
any implementations that have non-gigabit RGMII connections.

In other words, this could become an issue in the future, but we're  
punting on pushing through a specifier for that situation until it  
comes up.

Andy
