Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6EEE9DDF12
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:28:40 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4F1UCAp827646
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:30:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F1VxoP083446
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:31:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F1SRNi029437
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:28:27 +1000
Date: Tue, 15 May 2007 11:28:25 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] Bamboo wrapper
Message-ID: <20070515012825.GD565@localhost.localdomain>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154791.3420.26.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179154791.3420.26.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 09:59:51AM -0500, Josh Boyer wrote:
> Add a bootwrapper for Bamboo

[snip]
> +#define DCRN_MAL0_CFG 0x180
> +static void ibm440ep_reset_eth(void)
> +{
> +	/* reset the MAL and EMACs since PIBS doesn't do this for us */
> +	u32 *emac0 = (u32 *)0xef600e00;
> +	u32 *emac1 = (u32 *)0xef600f00;
> +
> +	*emac0 = 0x20000000;
> +	*emac1 = 0x20000000;
> +	mtdcr(DCRN_MAL0_CFG, 0x80000000);
> +}

Since a number of 4xx board firmware suffer from this EMAC/MAL reset
problem it would be nice to factor this out into a common file.

> +static void ibm440ep_clear_uics(void)
> +{
> +	/* Clear the UIC registers so we don't get spurious interrupts
> +	 * in the kernel
> +	 */
> +	mtdcr(DCRN_UIC0_ER, 0x0);
> +	mtdcr(DCRN_UIC0_SR, 0xffffffff);
> +	mtdcr(DCRN_UIC1_ER, 0x0);
> +	mtdcr(DCRN_UIC1_SR, 0xffffffff);
> +}

I don't think we should need this.  As you suggested I added such a
clear to my UIC driver in the kernel proper.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
