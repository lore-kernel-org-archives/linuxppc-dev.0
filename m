Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 210F5DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 03:29:41 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l7UHTYbr024899
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 10:29:35 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l7UHTYJb004476
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 12:29:34 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l7UH35TX026946
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 12:03:05 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 371A6AEFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 12:29:33 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l7UHTXa2003409
	for linuxppc-dev@ozlabs.org; Thu, 30 Aug 2007 12:29:33 -0500
Date: Thu, 30 Aug 2007 12:29:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Document and implement an improved flash device binding for
	powerpc (v4)
Message-ID: <20070830172932.GA3317@ld0162-tx32.am.freescale.net>
References: <20070830012118.GF22844@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830012118.GF22844@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 11:21:18AM +1000, David Gibson wrote:
> +    For JEDEC compatible devices, the following additional properties
> +    are defined:
> +
> +     - vendor-id : Contains the flash chip's vendor id (1 byte).
> +     - device-id : Contains the flash chip's device id (1 byte).

Are these required, or recommended?

> +    In addition to the information on the flash bank itself, the
> +    device tree may optionally contain additional information
> +    describing partitions of the flash address space.  This can be
> +    used on platforms which have strong conventions about which
> +    portions of the flash are used for what purposes, but which don't
> +    use an on-flash partition table such as RedBoot.
> +
> +    Each partition is represented as a sub-node of the flash device.
> +    Each node's name represents the name of the corresponding
> +    partition of the flash device.

Hmm...  I'm not thrilled with using the node name for this.  For one, the
node name usually functions more as a node type than a label.  It also
means that spaces can't be used in the name, which is fairly common for
existing partition maps.

This might be a good time to introduce a standard "label" property.

-Scott
