Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 27A70DDEDB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:52:47 +1000 (EST)
Message-ID: <4821FAB1.1070200@freescale.com>
Date: Wed, 07 May 2008 13:53:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Boris Shteinbock <bshtein@yahoo.com>
Subject: Re: powerpc port for sbc8260-based board problem
References: <833555.65590.qm@web50611.mail.re2.yahoo.com>
In-Reply-To: <833555.65590.qm@web50611.mail.re2.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Boris Shteinbock wrote:
>> The second reg resource depends on where your firmware set up the SMC pram
>> regs.  With U-boot, it's usually zero.
> 
>> Note that as of 2.6.26-rc1, this is set up dynamically instead, and the
>> second resource should be .
> Is this correct?
> 
>         reg = <0x11a80 0x20 0x87fc 2>;

Yes.

> I also understand, that latest development kernel contains some significant changes in SMC UART code, especially
> in muram code, is this correct? So does this reg value reflect this change?

Yes, those are the changes I was referring to.

>>> Can someone, also, explain, how "fsl, cpm-command" field works,
> 
>> It's the device-specific portion of the value that gets written to the CPM
>> command register (page, sub-block, and mcc channel).
> 
> Is it possible to get a quick list of all values for all 8260 soc devices somewhere ? Or do I have to dig  specific Freescale reference for it?

See table 13-6 (CP Command Register Field Descriptions) in the 8260 manual.

> I am particularly interested in SMC2 and FCC1,2 and 3 ?

SMC2: 0x21200000
FCC1: 0x12000000 (ATM 0x11c00280)
FCC2: 0x16200000 (ATM 0x15c00280)
FCC3: 0x1a400000

For FCCs, add 0x300 for Ethernet, 0x3c0 for transparent.

-Scott
