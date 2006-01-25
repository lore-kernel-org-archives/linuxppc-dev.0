Return-Path: <tnt@246tNt.com>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A75DE68A8C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 10:21:06 +1100 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0PNKu7S029932
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Jan 2006 00:20:57 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43D807E0.1090206@246tNt.com>
Date: Thu, 26 Jan 2006 00:21:04 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Txema Lopez <tlopez@aotek.es>
Subject: Re: [PATCH] Add support for lite5200b board.
References: <43D65FE3.6080501@freescale.com> <43D66F54.8000404@246tNt.com>
	<43D751F8.9060204@aotek.es>
In-Reply-To: <43D751F8.9060204@aotek.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Rigby <jrigby@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi

Txema Lopez wrote:
> Sylvain Munaut wrote:
>> John Rigby wrote:
>>> Here is an updated patch for the liteb board.
>>>
> We have a Lite5200b and are very interesting in this point.
> 
> For wich kernel version is this patch?

Should apply fine on vanilla. My suggestion for now is take vanilla,
apply this patch, then the 2-3 patch from Andrey for BestComm and stuff.

I haven't gotten around setup a git tree ... anyone know a good tutorial
not only on how to checkout stuff but how to well manage a remote
repository for publishing ?


>> Looks good. But two comments :
>>
>> * Isn't a modif to the arch/ppc/platform/Makefile missing ?
>> * What's the "cs-1" you turn on there :
>>
>>  
>>
>>>
>>> +#ifdef CONFIG_LITE5200B
>>> +    /* turn on cs1 */
>>> +    port_config |= 0x80000000;
>>> +#endif
>>>   
> What fix this ?

It's to activate the second bank of DDR-SDRAM. However, I find that's
the job of the bootloader. Fully initializing the memory subsystem is
one of the few things the kernel expects, so I probably won't include this.

My politics (at least for the 5200 stuff) is the boot loader should :
 * Init memory stuff like it wants (at least boot flash & all dynamic
mem). The init of some static chipselect could be done in platform init.
 * Put the pin muxes & stuff to the "safest" mode (that is for example
GPIO Input) execpt for what it requires for boot (like a console PSC and
ethernet). All other pin mux (defnitive one) should be done in platform
init depending on the board.


>>     I couldn't find the schema / real-doc of the Lite5200b,
>> is this available somewhere on-line ?
>>
> Sylvain, I don't know if there are some Lite5200b doc on line, but I
> have the schematics and could send to you or to anyone who want it.

Yes, please, I'd appreciate an early copy.
John sent the link to the User Manual but the latter hasn't the full
schematic.



Sylvain
