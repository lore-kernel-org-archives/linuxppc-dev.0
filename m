Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A70BDDF28
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 04:47:36 +1000 (EST)
Message-ID: <461D2D5A.4010905@genesi-usa.com>
Date: Wed, 11 Apr 2007 19:47:54 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] autodetect serial console on efika
References: <20070331150823.GA25421@aepfle.de>	<461A3817.8080303@genesi-usa.com>
	<20070410165246.GC508@aepfle.de> <461BF2CC.7090502@246tNt.com>
In-Reply-To: <461BF2CC.7090502@246tNt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sylvain Munaut wrote:
> Olaf Hering wrote:
>> On Mon, Apr 09, Matt Sealey wrote:
>>
>>   
>>> It is entirely possible that a user may redirect the OF console output to
>>> the PSC6 controller or another internal or external serial device (PCI
>>> serial controller or so). In this case, the boot console will simply switch
>>> to the UART on the back, which may be some other custom device and not a
>>> valid console.
>>>     
>> How many serial drivers are enabled in the public Efika firmware?
>> With my change, both /failsafe and the /builtin/serial work.
>> Both have device_type == "serial"
>>   
> If I follow the logic of the patch correctly, as soon as there is no
> "console=" in the command line and that the linux,stdout-path has a
> device_type "serial", you add ttyPSC0 as console ?
> 
> The user could have plugged a console on the IRDA PSC and used a
> bootscript to change the OF tree appropriately.
> Or he could have put a PCI multi IO card and set the stdout to it ...
> 
> In all those cases, the ttyPSC0 is bogus ...
> 
> But in those "special cases", I guess it's not too much to ask the user
> to provide a "console=" in the command line.

I think in this case, output should not be redirected, it should fail out
(the current code doesn't, it only checks device type). It should also be
documented that the behaviour only caters for the /failsafe and /builtin/serial
devices and any other serial consoles will require a console= line.

This should be enough warning for users who have more 'crazy' serial port
setups. Definitely, it is possible these users have something attached to
the serial port on the back of the board and have moved the firmware console
for a good reason. You do not want Linux spamming the serial port if you did
not tell it to, and it is not certain that this is the port they want.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
