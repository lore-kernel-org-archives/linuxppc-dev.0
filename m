Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EFA41B70E2
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 18:44:06 +1100 (EST)
Message-ID: <4CBE9E50.7010007@windriver.com>
Date: Wed, 20 Oct 2010 15:46:24 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: CONFIG_FEC is not good for mpc8xx ethernet?
References: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>	<4CBC080A.7030005@windriver.com>	<20101018114214.2e72a616@udp111988uds.am.freescale.net>	<4CBCFC5D.3010403@windriver.com>
	<AANLkTinN-xOecVynPYxmLoT9HJKFs0iPo3pLXF05Tudv@mail.gmail.com>
In-Reply-To: <AANLkTinN-xOecVynPYxmLoT9HJKFs0iPo3pLXF05Tudv@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shawn Jin wrote:
>>> On MPC8xx you want drivers/net/fs_enet/mii-fec.c. �This is just the
>>> MDIO driver; it doesn't handle any particular PHY. �I don't know if
>>> there is a driver specifically for AM79C874, though the generic PHY
>>> support may be good enough.
>> Maybe.
>>
>> I can found one related patch for supporting PHY AM79C874 on 2.6.15,
>> ------
>> http://lists.ozlabs.org/pipermail/linuxppc-embedded/2005-November/021043.html
>>
>> But I don't see that on the latest kernel, and also I don't know the history
>> completely for that. Maybe its already merged into one generic PHY driver but
>> I'm not sure.
> 
> Thank Scott & Tiejun for valuable information.
> 
> The problem for me is that the PHY failed to be probed. The related
> error messages are shown below. I even tried the patch Tiejun pointed
> out. But that doesn't help. The phy ID read from the bus was all Fs.
> 
> FEC MII Bus: probed
> mdio_bus fa200e00: error probing PHY at address 0

Is this is all log related to PHY? And are you sure your PHY Address is zero?

Often there are at most 32 PHY devices resided one MDIO bus. So you can dump PHY
ID to check if there is a PHY firstly. A ID value of 0xffff indicates that the
address is invalid if I recalled properly.

But I think PHY driver already do the above process on Linux.

So looks MDIO driver cannot compatible for your platform. I recommend you try
debug mdio driver to access valid PHY ID firstly. Especially where/why this stop
at address '0'? When you can get a valid PHY ID you can go phy driver.

> 
> I don't know if AM79C874 requires any special handling. But from the
> comment in mdiobb_cmd() there seems to be something special.
>         /*
>          * Send a 32 bit preamble ('1's) with an extra '1' bit for good
>          * measure.  The IEEE spec says this is a PHY optional
>          * requirement.  The AMD 79C874 requires one after power up and
>          * one after a MII communications error.  This means that we are
>          * doing more preambles than we need, but it is safer and will be
>          * much more robust.
>          */
> 
> If there is any network action in u-boot, e.g., tftp or ping, the PHY
> can be successfully probed after that. Any hints what went wrong with

On bootstrap the driver should reset MDIO bus/PHY before probing PHY again.

Tiejun

> the PHY?
> 
> Thanks,
> -Shawn.
> 
