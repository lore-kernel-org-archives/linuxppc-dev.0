Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 29AD02C01D0
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 19:17:12 +1000 (EST)
Message-ID: <1342516619.3669.5.camel@pasglop>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>
Date: Tue, 17 Jul 2012 19:16:59 +1000
In-Reply-To: <20120717055715.GF2369@ram-ThinkPad-T61>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61> <20120717053648.GA18497@shangw>
 <20120717055715.GF2369@ram-ThinkPad-T61>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-17 at 13:57 +0800, Ram Pai wrote:
> Hmm.. this code is not about determining what kind of segment the
> platform is returning. This code is about using the right alignment
> constraints for the type of segment from which resource will be
> allocated. right?
> 
> b_res is the resource that is being sized. b_res already knows
> what kind of resource it is, i.e IORESOURCE_MEM or
> IORESOURCE_PREFETCH.
> Hence we should be exactly using the same alignment constraints as
> that dictated by the type of b_res. no? 

This is unclear.... ideally we want to know which of the host bridge
"apertures" is about to be used...

IE. A prefetchable resource can very well be allocated to a
non-prefetchable window, though the other way isn't supposed to happen.

Additionally, our PHB doesn't actually differenciate prefetchable and
non-prefetchable windows (whether you can prefetch or not is an
attribute of the CPU mapping, but basically non-cachable mappings are
never prefetchable for us).

So we can be lax in how we assign things between our single 32-bit
window divided in 128 segments and our 16x64-bit windows divided in 8
segments (and future HW will do thins differently even).

For example we would like in some cases to use M64's (64-bit windows) to
map SR-IOV BARs regardless of the "prefetchability" though that can only
work if we are not behind a PCIe switch, as those are technically
allowed to prefetch :-)

Worst is that the alignment constraint is based on the segment size, and
while we more/less fix the size of the 32-bit window, we plan to
dynamically allocate/resize the 64-bit ones which will mean variable
segment sizes as well.

So the more information you can get at that point, the better. The type
is useful because it allows us to know if you are trying to put a
prefetchable memory BAR inside a non-prefetchable region, in which case
we know it has to be in M32.

Cheers,
Ben.
