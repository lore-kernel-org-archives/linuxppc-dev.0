Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3C39DDF6B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:52:46 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2BFqhml009866
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 08:52:43 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2BFqgj8007462
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 10:52:43 -0500 (CDT)
Date: Wed, 11 Mar 2009 10:52:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Update smp support to handle doorbells and
	non-mpic init
Message-ID: <20090311155242.GA11120@ld0162-tx32.am.freescale.net>
References: <1236771963-28181-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236771963-28181-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 06:46:03AM -0500, Kumar Gala wrote:
> +void __init mpc85xx_smp_init(void)
> +{
> +	struct device_node *np;
> +
> +	smp_85xx_ops.message_pass = NULL;
> +
> +	np = of_find_node_by_type(NULL, "open-pic");

We should probably look by compatible rather than device_type.  I see
only one device tree that has the latter but not the former (ksi8560),
and it's not SMP (but should still be fixed, of course).

-Scott
