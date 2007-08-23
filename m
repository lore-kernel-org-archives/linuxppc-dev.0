Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71222DDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 17:25:27 +1000 (EST)
Subject: Re: wmb vs mmiowb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20070822045714.GD26374@wotan.suse.de>
References: <20070822045714.GD26374@wotan.suse.de>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 09:25:51 +0200
Message-Id: <1187853952.5972.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ia64@vger.kernel.org,
	Jesse Barnes <jesse.barnes@intel.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-22 at 06:57 +0200, Nick Piggin wrote:

> It doesn't seem like this primary function of mmiowb has anything to do
> with a write barrier that we are used to (it may have a seconary semantic
> of a wmb as well, but let's ignore that for now). A write barrier will
> never provide you with those semantics (writes from 2 CPUs seen in the
> same order by a 3rd party). If anything, I think it is closer to being
> a read barrier issued on behalf of the target device.  But even that I
> think is not much better, because the target is not participating in the
> synchronisation that the CPUs are, so the "read barrier request" could
> still arrive at the device out of order WRT the other CPU's writes.
> 
> It really seems like it is some completely different concept from a
> barrier. And it shows, on the platform where it really matters (sn2), where
> the thing actually spins.

The way mmiowb was actually defined to me by the ia64 folks who came up
with it is essentially to order an MMIO write with a spin_unlock.

Ben.
