Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85CB7B7D57
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 05:24:19 +1100 (EST)
Message-ID: <4B671C4D.5070806@freescale.com>
Date: Mon, 01 Feb 2010 12:24:13 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan.Geer@faa.gov
Subject: Re: BSE-IP
References: <OF7C180968.43598D84-ON852576BD.006286D6-852576BD.0063AC38@faa.gov>
In-Reply-To: <OF7C180968.43598D84-ON852576BD.006286D6-852576BD.0063AC38@faa.gov>
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
> I'm hoping someone can offer some advice on this:
> 
> I'm working with an embedded platform that does not pass anything from
> firmware. I'm just trying to get some activity out the serial console at
> this stage.  simpleImage.bseip compiled with the following bseip.dts seems
> to freeze before anything is written to the console.  I'm assuming the
> standard 8xx code will pickup this device tree, and work from there.  Is
> this correct?  Shouldn't I see some output?

Has your firmware already set up the serial port?  cpm-serial doesn't make 
assumptions about specific addresses, but it does assume that the BRG, pins, 
etc. have been set up for the serial port to work.

If this isn't the case, you'll need to do it from a custom bootwrapper platform 
file.

>                                      d-cache-line-size = <8>;		 // 8 bytes
> per line
>                                      i-cache-line-size = <8>;		 // 8 bytes
> per line

Shouldn't this be 16 bytes?

>              soc@ff000000 {

Is this the correct IMMR address for your firmware?

-Scott
