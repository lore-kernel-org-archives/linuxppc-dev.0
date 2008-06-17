Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EAC43DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 09:52:52 +1000 (EST)
Date: Tue, 17 Jun 2008 16:52:25 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
In-Reply-To: <485828B0.4010101@freescale.com>
Message-ID: <Pine.LNX.4.64.0806171648300.7584@t2.domain.actdsltmp>
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<48581188.90102@freescale.com>
	<20080617195739.GB13147@uranus.ravnborg.org>
	<485818AA.8090701@freescale.com>
	<20080617210055.GA13468@uranus.ravnborg.org>
	<485828B0.4010101@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>, jeff@garzik.org,
	John Rigby <jrigby@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jun 2008, Scott Wood wrote:
> Sam Ravnborg wrote:
>>  In general when you select a symbol that has dependencies you are almost
>>  always on the wrong track.
>
> more specific options should make sure that they never select it when the 
> dependencies aren't met.

Sure, in theory that would work, but in practice this ends up being a constant
source of broken builds.

>>  Use a dependency here with a sane default - then people can set it to 'n'
>>  if they really do not want this driver.
>>
>>  Spreading selects too much is just causing you pain in the long run.
>
> I'm not sure I understand what you're looking for, but I don't see anything 
> wrong with something like this (apart from missing help text):
>
> config FS_ENET
> 	 bool
> 	 select MII
> 	 select PHYLIB
>
> config FS_ENET_HAS_SCC
> 	 bool "Freescale CPM SCC Ethernet"
> 	 depends on CPM1 || CPM2
> 	 select FS_ENET

What prevents me from turning on FS_ENET_HAS_SCC without MII or PHYLIB?  Why
is FS_ENET_HAS_SCC a bool, and not tristate?
