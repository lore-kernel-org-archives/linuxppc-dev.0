Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BB56DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 02:27:17 +1000 (EST)
Subject: Re: wmb vs mmiowb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0708230915000.30176@woody.linux-foundation.org>
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
	<200708221202.12403.jesse.barnes@intel.com>
	<20070823022043.GB18788@wotan.suse.de>
	<alpine.LFD.0.999.0708221953360.30176@woody.linux-foundation.org>
	<20070823042038.GI18788@wotan.suse.de>
	<alpine.LFD.0.999.0708230915000.30176@woody.linux-foundation.org>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 18:27:42 +0200
Message-Id: <1187886462.5972.17.camel@localhost.localdomain>
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

On Thu, 2007-08-23 at 09:16 -0700, Linus Torvalds wrote:
> 
> On Thu, 23 Aug 2007, Nick Piggin wrote:
> > 
> > Also, FWIW, there are some advantages of deferring the mmiowb thingy
> > until the point of unlock.
> 
> And that is exactly what ppc64 does.
> 
> But you're missing a big point: for 99.9% of all hardware, mmiowb() is a 
> total no-op. So when you talk about "advantages", you're not talking about 
> any *real* advantage, are you?

I wonder whether it might be worth removing mmiowb and having all archs
that matter do like ppc64 though... It's just yet another confusing
barrier that most driver writers get wrong..

Cheers,
Ben.
