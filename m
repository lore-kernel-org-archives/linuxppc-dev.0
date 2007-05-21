Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1ACC3DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 01:05:15 +1000 (EST)
Message-ID: <4651B348.1060408@freescale.com>
Date: Mon, 21 May 2007 09:57:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>	<464C800C.20400@freescale.com>	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>	<464C871C.4090300@freescale.com>	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>	<20070518171555.543f9bdc@hyperion.delvare>	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>	<464DD5E3.1060301@freescale.com>	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>	<464DDFA5.6050106@freescale.com>	<79CACFC8-DD5B-4284-AC2E-C92FE2A85330@kernel.crashing.org>	<464DE8A1.6050908@freescale.com>
	<20070520135353.6b4dba0b@hyperion.delvare>
In-Reply-To: <20070520135353.6b4dba0b@hyperion.delvare>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare wrote:
> Hi Scott,
> 
> On Fri, 18 May 2007 12:55:45 -0500, Scott Wood wrote:
> 
>>Fair enough.  I'm still interested in what you think would need to be 
>>done to support switches and muxes, from the context of standardizing it 
>>in ePAPR.  The bus numbering shouldn't be an issue as long as you keep 
>>the bus numbers local to the switch/mux, and don't pretend that they 
>>have anything to do with any global i2c bus number that the OS may or 
>>may not have.
> 
> 
> But then you cannot declare devices on these segments and expect Linux
> to instantiate them. You'll have to wait for the segments to be created
> and only then you'll be able to create the devices on them (using
> i2c_new_device()).

You can declare devices by having platform code assign Linux bus numbers 
to them, just as with non-switched buses.  Of course, platform code 
would have to know about the switch to do that; it may be easier to just 
have the platform code register the switch driver and pass it a device 
tree node (or more generally, something opaque in platform data that 
gets passed back to platform code for registration) to do 
i2c_new_device()-based enumeration.

> Also, what's the point of giving numbers to the segments in the first
> place, if they don't correspond to anything?

The switch-local bus numbers are used to tell the switch which bus is 
being accessed.  The Linux bus numbers are used for device 
preregistration and user API.

They're both used, just for different purposes.

-Scott
