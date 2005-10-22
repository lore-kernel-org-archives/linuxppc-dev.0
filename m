Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F66A68623
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 09:04:53 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brad Boyer <flar@allandria.com>
In-Reply-To: <20051022210122.GA9638@pants.nu>
References: <20051022194626.GA3496@suse.de> <20051022210122.GA9638@pants.nu>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 09:00:22 +1000
Message-Id: <1130022023.7919.33.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] dmasound_pmac depends on pmac specific config options
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-10-22 at 14:01 -0700, Brad Boyer wrote:
> On Sat, Oct 22, 2005 at 09:46:26PM +0200, Olaf Hering wrote:
> > 
> > dmasound_pmac should depend on pmac specific .config options.
> > Since PMAC is always defined, but PMAC wont boot without either
> > CUDA or PMU, one of these options indicates that the kernel is
> > for a PowerMac.
> > CONFIG_PM can be selected unconditionally.
> 
> I disagree. I think a much better solution would be to change the
> code to be conditionalized internally on PMU support, rather than
> having #ifdef CONFIG_PM since the functions being called inside
> that protection are actually out of the PMU code, not the generic
> power management system. By doing this, you could for example
> have a kernel compiled for a 1st gen PCI PowerMac without any
> extra drivers. In this case, you have CUDA and AWACS, but there
> is no PMU support and no need for sleep notifiers.

The fix is a longer term issue. dmasound should stop using PMU specific
PM notifiers and those should finally be deprecated. Taht would require
converting dmasound to be a proper macio device, which is a pain, and
while we are at it, finally rewriting dmasound (and/or snd-powermac)
properly which is on my todolist since nobody appears to be up to it.

Ben.
