Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37A36DDEF2
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 17:26:46 +1000 (EST)
Subject: Re: wmb vs mmiowb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 09:27:15 +0200
Message-Id: <1187854035.5972.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, linux-ia64@vger.kernel.org,
	Jesse Barnes <jesse.barnes@intel.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Of course, the normal memory barrier would usually be a "spin_unlock()" or 
> something like that, not a "wmb()". In fact, I don't think the powerpc 
> implementation (as an example of this) will actually synchronize with 
> anything *but* a spin_unlock().

We are even more sneaky in the sense that we set a per-cpu flag on any
MMIO write and do the sync automatically in spin_unlock() :-)

Ben.
