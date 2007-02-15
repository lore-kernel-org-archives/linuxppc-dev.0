Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9ACADDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:47:38 +1100 (EST)
In-Reply-To: <1171411219.20192.118.camel@localhost.localdomain>
References: <1171408247467-git-send-email-timur@freescale.com>
	<1171411219.20192.118.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <01b23edfa0a058ae8a119594abb51e01@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c to
	use it
Date: Thu, 15 Feb 2007 21:47:28 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +	return get_property(np, "address", NULL);
>
> Since there is so much room for confusion with "address", please at
> least do some basic sanity checking, like check that it's size is 6
> bytes and maybe that the multicast bit isn't set.

Preferably, don't use "address" at all -- there shouldn't
be any trees in the wild that use it.  If there actually
are some, the should use a quirk to change it to "local-
mac-address" instead.

This holds in general: workarounds for gross errors in
device trees should be applied much more selectively
than is done now, it just doesn't scale this way.


Segher
