Return-Path: <wg@grandegger.com>
Message-ID: <484393CC.3080709@grandegger.com>
Date: Mon, 02 Jun 2008 08:31:40 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>,  Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<20080602020352.GB19393@yookeroo.seuss>
In-Reply-To: <20080602020352.GB19393@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, May 30, 2008 at 08:49:45AM +0200, Wolfgang Grandegger wrote:
>> This patch adds support for the TQM8548 modules from TQ-Components
>> GmbH (http://www.tqc.de).
> 
> [snip]
>> index 0000000..d09250a
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/tqm8548.dts
>> @@ -0,0 +1,370 @@
>> +/*
>> + * TQM8548 Device Tree Source
>> + *
>> + * Copyright 2006 Freescale Semiconductor Inc.
>> + * Copyright 2008 Wolfgang Grandegger <wg@denx.de>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +/dts-v1/;
> 
> [snip]
>> +		i2c@3000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			cell-index = <0>;
> [...]
>> +		enet0: ethernet@24000 {
>> +			cell-index = <0>;
> [...]
>> +		serial0: serial@4500 {
>> +			cell-index = <0>;
> [...]
>> +	pci0: pci@e0008000 {
>> +		cell-index = <0>;
> 
> You have a whole lot of 'cell-index' properties through both these
> trees, and they all look wrong.  cell-index is a hack, which should be
> avoided wherever practical - it should only be used when the index is
> used to offset into some global register block, never simply to
> differentiate (use reg for that) or name the devices (use aliases for
> that).

OK, I can remove them from the TQM85*.dts files but I think the problem
is more general. It seems to be frequently used for similar purposes,
also in the code, at least in 2.6.26-rc4:

  $ cd linux-2.6/arch/powerpc/boot/dts
  $ grep -l 'cell-index' *.dts | wc -l
  58

Wolfgang
