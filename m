Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D064DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 11:41:28 +1100 (EST)
Message-ID: <47992E4D.7010500@freescale.com>
Date: Thu, 24 Jan 2008 18:33:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [i2c] [PATCH 3/3] Add device tree compatible aliases to
	i2c	drivers
References: <20080123020912.31675.48787.stgit@terra.home>	<20080123020916.31675.98481.stgit@terra.home>
	<20080125003249.GA30794@lixom.net>
In-Reply-To: <20080125003249.GA30794@lixom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> For example, for an eeprom I might have: "MCHP,24lc128est",
> "MCHP,24xx128", "24c128". The at24 driver (not in mainline yet :) would
> likely match with "24c128", and it would normally not make sense to have
> to list all specific vendors and models of the device type in question
> in the driver.

It's not really about the vendors of the device, but the namespace it 
goes into.  If there's really no canonical vendor name, then a plain old 
"24c148" might make sense, but that seems like it'd be fairly rare.

> I can't register a board_info for each of the compatible fields without
> changing the way the i2c drivers are registered, since the creation of
> the duplicate entries will start reporting errors.

Even with the current i2c changes that have been flying around the 
lists?  If so, it should be fixed...

> So it seems that the solution would be to make i2c_board_info take a
> list of names for the device, and each of them has to be matched with
> all drivers, taking the first match.

Agreed.

-Scott
