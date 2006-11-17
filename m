Return-Path: <tnt@246tNt.com>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B56067B93
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 06:10:15 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kAHJA9ca020909
	for <linuxppc-embedded@ozlabs.org>; Fri, 17 Nov 2006 20:10:09 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <455E0907.8000009@246tNt.com>
Date: Fri, 17 Nov 2006 20:09:59 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Jarno Manninen <jarno.manninen@tut.fi>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
	libata
References: <11637151391017-git-send-email-tnt@246tNt.com>
	<200611172049.49260.jarno.manninen@tut.fi>
In-Reply-To: <200611172049.49260.jarno.manninen@tut.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jarno Manninen wrote:
> On Friday 17 November 2006 00:12, Sylvain Munaut wrote:
>
>   
>> * The manual states we should check for the TIP bit before all
>> PIO transaction. That's not really supported by libata and requires
>> reimplementing almost all the hooks. But after talking to Freescale,
>> it turnsout it's not really necessary. So this driver doesn't implement
>> that check. I noticed no problem so far ...
>>     
>
> I've had some bad experiences with 2.4 line kernel when using BAPI 2.2 on Rev. 
> A 5200 while imposing heavy I/O load. Problems manifested as hanging XLB-bus 
> and so on. Funny thing is that combinations like Rev.A + BAPI 2.1 and Rev.B + 
> BAPI 2.[12] seem to be immune while doing similar stress tests.
>
> Problems went away after wrapping PIO access like this:
>
> 1. Stop XLB-pipelining
> 2. Wait for TIP bit to go down.
> 3. Do the access
> 4. Restore XLB-pipelining.
>
> Just polling for the TIP bit is not enough due to errata on Rev. A if the 
> pipelining is enabled.
>
> Just in case if someone else is having mysterious hangs on Rev.A:s with newer 
> microcode. :)
>   
Thanks for the info ! I'll certainly try to remember that.


The currentl kernel doesn't handle DMA so far so there is no problem and
we deactivate
XLB pipelining.

Since the current libata doesn't really support overriding IO accessors,
I'd keep it like
that for now. Apparently some other architecture needs special IO stuff
so we could see
a way to hook io accessor soon, and then we can change it if we notice
big problems.


    Sylvain
