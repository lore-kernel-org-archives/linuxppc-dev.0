Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AE96DDF93
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 07:12:44 +1000 (EST)
Message-ID: <485828B0.4010101@freescale.com>
Date: Tue, 17 Jun 2008 16:12:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<48581188.90102@freescale.com>
	<20080617195739.GB13147@uranus.ravnborg.org>
	<485818AA.8090701@freescale.com>
	<20080617210055.GA13468@uranus.ravnborg.org>
In-Reply-To: <20080617210055.GA13468@uranus.ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, John Rigby <jrigby@freescale.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam Ravnborg wrote:
> But I was misguided by:
>> +config FS_ENET_MPC5121_FEC
>> +  select FS_ENET
> This is not good.

Why not, if we get rid of the prompt on FS_ENET?

> In general when you select a symbol that has dependencies you are almost
> always on the wrong track.

The dependencies on FS_ENET could continue to be valuable as 
documentation and verification of the conditions under which the driver 
will build, but the more specific options should make sure that they 
never select it when the dependencies aren't met.

> Use a dependency here with a sane default - then people can 
> set it to 'n' if they really do not want this driver.
> 
> Spreading selects too much is just causing you pain in the long run.

I'm not sure I understand what you're looking for, but I don't see 
anything wrong with something like this (apart from missing help text):

config FS_ENET
	bool
	select MII
	select PHYLIB

config FS_ENET_HAS_SCC
	bool "Freescale CPM SCC Ethernet"
	depends on CPM1 || CPM2
	select FS_ENET

config FS_ENET_HAS_FCC
	bool "Freescale CPM FCC Ethernet"
	depends on CPM2
	select FS_ENET

config FS_ENET_HAS_FEC
	bool "Freescale Fast Ethernet Controller"
	depends on CPM1 || PPC_MPC512x
	select FS_ENET

config FS_ENET_MDIO_FEC
	bool "Freescale FEC MDIO"
	depends on FS_ENET_HAS_FEC

config FS_ENET_MDIO_BITBANG
	bool "Freescale CPM Bitbanged MDIO"
	depends on CPM2

-Scott
