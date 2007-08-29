Return-Path: <orutsch@sympatec.com>
Received: from sympatec.com (mail.sympatec.net [217.5.250.35])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AE6ADDE35
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 22:54:15 +1000 (EST)
Received: from [172.20.3.151] (account rutsch [172.20.3.151] verified)
	by sympatec.com (CommuniGate Pro SMTP 5.1.4)
	with ESMTPSA id 1982933 for linuxppc-embedded@ozlabs.org;
	Wed, 29 Aug 2007 14:54:10 +0200
Message-ID: <46D56C25.3020702@sympatec.com>
Date: Wed, 29 Aug 2007 14:52:53 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
References: <20070829074902.7634024044@gemini.denx.de>
In-Reply-To: <20070829074902.7634024044@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,


> 
> Probably it does not hang, but you just don't see any console output.
> Eventually  you  just  forgot  to  set  the  correct  console  device
> (/dev/ttyPSC0) or console speed.

I checked this. I think the TQM5200 is really hanging after the ...OK 
because I have activated the telnet server and normally I'm able to 
connect to the device after booting via ethernet. No ping, no telnet. 
With an older 2.6.19.2 kernel this was O.K.

> 
> Also, you need a recent version of U-Boot (for  example  99c2fdab  or
> later).

I'm using U-Boot 1.2.0-gbc2b9c33-dirty (Feb 22 2007 - 09:53:14). Is that 
recent enough? (I don't know exactly what you mean with "99c2fdab", is 
this the second number after "1.2.0-"?)
> 
> Try something like this:
> 
> => tftp 200000 /tftpboot/tqm5200/uImage
> => tftp 400000 /tftpboot/tqm5200/tqm5200.dtb

Maybe the problem is the missing tqm5200.dtb file. I have booted the 
kernel without it (just bootm 200000). Does the kernel need this file? I 
found a tqm5200.dts file the the kernel sources, but the device tree 
compiler (dtc) seems not to be in the 4.1 ELDK. Do I have to install 
this compiler and build the appropriate dtb file?


> 
> Please note that the device tree we have at the  moment  is  for  the
> TQM5200 only and does not include support for the TQM5200S.
> 
> But probably you just had the same problem - missing or  bad  console
> device specification.
> 

In older kernels it was O.K. just to uncheck the SM501 drivers in the 
kernel configuration. Has this changed?

Thanks and bye,

-- 
Dipl. Ing. Oliver Rutsch
