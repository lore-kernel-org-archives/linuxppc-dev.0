Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 18CB3B7151
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 23:46:52 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65BA3DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 23:46:51 +1000 (EST)
Message-Id: <FD13CC33-5404-4E8C-86BA-255CE7F64794@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anatolij Gustschin <agust@denx.de>
In-Reply-To: <49EE55A4.4000602@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v2] powerpc: 85xx: Add PHY fixup to socrates board code
Date: Tue, 16 Jun 2009 08:46:40 -0500
References: <1239113988-4579-1-git-send-email-agust@denx.de>
	<1240334378-1643-1-git-send-email-agust@denx.de>
	<1D3E7471-098E-483F-A80D-4D02BB8F076C@kernel.crashing.org>
	<625ED025-8D5B-437F-BEA8-1A599B677D43@kernel.crashing.org>
	<49EE55A4.4000602@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 21, 2009, at 6:24 PM, Anatolij Gustschin wrote:

> Kumar Gala wrote:
>>
>> On Apr 21, 2009, at 4:54 PM, Kumar Gala wrote:
>>
>>>
>>> On Apr 21, 2009, at 12:19 PM, Anatolij Gustschin wrote:
>>>
>>>> If the firmware missed to initialize the PHY correctly,
>>>> Linux may hang up on socrates while eth0/eth1 interface
>>>> startup (caused by continuous unacknowledged PHY interrupt).
>>>>
>>>> This patch adds PHY fixup to socrates platform code to
>>>> ensure the PHY is pre-initialized correctly. It is needed
>>>> to be compatible with older firmware.
>>>>
>>>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>>>> ---
>>>> Changes since first version:
>>>>    use macros instead of register numbers as
>>>>    suggested by Anton
>>>>
>>>> Kumar, could you please consider this patch for
>>>> inclusion into 2.6.30? Thanks!
>>>
>>> Sorry.  I dont think this is board specific and should at a  
>>> minimum be
>>> done in m88e1011_config_init in drivers/net/phy/marvell.c.  Not sure
>>> how 88E1011 differs from 88E1111, but I'm wondering if you really  
>>> want
>>> to set config_init for m88e1011 to m88e1111_config_init
>>>
>>> - k
>>
>> I got confused by the #'s.. I think we should have a struct in  
>> marvell.c
>> for m88e1121 which I'm guessing is the PHY you are using.
>
> yes, m88e1121 is correct. In 2.6.30-rc2 there is already a m88e1121
> struct in marvell_drivers[] in drivers/net/phy/marvell.c.
> The reason I'm not doing the m88e1121 pre-init stuff in config_init
> is as follows:
>
> m88e1121 is a multi-PHY device with two PHY ports and each port
> could signal an interrupt. This PHY device can be pin-strapped to use
> shared interrupt pin for both PHY ports (as used on socrates board).
> PHY specific config_init will be called e.g. while eth0 startup in
> phy_attach() which is called from phy_connect() in drivers/net/phy/ 
> phy_device.c.
> phy_connect() then calls phy_start_interrupts() which registers the
> interrupt handler and enables the interrupts for the PHY-port  
> config_init
> is called for. Now interrupts can be cleared/acknowledged for this
> PHY-port (eth0 interface), but interrupts from the another PHY-port
> can not be acknowledged as eth1 was not brought up yet.
>
> Placing this fixup in drivers/net/phy/marvell.c as in config_init  
> callback
> could be done, but this will add more overhead as the fixup routine  
> have
> to do more work:
>
> acquire 'struct mii_bus' pointer and walk through all registered PHYs
> searching for the PHY which use the same interrupt, then getting
> the address of this PHY on the bus and disable and clear PHY irqs
> by writing/reading to/from this PHY, (but only in the case it was
> not already brought up and has interrupts enabled!) e.g.:
>
> struct mii_bus *bus = phydev->bus;
> int addr;
>
> for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
> 	struct phy_device *phy = bus->phy_map[addr];
>
> 	if (addr != phydev->addr && bus->irq[addr] == phydev->irq &&
> 	    (phy->phy_id & 0x0ffffff0) == 0x01410cb0 &&
> 	    !(phy->interrupts & PHY_INTERRUPT_ENABLED)) {
>
> 		int imask = phy_read(phy, MII_M1011_IMASK);
>
> 		if (imask) {
> 			phy_write(phy, 0x12, 0); /* disable */
> 			phy_read(phy, 0x13); /* clear */
> 		}
> 	}
> }
>
> All this to allow support for multiple m88e1121 devices.
> Otherwise, after registering first phy interrupt handler
> and enabling interrupt pending irq on other PHY port or
> other PHY device will lock up the board.
>
> The fixup in this patch will only be done while mdio bus scan
> before registering a PHY device.

Did we ever resolve this?

- k
