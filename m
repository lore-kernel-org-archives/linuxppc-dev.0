Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E3284B70DD
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 13:00:52 +1100 (EST)
Message-ID: <4CBCFC5D.3010403@windriver.com>
Date: Tue, 19 Oct 2010 10:03:09 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: CONFIG_FEC is not good for mpc8xx ethernet?
References: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>	<4CBC080A.7030005@windriver.com>
	<20101018114214.2e72a616@udp111988uds.am.freescale.net>
In-Reply-To: <20101018114214.2e72a616@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Mon, 18 Oct 2010 16:40:42 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> 
>> Shawn Jin wrote:
>>> Hi,
>>>
>>> My target is a mpc875 based board and has FEC ethernet. The phy is
>>> AM79C874. I have the following configuration for the network support.
>>>
>>> CONFIG_PHYLIB=y
>>> CONFIG_NET_ETHERNET=y
>>> CONFIG_MII=y
>>> CONFIG_FS_ENET=y
>>> CONFIG_FS_ENET_HAS_FEC=y
>>> CONFIG_FS_ENET_MDIO_FEC=y
>>>
>>> However I found that the phy support (AM79C874) is actually in
>>> drivers/net/fec.c which is compiled only when CONFIG_FEC=y. However
>> The phy driver should not be embedded into the NIC driver in theory.
> 
> Right, those are handled by drivers/net/phy/.
> 
>> I think you should include the phy driver, mdio-bitbang.c, which should be
>> support AMD79C874.
> 
> On MPC8xx you want drivers/net/fs_enet/mii-fec.c.  This is just the
> MDIO driver; it doesn't handle any particular PHY.  I don't know if
> there is a driver specifically for AM79C874, though the generic PHY
> support may be good enough.

Maybe.

I can found one related patch for supporting PHY AM79C874 on 2.6.15,
------
http://lists.ozlabs.org/pipermail/linuxppc-embedded/2005-November/021043.html

But I don't see that on the latest kernel, and also I don't know the history
completely for that. Maybe its already merged into one generic PHY driver but
I'm not sure.

Tiejun

> 
> -Scott
> 
> 
