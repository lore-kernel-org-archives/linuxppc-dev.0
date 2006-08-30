Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C453E67B64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 23:43:35 +1000 (EST)
Date: Wed, 30 Aug 2006 08:55:07 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Chun Chung Lo <cclo@astri.org>
Subject: Re: DS1302 driver for powerpc
Message-ID: <20060830135507.GA19477@gate.crashing.org>
References: <A7B1E4DD46AA7046A4398F745240F29402737D5B@ASPROEXG.astri.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A7B1E4DD46AA7046A4398F745240F29402737D5B@ASPROEXG.astri.local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 30, 2006 at 07:54:16PM +0800, Chun Chung Lo wrote:
> 
> Hi all,
> 
> I am now doing a STB project and the development board uses a DS1302
> (trickle charge timekeeping chip) as a RTC. Our board is a IBM PPC405EP
> with a linux kernel 2.4.20 running on it. And the DS1302 is controlled
> by 2 GPIO pins instead of I2C.
> 
> I would like to ask are there any porting of DS1302 support under ppc
> architecture? (I can only find DS1302 is supported under cris
> architecture.)

There doesn't seem to be any DS1302 support "for ppc" available. However,
even if there were a platform with DS1302 support you'd be in the same
boat as the low-level support for cris.  Support for DS1302 has a glue
layer that's board-specific based on what GPIO pins are used to drive
it.  So if you had this driver for another PPC system like 83xx you'd
still have no better starting point than the cris ds1302 driver glue
since the GPIO mechanism/connection is different. Porting the
board-specific glue from arch/cris/drivers/ds1302.c to 4xx GPIO is
trivial to do though.

-Matt
