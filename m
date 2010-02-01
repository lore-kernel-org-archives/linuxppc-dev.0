Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5959B7D31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 06:07:09 +1100 (EST)
Message-ID: <4B67264E.3080100@freescale.com>
Date: Mon, 01 Feb 2010 13:06:54 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan.Geer@faa.gov
Subject: Re: BSE-IP
References: <OF7C180968.43598D84-ON852576BD.006286D6-852576BD.0063AC38@faa.gov>
	<4B671C4D.5070806@freescale.com>
	<OF7ADBC091.CA74BF20-ON852576BD.0065FA13-852576BD.00685848@faa.gov>
In-Reply-To: <OF7ADBC091.CA74BF20-ON852576BD.0065FA13-852576BD.00685848@faa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan.Geer@faa.gov wrote:
>> Has your firmware already set up the serial port?  cpm-serial doesn't
> make
>> assumptions about specific addresses, but it does assume that the BRG,
> pins,
>> etc. have been set up for the serial port to work.
> 
> Yes. Or, so I thought. First, I interrupt the bootstrap with <Esc>.  Then,
> I load the image into RAM with 'load simpleImage.bseip 200000' then 'go
> 200000'.  All of which is echo'd out the serial console by the firmware.
> I assumed that the low-level setups were complete.  However, in the old
> ppc/boot/m8xx_tty.c there is some initialization for SMC1 and the BRG
> (serial_init()).  Where should I do this in the new model?  Is
> platform_specific_init() the right place?

That'd be the place -- though it's also possible that it is already set up and 
the old code simply didn't assume it, and the problem is somewhere else.

If you don't have an external debugger, you may want to dump some registers from 
the firmware prompt and determine where it set up the tx ring, and use that for 
early debugging.

-Scott
