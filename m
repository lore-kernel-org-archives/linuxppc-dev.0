Return-Path: <tnt@246tNt.com>
Received: from outmx021.isp.belgacom.be (outmx021.isp.belgacom.be
	[195.238.4.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C828CDDED4
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 06:26:22 +1000 (EST)
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
	by outmx021.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l3AKQDph027006
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 22:26:16 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <461BF2CC.7090502@246tNt.com>
Date: Tue, 10 Apr 2007 22:25:48 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] autodetect serial console on efika
References: <20070331150823.GA25421@aepfle.de>	<461A3817.8080303@genesi-usa.com>
	<20070410165246.GC508@aepfle.de>
In-Reply-To: <20070410165246.GC508@aepfle.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> On Mon, Apr 09, Matt Sealey wrote:
>
>   
>> It is entirely possible that a user may redirect the OF console output to
>> the PSC6 controller or another internal or external serial device (PCI
>> serial controller or so). In this case, the boot console will simply switch
>> to the UART on the back, which may be some other custom device and not a
>> valid console.
>>     
>
> How many serial drivers are enabled in the public Efika firmware?
> With my change, both /failsafe and the /builtin/serial work.
> Both have device_type == "serial"
>   
If I follow the logic of the patch correctly, as soon as there is no
"console=" in the command line and that the linux,stdout-path has a
device_type "serial", you add ttyPSC0 as console ?

The user could have plugged a console on the IRDA PSC and used a
bootscript to change the OF tree appropriately.
Or he could have put a PCI multi IO card and set the stdout to it ...

In all those cases, the ttyPSC0 is bogus ...

But in those "special cases", I guess it's not too much to ask the user
to provide a "console=" in the command line.


    Sylvain
