Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C90367A6C
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2005 17:59:57 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppcdev@qbjnet.com
In-Reply-To: <20050314035131.3098.qmail@kunk.qbjnet.com>
References: <20050314035131.3098.qmail@kunk.qbjnet.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 17:58:45 +1100
Message-Id: <1110783525.19810.280.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: DMA appears broken in 2.6.11 for Mac 7200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-03-14 at 03:51 +0000, linuxppcdev@qbjnet.com wrote:
> Just updated a couple of old Mac 7200 (601) boxen and ran into trouble with
> the ide driver and a promise PDC20267 card. 
> 
> The very same drives and card work fine on a 9500 but hang on a 7200. If
> I set the kernel arg ide=nodma I get in the dmesg:
> ide_setup: ide=nodma : Prevented DMA
> and the 7200 boots and runs fine.
> 
> Another suspect, the mace ethernet driver (which also appears to use DMA)
> doesn't work on the 7200 with 2.6.11 but does with 2.4.28 and it works 
> with 2.6.11 on the 9500.

Interesting. Not sure what's up, though. Those old machines were known
to have bugs relative to cache coherency... also check wetehr we are
setting the cache line size properly in PCI devices. You can also try to
disable use of PCI memory write & invalidate command in all devices.
 
> Finally, I don't think this is related to DMA however the OF frame buffer
> driver, if compiled into the kernel, kills the platinumfb driver which wasn't
> a problem in the 2.4 kernels either (I get a blank screen but the machine
> keeps running).

Ah ? platinumfb alone works, and platinumfb + offb fails ? weird ...

Ben.
