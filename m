Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62412DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 09:03:24 +1100 (EST)
Message-ID: <472F915F.9010400@freescale.com>
Date: Mon, 05 Nov 2007 15:55:43 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>		<472F7247.9070106@freescale.com>	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com> <472F9086.2060606@genesi-usa.com>
In-Reply-To: <472F9086.2060606@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Scott Wood wrote:
>> Jon Smirl wrote:
> 
>>>>> cell-index = <1>;
>>>> What is cell-index for?
>>> I was using it to control the bus number, is that the wrong
>>> attribute?
>> 
>> It shouldn't be specified at all -- the hardware has no concept of
>> a device number.
> 
> Well, all i2c devices have a chip id you can probe for,

I meant a controller device number (a.k.a. bus number), which (outside 
of documentation) is purely a Linux invention, and which is what 
cell-index was being used for above.

> as for buses I think cell-index is a holdover from the way the PSC
> code is organised on the MPC5200 for example - if you have multiple
> buses which use the same registers, for example. It's redundant on
> the PSC's for programming because they all use different register
> offsets but if you move to other devices like the GPTs, then it is
> then useful for debugging (it is far more interesting to say GPT1
> than GPT @ offset to match the) and in general for tweaking OTHER
> parts of the chip (for instance the CDM - very relevant!) which use
> single registers to control entire swathes of units.

Right, that's what cell-index is for.  This is different. :-)

-Scott
