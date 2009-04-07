Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B5F0ADDFB6
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 03:24:21 +1000 (EST)
Message-ID: <49DB8C3C.5080306@denx.de>
Date: Tue, 07 Apr 2009 19:24:12 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: 85xx: Add PHY fixup to socrates board code
References: <1239113988-4579-1-git-send-email-agust@denx.de>
	<20090407143011.GA15727@oksana.dev.rtsoft.ru>
In-Reply-To: <20090407143011.GA15727@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Tue, Apr 07, 2009 at 04:19:48PM +0200, Anatolij Gustschin wrote:
>> If the firmware missed to initialize the PHY correctly,
>> Linux may hang up on socrates while eth0/eth1 interface
>> startup (caused by continuous unacknowledged PHY interrupt).
>>
>> This patch adds PHY fixup to socrates platform code to
>> ensure the PHY is pre-initialized correctly. It is needed
>> to be compatible with older firmware.
> 
> Is that really board-specific fixup, or can it be placed
> somewhere inside drivers/net/phy/marvell.c?

On this board the multi-PHY is configured to use shared IRQ pin
for both PHY ports. Placing this fixup in drivers/net/phy/marvell.c
as e.g. '.config_init' callback could be done, but this will add
more overhead as the fixup routine have to do more work:

acquire 'struct mii_bus' pointer and walk through all registered PHYs
searching for the PHY which use the same interrupt, then getting
the address of this PHY on the bus and disable and clear PHY irqs
by writing/reading to/from this PHY, (but only in the case it was
not already brought up and has interrupts enabled!) e.g.:

struct mii_bus *bus = phydev->bus;
int addr;

for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
	struct phy_device *phy = bus->phy_map[addr];

	if (addr != phydev->addr && bus->irq[addr] == phydev->irq &&
	    (phy->phy_id & 0x0ffffff0) == 0x01410cb0 &&
	    !(phy->interrupts & PHY_INTERRUPT_ENABLED)) {

		int imask = phy_read(phy, MII_M1011_IMASK);

		if (imask) {
			phy_write(phy, 0x12, 0); /* disable */
			phy_read(phy, 0x13); /* clear */
		}
	}
}

All this to allow support for multiple m88e1121 devices.
Otherwise, after registering first phy interrupt handler
and enabling interrupt pending irq on other PHY port or
other PHY device will lock up the board.

The fixup in this patch will only be done while mdio bus scan
before registering a PHY device.

> Has this fixup any effect after phy power down/up sequence?
> Otherwise you may encounter same problem after suspend/resume.

No, do we need it after phy power down/up sequence?
If each phy interrupt handler remains registered and the phy is
only stopped  (phydev->state == PHY_HALTED) we don't have
this problem, i think. And we do not use PM on this board.
 
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> ---
>>  arch/powerpc/platforms/85xx/socrates.c |   18 ++++++++++++++++++
>>  1 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
>> index d0e8443..2275a39 100644
>> --- a/arch/powerpc/platforms/85xx/socrates.c
>> +++ b/arch/powerpc/platforms/85xx/socrates.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/phy.h>
>>  
>>  #include <asm/system.h>
>>  #include <asm/time.h>
>> @@ -78,6 +79,21 @@ static void __init socrates_pic_init(void)
>>  	of_node_put(np);
>>  }
>>  
>> +static int socrates_m88e1121_fixup(struct phy_device *phydev)
>> +{
>> +	int err;
>> +
>> +	err = phy_write(phydev, 0x12, 0);
> 
> Do you know the proper names for 0x12 and 0x13 registers
> on that chip?

Marvell PHY driver defines them as MII_M1011_IMASK and
MII_M1011_IEVENT respectively. I can use these defines
here too. The data sheet is under NDA.

Thanks,
Anatolij
