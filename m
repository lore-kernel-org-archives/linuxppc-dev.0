Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8EA0DDDE2B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 13:38:53 +1100 (EST)
Message-ID: <477EEDFA.9010205@freescale.com>
Date: Fri, 04 Jan 2008 20:39:54 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>,
	Liam Girdwood <liam.girdwood@wolfsonmicro.com>,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	<477BAB67.4080003@freescale.com>	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
In-Reply-To: <20080103235156.GE12883@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> And what distinction are you drawing between "first" and "second"
> here? 

Oh, that's an easy one:  The CS4270 can work without an I2C or SPI connection, 
but it will never work without an I2S connection.

> Why would the I2S need to scan for codecs?  Wouldn't it be up to the
> codec driver to register with I2S?

Not in ASoC V1.  The codec driver registers with ASoC, but the actual 
connection to other devices (e.g. the I2S driver) is done either in the I2S 
driver or in the fabric driver, depending on your mood.  And that connection 
is done via a pointer to a structure in the codec driver.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
