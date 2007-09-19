Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6BBFDDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 04:29:34 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l8JITTeI009737
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 11:29:30 -0700 (MST)
Message-ID: <46F16A6A.8030802@freescale.com>
Date: Wed, 19 Sep 2007 13:28:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] qe: miscellaneous code improvements and fixes to the
	QE	library
References: <11902199121734-git-send-email-timur@freescale.com>
In-Reply-To: <11902199121734-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> -void qe_setbrg(u32 brg, u32 rate)
> +void qe_setbrg(unsigned int brg, unsigned int rate, unsigned int multiplier)
>  {
>  	volatile u32 *bp;

While you're at it, this should be __be32 __iomem *, no volatile.

> +/* Configure the UCC to either Slow or Fast.
> + *
> + * A given UCC can be figured to support either "slow" devices (e.g. UART)
> + * or "fast" devices (e.g. Ethernet).
> + *
> + * 'ucc_num' is the UCC number, from 0 - 7.
> + *
> + * This function also sets the UCC_GUEMR_SET_RESERVED3 bit because that bit
> + * must always be set to 1.
> + */
> +int ucc_set_type(unsigned int ucc_num, enum ucc_speed_type speed)
>  {
> -	u8 guemr = 0;
> +	u8 __iomem *p_guemr;

We don't do Hungarian notation in Linux. :-)
What's wrong with just "u8 __iomem *guemr"?

-Scott
