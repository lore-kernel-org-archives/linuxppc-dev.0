Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35B7CDE10A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 23:27:36 +1000 (EST)
Message-Id: <59B1F61A-BFB7-47CF-A1D8-323669CB08F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0905201425540.5871@vixen.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/ep8248e: phylib needs NET_SCHED to build
Date: Wed, 20 May 2009 08:27:24 -0500
References: <1242821902-16836-1-git-send-email-a.beregalov@gmail.com>
	<alpine.LRH.2.00.0905201425540.5871@vixen.sonytel.be>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexander Beregalov <a.beregalov@gmail.com>,
	Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2009, at 7:27 AM, Geert Uytterhoeven wrote:

> On Wed, 20 May 2009, Alexander Beregalov wrote:
>> Fix this build error:
>> drivers/built-in.o: In function `phy_state_machine':
>> drivers/net/phy/phy.c:893: undefined reference to 'netif_carrier_off'
>> drivers/net/phy/phy.c:854: undefined reference to 'netif_carrier_on'
>>
>> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
>> ---
>> arch/powerpc/platforms/82xx/Kconfig |    3 +++
>> 1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/ 
>> platforms/82xx/Kconfig
>> index 7c7df40..36a3e58 100644
>> --- a/arch/powerpc/platforms/82xx/Kconfig
>> +++ b/arch/powerpc/platforms/82xx/Kconfig
>> @@ -31,6 +31,9 @@ config EP8248E
>> 	select 8260
>> 	select FSL_SOC
>> 	select PHYLIB
>> +	select NET
>> +	select NETDEVICE
>> +	select NET_SCHED
>> 	select MDIO_BITBANG
>> 	help
>> 	  This enables support for the Embedded Planet EP8248E board.
>
> Why is there a `select PHYLIB' at the platform level? Shouldn't it  
> be in
> drivers/net/Kconfig, near the appropriate network driver? That way  
> people can
> build kernels without networking support, if they want.

I agree w/you however the initial reason it was:

commit ff21f23648d33649fcf3e1e99d03e245f0e1acf8
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Wed Jul 16 17:47:54 2008 -0500

     powerpc/ep8248e: Unconditionally select PHYLIB for mdio_bitbang

     Its possible to build the phylib as a module, however this breaks  
the
     board code because alloc_mdio_bitbang and mdiobus_register are not
     available if we build as a module.  These are needed by the board  
code
     since it implements the low level mdio bitbang ops.

     So we unconditionally select PHYLIB to ensure its built into the  
kernel
     if we are building in EP8248E support.

     Long term we should look at moving the mdio_ops into its own file  
so it
     can be built as a module.

     Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

so maybe it should:

	select PHYLIB if NET

- k
