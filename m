Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA102DE8B0
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 04:15:15 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m8PIF9l5002059
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:15:10 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8PIF9rD003003
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 13:15:09 -0500 (CDT)
Date: Thu, 25 Sep 2008 13:15:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
Message-ID: <20080925181508.GB4747@ld0162-tx32.am.freescale.net>
References: <20080923203857.GB10935@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080923203857.GB10935@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 10:38:57PM +0200, Sebastian Siewior wrote:
> My current (working) solution is to move cuImage from 4 MiB to 8 MiB.
> Something similar has been done for pSeries in 9b09c6d "powerpc: Change
> the default link address for pSeries zImage kernels". Would it be
> appropriate to move initial address to 64 MiB as the default loading
> address or do we have here some boards which have only 64 MiB of memory?
> Does someone have another idea?

We have at least one supported board with only 8 MiB.  

Some options:
1. Dynamically relocate the wrapper to the top of RAM.
2. Relink based on the uncompressed size of the image bing wrapped.
3. Try to fall back on regular malloc() rather than fail if there's no
vmlinux_alloc() and there's no room at zero.

-Scott
