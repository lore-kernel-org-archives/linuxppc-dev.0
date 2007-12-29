Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DCF9BDDDF4
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Dec 2007 09:07:44 +1100 (EST)
Message-ID: <4776C518.6060002@freescale.com>
Date: Sat, 29 Dec 2007 16:07:20 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v5] qe: add ability to upload QE firmware
References: <11970422334145-git-send-email-timur@freescale.com>
	<20071226165004.GA11449@localhost.localdomain>
In-Reply-To: <20071226165004.GA11449@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <AFLEMING@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>> +		firmware {
>> +			id = "Soft-UART";
>> +			extended_modes = <0 0>;
>> +			virtual_traps = <0 0 0 0 0 0 0 0>;
> 
> I believe using underscores for the property name is discouraged.

Ugh, this one change would require me to repost all my patches.  Oh 
well.  I wish someone else had noticed it before I got to version 5.

I'll post a new version on January 7, when I get back to the office.

>> +A Python program that creates firmware binaries from the header files normally
>> +distributed by Freescale can be found on http://opensource.freescale.com.
> 
> Hm... I didn't find it there. Could you provide more specific pointer?

I'll add those files only after my patches have been applied.  The 
layout may change between now and then, and I don't want to have to 
repost the firmware.

>> +
>> +	/*
>> +	 * If we haven't checked yet, and a driver hasn't uploaded a firmware
>> +	 * yet, then check the device tree for information.
>> +	 */
>> +	do {
>         ^^^^
> This is very unusual method of error handling. You could stick
> to gotos and lower the indentation level.

Ok, I'll change it.  I wasn't crazy about it after I wrote it, anyway.

>> +		qe = of_find_node_by_type(NULL, "qe");
> 
> Please, add compatible "fsl,qe" matching, so this code could
> work with new device trees.

Ok, but that new design was added after I posted this patch.

>> +		/* Find the 'firmware' child node */
>> +		while ((fw = of_get_next_child(qe, fw)))
>> +			if (strcmp(fw->name, "firmware") == 0)
>> +				break;
> 
> Hmm. Maybe of_find_node_by_name? Or better by compatible.

What's wrong with looking for the firmware node inside the QE node? 
That's the only place it can be?

>> +		iprop = of_get_property(fw, "extended_modes", NULL);
> 
> Checking for size?

Ok.
