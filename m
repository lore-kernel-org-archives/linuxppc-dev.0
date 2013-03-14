Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <514225E9.9060902@openwrt.org>
Date: Thu, 14 Mar 2013 20:32:57 +0100
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] mv643xx_eth: convert to use the Marvell Orion MDIO driver
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-2-git-send-email-florian@openwrt.org>
 <20130314190235.GW12700@titan.lakedaemon.net>
In-Reply-To: <20130314190235.GW12700@titan.lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Lennert Buytenhek <buytenh@wantstofly.org>,
 Rob Landley <rob@landley.net>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Jason,

Le 14/03/2013 20:02, Jason Cooper a écrit :
> Florian,
>
> On Thu, Mar 14, 2013 at 07:08:32PM +0100, Florian Fainelli wrote:
>> This patch converts the Marvell MV643XX ethernet driver to use the
>> Marvell Orion MDIO driver. As a result, PowerPC and ARM platforms
>> registering the Marvell MV643XX ethernet driver are also updated to
>> register a Marvell Orion MDIO driver. This driver voluntarily overlaps
>> with the Marvell Ethernet shared registers because it will use a subset
>> of this shared register (shared_base + 0x4 - shared_base + 0x84). The
>> Ethernet driver is also updated to look up for a PHY device using the
>> Orion MDIO bus driver.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>>   arch/arm/plat-orion/common.c               |   97 +++++++++++----
>>   arch/powerpc/platforms/chrp/pegasos_eth.c  |   20 +++
>>   arch/powerpc/sysdev/mv64x60_dev.c          |   14 ++-
>>   drivers/net/ethernet/marvell/Kconfig       |    1 +
>>   drivers/net/ethernet/marvell/mv643xx_eth.c |  186 ++--------------------------
>>   include/linux/mv643xx_eth.h                |    1 -
>>   6 files changed, 117 insertions(+), 202 deletions(-)
>
> Isn't this the old version of 4/4 ?

No this really is v2, but I reformatted just that one and sent it 
without the v2 changelog, you should have received the proper version a 
couple minutes later once I realized my mistake.
--
Florian
