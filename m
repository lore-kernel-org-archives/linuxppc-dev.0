Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9211DDE0B7
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 08:04:28 +1000 (EST)
Message-Id: <625ED025-8D5B-437F-BEA8-1A599B677D43@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1D3E7471-098E-483F-A80D-4D02BB8F076C@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2] powerpc: 85xx: Add PHY fixup to socrates board code
Date: Tue, 21 Apr 2009 17:04:19 -0500
References: <1239113988-4579-1-git-send-email-agust@denx.de>
	<1240334378-1643-1-git-send-email-agust@denx.de>
	<1D3E7471-098E-483F-A80D-4D02BB8F076C@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 21, 2009, at 4:54 PM, Kumar Gala wrote:

>
> On Apr 21, 2009, at 12:19 PM, Anatolij Gustschin wrote:
>
>> If the firmware missed to initialize the PHY correctly,
>> Linux may hang up on socrates while eth0/eth1 interface
>> startup (caused by continuous unacknowledged PHY interrupt).
>>
>> This patch adds PHY fixup to socrates platform code to
>> ensure the PHY is pre-initialized correctly. It is needed
>> to be compatible with older firmware.
>>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> ---
>> Changes since first version:
>> 	use macros instead of register numbers as
>> 	suggested by Anton
>>
>> Kumar, could you please consider this patch for
>> inclusion into 2.6.30? Thanks!
>
> Sorry.  I dont think this is board specific and should at a minimum  
> be done in m88e1011_config_init in drivers/net/phy/marvell.c.  Not  
> sure how 88E1011 differs from 88E1111, but I'm wondering if you  
> really want to set config_init for m88e1011 to m88e1111_config_init
>
> - k

I got confused by the #'s.. I think we should have a struct in  
marvell.c for m88e1121 which I'm guessing is the PHY you are using.

- k
