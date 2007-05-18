Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6378DDF9B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 04:03:49 +1000 (EST)
Message-ID: <464DE8A1.6050908@freescale.com>
Date: Fri, 18 May 2007 12:55:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
	<20070518171555.543f9bdc@hyperion.delvare>
	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>
	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
	<464DDFA5.6050106@freescale.com>
	<79CACFC8-DD5B-4284-AC2E-C92FE2A85330@kernel.crashing.org>
In-Reply-To: <79CACFC8-DD5B-4284-AC2E-C92FE2A85330@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Once you expand the beyond just a root node for the controller I'd  like 
> to see how you suggest we handle the case where a particular  child ends 
> up having children as well.  You example, is sufficient  the majority of 
> devices, but I'd like to know that we'll be able to  handle the case 
> where a node is both a device and controller.

The example I gave *was* a controller and an i2c device at the same time 
(note the i2c-style reg = <70>).  Just take the fragment and stick it in 
an existing i2c controller node; I omitted the latter for brevity, as a 
result of making the mistake of typing it in Mozilla rather than mutt, 
and thus having no autoindent.

>> Given that power.org is attempting to do further standardization of  
>> the device tree for embedded applications, I'd be surprised if  there 
>> weren't a way we could have them act as a registry.
> 
> If/when they sign up for this I'd be more inclined to have kernel  
> support for it.

Fair enough.  I'm still interested in what you think would need to be 
done to support switches and muxes, from the context of standardizing it 
in ePAPR.  The bus numbering shouldn't be an issue as long as you keep 
the bus numbers local to the switch/mux, and don't pretend that they 
have anything to do with any global i2c bus number that the OS may or 
may not have.

>>> For I2C specifically we already have both a dynamic way (kernel  cmd  
>>> line) and static (i2c_board_info) to specify the i2c devices,  why 
>>> do  we need yet another?
>>
>>
>> This uses i2c_board_info; it doesn't replace it.
> 
> 
> Ok, but what functionality does it give us that we dont already have  
> today?

The convenience of putting the data in a dts rather than in 
board-specific code/structs.  It's not a huge deal, but I find the 
former to be a more pleasant way of doing things, and others have 
similarly expressed interest in it.

It would be significantly more useful as an ePAPR standard that can be 
used by multiple OSes, but they seem to be in 
standardize-what-Linux-does mode, hence why I proposed it here first.

-Scott
