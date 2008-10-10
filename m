Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB9A9DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 15:51:03 +1100 (EST)
Subject: Re: [RFC] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Siewior <bigeasy@linutronix.de>
In-Reply-To: <20080925214357.GA2929@www.tglx.de>
References: <20080923203857.GB10935@www.tglx.de>
	<200809240146.m8O1kIpZ077447@sullivan.realtime.net>
	<20080925214357.GA2929@www.tglx.de>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 14:58:08 +1100
Message-Id: <1223611088.8157.144.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-25 at 23:43 +0200, Sebastian Siewior wrote:
> * Milton Miller | 2008-09-23 20:46:18 [-0500]:
> 
> >On Wed Sep 24 at about 06:38:57 EST in 2008, Sebastian Siewior wrote:
> >> My mylinux binary incl. bss is ~5 MiB without bss less than 4 MiB.
> >> Therefore I though that I could replace ei.memsize with ei.loadsize. It
> >> didn't work. I'm not sure why it did not work but I guess that the
> >> memset() of bss in the initial kernel code overwrote the cuimage code
> >> which is required for some reason. Maybe some device-tree callbacks.
> >
> >probably because the bss extended beyond the cuboot _end to include
> >where your device tree was copied (just a malloc and we start
> >simple_malloc at the boot _end on most platforms).
> 
> Right, the bss section went past _dtb_start, moving the device tree
> helps.
> 
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>

Please repost in correct form, that is with the changeset comment.

Cheers,
Ben.
