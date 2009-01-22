Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC68CDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 16:16:20 +1100 (EST)
Subject: Re: 2.6.29-rc powerpc G5 Xorg legacy_mem regression
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0901212045370.26621@blonde.anvils>
References: <Pine.LNX.4.64.0901212045370.26621@blonde.anvils>
Content-Type: text/plain
Date: Thu, 22 Jan 2009 16:16:10 +1100
Message-Id: <1232601370.23611.98.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Rafael J. Wysocki" <rjw@sisl.pl>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> That's as far as I took it: I can see there's code to set up
> "Legacy VGA memory" but it looks like that's not coming into play.
> dmesg and .config attached: I think you'll get to the point much
> quicker than I would.
> 
> Though I bet you're busy at the moment: no hurry, I can comment
> out the pci_create_legacy_files() from drivers/pci/bus.c for now.

It's actually an X bug :-(

IE, I always create the legacy files, I just make mmap fail when legacy
VGA isn't available. This is the right way to do it, as it properly
informs X that yes, I do support the new API and no, there's no point in
trying to access legacy VGA memory on this machine.

I honestly don't see how I can fix that without making proper support
for legacy memory / IO impossible, and thus guaranteeing that X will
eternally continue to crap on random bits of /dev/mem in the future :-(

Cheers,
Ben.
