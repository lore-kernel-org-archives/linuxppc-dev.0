Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5482DDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:44:52 +1100 (EST)
Message-ID: <478BE5D1.9080300@freescale.com>
Date: Mon, 14 Jan 2008 16:44:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [DTC PATCH] libfdt: Add ft_get_next_node(), ft_get_next_prop(),
	and ft_getprop_offset().
References: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
	<20080115093149.39a1d703.sfr@canb.auug.org.au>
In-Reply-To: <20080115093149.39a1d703.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
>> +++ b/libfdt/libfdt.h
> 
>> +#define FDT_ERR_BADDEPTH	8
> 
> Wouldn't it have been less intrusive to just use the next error number
> rather than inserting this here?

Yes, but then either the order in errtable[] wouldn't match the order in 
the header file, or the error type grouping would be broken.

If we want to maintain such a grouping, we should probably leave some 
number space between the groups.

>> + * fdt_getprop_offset - retrieve the value of a given property by offset
>> + * @fdt: pointer to the device tree blob
>> + * @propoffset: offset of the property to read
>> + * @name: pointer to a character pointer (will be overwritten) or NULL
>                           ^^^^^^^^^^^^^^^^^
> "string"?

"pointer to a string" could be interpreted as "char *", not "char **".

I'll fix the others; thanks for pointing them out.

-Scott
