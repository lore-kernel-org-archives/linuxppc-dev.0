Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1EC55B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 03:37:31 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1498DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 03:37:29 +1000 (EST)
Message-ID: <4A844F6A.1020905@freescale.com>
Date: Thu, 13 Aug 2009 12:37:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Adding MTD concat support to FSL ELBC NAND driver
References: <4A841933.8090808@embedded-sol.com>
In-Reply-To: <4A841933.8090808@embedded-sol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix Radensky wrote:
> Currently concatenation support is implemented in physmap_of driver.
> The syntax used to define a concatenation device involves multiple
> reg tuples, as described in 
> Documentation/powerpc/dts-bindings/mtd-physmap.txt. Will same syntax
> be acceptable for NAND chips ?

I'm not too fond of that -- it would require support in each controller 
driver, and would preclude providing other device-specific information 
in the node (e.g. what if each NAND chip has to sit under a different 
parent node to describe its connection to the system?).  What if a NAND 
controller has multiple reg resources for each chip?  It's not 
memory-like the way NOR flash is.

If we're going to put it in the device tree at all (I suppose for the 
same reason we put partitioning there), it should probably be some 
external construct that glues together flash nodes.

-Scott
